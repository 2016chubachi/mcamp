require 'test_helper'

class MembersLoginTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
      get login_path
      assert_no_difference 'Member.count' do
        post members_path, member: { name:  "",
                                 email: "user@invalid",
                                 password:              "foo",
                                 password_confirmation: "bar" }
      end
      assert_template 'members/new'
    end


    test "valid signup information" do
    get login_path
    assert_difference 'Member.count', 1 do
      post_via_redirect members_path, member: { name:  "test01",
                                            email: "test01@example.com",
                                            password:              "password123",
                                            password_confirmation: "password123" }
    end
    assert_template 'members/show'
    assert is_logged_in?
  end


  test "login with invalid information" do
      get login_path
      assert_template 'sessions/new'
      post login_path, session: { email: "", password: "" }
      assert_template 'sessions/new'
      assert_not flash.empty?
      get root_path
      assert flash.empty?
  end

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "login with valid information" do
    get login_path
    post login_path, session: { email: @member.email, password: 'password123' }
    assert is_logged_in?
    assert_redirected_to @member
    follow_redirect!
    assert_template 'members/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", member_path(@member)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", member_path(@member), count: 0

  end

  test "login with remembering" do
    log_in_as(@member, remember_me: '1')
    assert_equal FILL_IN, assigns(:user).FILL_IN
  end

  test "login without remembering" do
    log_in_as(@member, remember_me: '0')
    assert_nil cookies['remember_token']
  end

  test "valid login information with account activation" do
    get login_path
    assert_difference 'Member.count', 1 do
      post members_path, member: { name:  "test01",
                               email: "test01@example.com",
                               password:              "password123",
                               password_confirmation: "password123" }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    member = assigns(:member)
    assert_not member.activated?
    # 有効化していない状態でログインしてみる
    log_in_as(member)
    assert_not is_logged_in?
    # 有効化トークンが不正な場合
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # トークンは正しいがメールアドレスが無効な場合
    get edit_account_activation_path(member.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # 有効化トークンが正しい場合
    get edit_account_activation_path(member.activation_token, email: member.email)
    assert member.reload.activated?
    follow_redirect!
    assert_template 'members/show'
    assert is_logged_in?
  end
end
