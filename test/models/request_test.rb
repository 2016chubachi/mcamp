require 'test_helper'

class RequestTest < ActiveSupport::TestCase
   # presenceバリデーションチェック
   test "presence" do
      request = Request.new
      request.message_state_id = nil
      assert request.invalid?,"requestモデルの必須バリデーション設定不備有"
      assert request.errors.include?(:message),"messageの必須チェック不備"
      assert request.errors.include?(:message_state_id),"message_state_idの必須チェック不備"
      assert request.errors.include?(:loan_item_id),"loan_item_idの必須チェック不備"
   end
   
   # 長さバリデーションチェック
   test "length" do
      # fixturesフォルダーの「requests」ファイルのデータ件数を取得
      # モデル名を使う
      count = Request.count
      # fixturesフォルダーの「requests」ファイルの「one」のデータを読込
      request = requests(:request_1)
      #binding.pry
      request.message = "a"*501
      
      assert_equal 5,count,"requestsのデータ設定件数が一致しない"
      assert request.invalid?,"requestモデルの最大長バリデーション設定不備有"
      assert request.errors.include?(:message),"messageの最大長チェック不備"
   end
end
