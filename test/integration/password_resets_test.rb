require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
    def setup
      ActionMailer::Base.deliveries.clear
      @member = members(:aprisun)
    end

    test "password resets" do
      get new_password_reset_path
      assert_template 'password_resets/new'
      # メールアドレスが無効
      post password_resets_path, password_reset: { email: "" }
      assert_not flash.empty?
      assert_template 'password_resets/new'
      # メールアドレスが有効
      post password_resets_path, password_reset: { email: @member.email }
      assert_not_equal @member.reset_digest, @member.reload.reset_digest
      assert_equal 1, ActionMailer::Base.deliveries.size
      assert_not flash.empty?
      assert_redirected_to root_url
      # パスワード再設定用フォーム
      member = assigns(:member)
      # メールアドレスが無効
      get edit_password_reset_path(user.reset_token, email: "")
      assert_redirected_to root_url
      # 無効なユーザー
      member.toggle!(:activated)
      get edit_password_reset_path(member.reset_token, email: member.email)
      assert_redirected_to root_url
      member.toggle!(:activated)
      # メールアドレスが正しく、トークンが無効
      get edit_password_reset_path('wrong token', email: member.email)
      assert_redirected_to root_url
      # メールアドレスもトークンも有効
      get edit_password_reset_path(member.reset_token, email: member.email)
      assert_template 'password_resets/edit'
      assert_select "input[name=email][type=hidden][value=?]", member.email
      # 無効なパスワードと確認
      patch password_reset_path(member.reset_token),
            email: member.email,
            member: { password:              "password123",
                    password_confirmation: "password123" }
      assert_select 'div#error_explanation'
      # パスワードが空
      patch password_reset_path(member.reset_token),
            email: member.email,
            member: { password:              "",
                    password_confirmation: "" }
      assert_select 'div#error_explanation'
      # 有効なパスワードと確認
      patch password_reset_path(member.reset_token),
            email: member.email,
            member: { password:              "password123",
                    password_confirmation: "password123" }
      assert is_logged_in?
      assert_not flash.empty?
      assert_redirected_to member
    end

  test "expired token" do
    get new_password_reset_path
    post password_resets_path, password_reset: { email: @member.email }

    @member = assigns(:member)
    @member.update_attribute(:reset_sent_at, 3.hours.ago)
    patch password_reset_path(@member.reset_token),
          email: @member.email,
          member: { password:              "password123",
                  password_confirmation: "password123" }
    assert_response :redirect
    follow_redirect!
    assert_match /FILL_IN/i, response.body
  end
end
