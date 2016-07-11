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
    get :edit,{:id => loanitem.id}
    assert_response :redirect
    assert_redirected_to :login
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
    get :edit,{:id => loanitem.id}
    assert_response :success,"edit action 失敗しました。"
    assert_equal 1,assigns(:loanItem).requests.count,"リクエスト件数不正"
    assert_template "edit","editテンプレートではない"
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
    #関連付けのやり方
    # loanitem.requests.build({:loan_item => loanitem,:member => member,
    #           :message => "テストメッセージ",
    #           :message_state => message_states(:message_state_1),
    #           :delete_flg => false
    # })
    # #リクエスト送信用パラメータ作成
    # paramsArr = loanitem.attributes
    # requestArr= {}
    # newRequest = nil
    # loanitem.requests.each_with_index do |val,index|
    #   requestArr[index.to_s] = val.attributes
    #   newRequest = val if val.new_record?
    # end
    # paramsArr["requests_attributes"]=requestArr
    #無関係のやり方
    newRequest = Request.new({:loan_item => loanitem,:member => member,
              :message => "テストメッセージ",
              :message_state => message_states(:message_state_1),
              :delete_flg => false
    })
    paramsArr = loanitem.attributes
    paramsArr[:request] = newRequest.attributes
    #リクエスト送信
    patch :update,id: loanitem.id,loan_item: paramsArr
    assert_response :success,"update action 失敗しました。"
    assert_template :edit,"editテンプレートではない"
    assert_equal 6,Request.all.count,"リクエスト件数不正"
    assert_equal newRequest.message,Request.last.message,"リクエスト送信失敗"
    assert_equal 2,LoanItem.find(loanitem).loan_state.id

  end

end
