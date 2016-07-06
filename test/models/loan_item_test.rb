require 'test_helper'

class LoanItemTest < ActiveSupport::TestCase
  # presenceバリデーションチェック
  # item_nameは必須項目。Newした後に invalid?= trueになると必須項目チェックが正しく
  # 動いていることが確認できる
  test "presence" do
    loan_item = LoanItem.new
    assert loan_item.invalid? ,"LoanItemモデルの必須バリデーション設定不備有"
    assert loan_item.errors.include?(:item_name), "item_nameの必須チェック不備"
    # p loan_item.errors.full_messages
  end

  #基本料金のチェック
  test "fare" do
    loan_item1 = LoanItem.new(item_name: "test1", fare: -100)
    loan_item2 = LoanItem.new(item_name: "test2", fare: 9.9)
    assert loan_item1.invalid?  ,"LoanItemモデルの必須バリデーション設定不備有"
    assert loan_item1.errors.include?(:fare), "fareの正数チェック不備"
    assert loan_item2.invalid?  ,"LoanItemモデルの必須バリデーション設定不備有"
    assert loan_item2.errors.include?(:fare), "fareの正数チェック不備"
    # p loan_item2.errors.full_messages
  end
end
