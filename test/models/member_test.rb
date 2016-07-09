require 'test_helper'

class MemberTest < ActiveSupport::TestCase
    def setup
      @member = Member.new(name: "test01", email: "test01@example.com",
                      password: "redhat123", password_confirmation: "redhat123")
    end

    test "should be valid" do
       assert_not @member.valid?
    end

    test "name should be present" do
      @member.name = "     "
      assert_not @member.valid?
    end

    test "email should be present" do
      @member.email = "     "
      assert_not @member.valid?
    end

    test "name should not be too long" do
      @member.name = "a" * 21
      assert_not @member.valid?
    end

    test "email should not be too long" do
      @member.email = "a" * 20 + "@example.com"
      assert_not @member.valid?
    end

      test "email validation should accept valid addresses" do
        valid_addresses = %w[user@example,com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          @member.email = valid_address
          assert_not @member.valid?, "#{valid_address.inspect} should be valid"
        end
      end

    test "email addresses should be unique" do
      duplicate_member = @member.dup
      duplicate_member.email = @member.email.upcase
      @member.save
      assert_not duplicate_member.valid?
    end

    test "password should be present (nonblank)" do
      @member.password = @member.password_confirmation = " " * 8
      assert_not @member.valid?
    end

    test "password should have a minimum length" do
       @member.password = @member.password_confirmation = "a" * 8
       assert_not @member.valid?
    end

    test "user_name should be present" do
      @member.user_name = "     "
      assert_not @member.valid?
    end

    test "user_name should be unique" do
      duplicate_member = @member.dup
      duplicate_member.user_name = @member.user_name
      @member.save
      assert_not duplicate_member.valid?
    end

    # test "email addresses should be saved as lower-case" do
    #   mixed_case_email = "Test01@ExAMPle.CoM"
    #   @member.email = mixed_case_email
    #   @member.save
    #   assert_equal mixed_case_email.downcase, @member.reload.email
    # end

    test "authenticated? should return false for a user with nil digest" do
      assert_not @member.authenticated?(:remember, '')
    end




end
