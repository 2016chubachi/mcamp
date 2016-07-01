require 'test_helper'

class BorrowsControllerTest < ActionController::TestCase
  
  # 各テストケース前に実行
  def setup
    
  end
  
  # 各テストケース後に実行
  def teardown
    
  end
  
  #借りるアイテム一覧表示テスト
  test "should get index" do
    get :index
    assert_response :success,"index action 失敗しました。"
    assert_equal 20,assigns(:loanItems).count,"貸出アイテム取得件数不正"
    assert_template "index","indexテンプレートではない"
  end
  
  #ログインしていないまま、借りる詳細画面表示テスト
  test "should get show is not login" do
    loanitem = loan_items(:loan_item_1)
    get :show,{:id => loanitem.id}
    assert_response :success,"show action 失敗しました。"
    assert_equal 1,assigns(:loanItem).requests.count,"リクエスト件数不正"
    assert_template "show","showテンプレートではない"
  end
  
  #ログインした後、借りる詳細画面表示テスト
  test "should get show is logined" do
    #user1のデータを取得
    member = members(:member_1)
    #user1でログインする
    log_in_as(member)
    #貸出アイテム1を取得
    loanitem = loan_items(:loan_item_1)
    
    #貸出アイテム７の借りる詳細画面に遷移
    get :show,{:id => loanitem.id}
    assert_response :success,"show action 失敗しました。"
    assert_equal 1,assigns(:loanItem).requests.count,"リクエスト件数不正"
    assert_template "show","showテンプレートではない"
  end
  
  #ログインしていないまま、メッセージを送信するテスト
  test "should get update is not login" do
    #アイテム６のデータ取得
    loanitem = loan_items(:loan_item_6)
    patch :update,id: loanitem.id,loan_item: {}
    assert_response :redirect
    assert_redirected_to :login
  end
  
  #ログインしていないまま、メッセージを送信するテスト
  test "should get update is logined" do
    #user1のデータを取得
    member = members(:member_1)
    #user1でログインする
    log_in_as(member)
    #アイテム６のデータ取得
    loanitem = loan_items(:loan_item_6)
    newrequest = Request.new
    newrequest.loan_item_id = loanitem.id
    newrequest.message = "テストメッセージ"
    loanitem.requests << newrequest
    paramsArr = []
    paramsArr << {requests_attributes: [:loan_item_id => newrequest.loan_item_id,:member_id => member.id,:message => newrequest.message,:message_state_id => 1,:delete_flg => false]}
    patch :update,id: loanitem.id,loan_item: paramsArr
    assert_response :success
    #assert_redirected_to :login
    #{"loan_item"=>
    #{"requests_attributes"=>
    #{"1"=>{"message"=>"test", "member_id"=>"3", "message_state_id"=>"4", "delete_flg"=>"false", "id"=>"10"},
    # "2"=>{"message"=>"aaaaaa", "member_id"=>"3", "message_state_id"=>"1", "delete_flg"=>"false"}}}
    #}
  end

end
