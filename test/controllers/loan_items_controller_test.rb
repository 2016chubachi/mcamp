require 'test_helper'

class LoanItemsControllerTest < ActionController::TestCase
  # 各テストケース前に実行
  def setup

  end

  # 各テストケース後に実行
  def teardown

  end

  #ログインしない状態で、貸すアイテム一覧表示テスト
  test "index before logged in" do
    get :index
    assert_response :redirect
    assert_redirected_to :login
  end

  #ログインした後、貸すアイテム一覧表示テスト
  test "index after logged in" do
    #user1のデータを取得
    member = members(:member_1)
    #user1でログインする
    log_in_as(member)

    get :index
    assert_response :success,"index action 失敗しました。"
    # assignsに入れる値はapp/views/loan_items/index.html.erbの変数
    assert_equal 5,assigns(:loan_items).count,"貸すアイテム取得件数不正"
    assert_template "index","indexテンプレートではない"
  end

  #ログインしない状態で、貸すアイテム詳細テスト。詳細はログインしなくても見える
  test "show before logged in" do
    loanitem = loan_items(:loan_item_1)
    # get :show, id: loanitem
    get :show,{:id => loanitem.id}
    assert_response :success,"show action 失敗しました。"
  end

  #ログインしない状態で、貸すアイテム登録画面表示テスト
  test "new before logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to :login
  end

  #ログインした後、貸すアイテム登録画面表示テスト
  test "new after logged in" do
    #user1のデータを取得
    member = members(:member_1)
    #user1でログインする
    log_in_as(member)

    get :new
    assert_response :success,"new action 失敗しました。"
  end

  #ログインした後、貸すアイテム登録画面から新規データ登録テスト(成功)
  test "create after logged in" do
    #user1のデータを取得
    member = members(:member_1)
    #user1でログインする
    log_in_as(member)
    post :create, loan_item: {item_name: "test1"}
    loanitem = LoanItem.order(:id).last
    assert_redirected_to loanitem
  end

  #ログインした後、貸すアイテム登録画面から新規データ登録テスト（失敗）
  test "fail to create after logged in" do
    #user1のデータを取得
    member = members(:member_1)
    #user1でログインする
    log_in_as(member)
    post :create, loan_item: {item_name: "test1", fare: -1}
    loanitem = LoanItem.order(:id).last
    #validationで保存できない時はsuccess(200)が帰る
    assert_response :success
    assert_template "new", "newテンプレートではない"
  end

  test "update after logged in" do
    #user1のデータを取得
    member = members(:member_1)
    #user1でログインする
    log_in_as(member)
    # binding.pry
    # put :update, :id => loan_items(:loan_item_1), :loan_item => {:item_name => 'MyString2'}
    # 上の行と同じ内容（書き方を:createと合わせただけ）
    put :update, id: loan_items(:loan_item_1), loan_item: {item_name: 'MyString2'}
    # binding.pry
    assert_equal "MyString2",assigns(:loan_item).item_name
    assert_redirected_to loan_items(:loan_item_1)
  end

  test "fail to update after logged in" do
    #user1のデータを取得
    member = members(:member_1)
    #user1でログインする
    log_in_as(member)
    # binding.pry
    # put :update, :id => loan_items(:loan_item_1), :loan_item => {:item_name => 'MyString2'}
    # item_nameを''にしてvalidationに引っかかるようにする。validationで更新できない時はsuccess(200)が帰る
    put :update, id: loan_items(:loan_item_1), loan_item: {item_name: ''}
    # binding.pry
    assert_response :success
    assert_template "edit", "editテンプレートではない"
  end

  test "edit after logged in" do
    #user1のデータを取得
    member = members(:member_1)
    #user1でログインする
    log_in_as(member)
    loanitem = loan_items(:loan_item_1)
    # binding.pry
    get :edit, id: loanitem
    assert_response :success
    assert_template "edit", "editテンプレートではない"
  end

  test "destroy after logged in" do
    #user1のデータを取得
    member = members(:member_1)
    #user1でログインする
    log_in_as(member)
    loanitem = loan_items(:loan_item_1)
    delete :destroy, id: loanitem
    #削除されていればActiveRecord::RecordNotFoundが発生する
    assert_raises(ActiveRecord::RecordNotFound) {LoanItem.find(loanitem.id)}
    assert_redirected_to :loan_items
  end

end
