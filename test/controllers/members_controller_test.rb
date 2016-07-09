require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  def setup
    @member = members(:aprisun)
    @other_member = members(:test01)

  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @member
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @member, member: { name: @member.name, email: @member.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_member)
    get :edit, id: @member
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_member)
    patch :update, id: @member, member: { name: @member.name, email: @member.email }
    assert flash.empty?
    assert_redirected_to root_url
end



end
