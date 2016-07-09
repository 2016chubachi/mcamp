require 'test_helper'

class MembersEditTest < ActionDispatch::IntegrationTest
  def setup
    @member = members(:test01)
  end

  test "unsuccessful edit" do
    log_in_as(@member)
    get edit_member_path(@member)
    assert_template 'members/edit'
    patch member_path(@member), member: { name:  "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'members/edit'
  end


  test "successful edit" do
    log_in_as(@member)
    get edit_member_path(@member)
    assert_template 'members/edit'
    name  = "test01"
    email = "foo@bar.com"
    patch member_path(@member), member: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @member
    @member.reload
    assert_equal name,  @member.name
    assert_equal email, @member.email
  end

  test "successful edit with friendly forwarding" do
    get edit_member_path(@member)
    log_in_as(@member)
    assert_redirected_to edit_member_path(@member)
    name  = "test01"
    email = "test01@example.com"
    patch member_path(@member), member: { name:  name,
                                  email: email,
                                  password:              "",
                                  password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @member
    @member.reload
    assert_equal name,  @member.name
    assert_equal email, @member.email
  end

end
