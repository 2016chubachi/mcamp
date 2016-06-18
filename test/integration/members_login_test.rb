require 'test_helper'

class MembersLoginTest < ActionDispatch::IntegrationTest

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
    @member = members(:michael)
  end

  test "login with valid information" do
    get login_path
    post login_path, session: { email: @member.email, password: 'password' }
    assert_redirected_to @member
    follow_redirect!
    assert_template 'members/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "login with remembering" do
    log_in_as(@member, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@member, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
