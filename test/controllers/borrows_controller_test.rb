require 'test_helper'

class BorrowsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get detail" do
    get :detail
    assert_response :success
  end

end
