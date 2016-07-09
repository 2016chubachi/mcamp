require 'test_helper'

class MembersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @member = members(:aprisun)
  end

  test "index including pagination" do
    log_in_as(@member)
    get members_path
    assert_template 'members/index'
#    assert_select 'div.pagination'
    Member.paginate(page: 1).each do |member|
      assert_select 'a[href=?]', member_path(member), text: member.name
    end
  end
end
