# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#貸出アイテム状態
LoanState.create([{name: '貸出可能'},{name: '申込中'},{name: '貸出中'}])

#メッセージ状態
MessageState.create([{name: '承認待ち'},{name: '承認済み'},{name: '拒否済み'},{name: '取消済み'}])

#借りたい
BorrowState.create([{name: '募集中'},{name: '締切'}])

#年代
Generation.create([{name: '10代'},{name: '20代'},{name: '30代'},{name: '40代'},{name: '50代'},{name: '60代'},{name: '60代以上'}])

#権限マスタ
Authority.create([{name: '普通'},{name: '管理者'},{name: '広告ユーザ'}])

#業界マスタ
Business.create([{name: '金融'},{name: '製造'},{name: '流通'}])

#よくある質問
Question.create([{classification: 'サイトにつて'}])

#書込み状態
PostState.create([{name: '進行中'},{name: '完了済'}])

#書込タイプ
PostKind.create([{name: 'BBQ'},{name: '物々交換'}])

#アイテムカテゴリー
Category.create([{name: 'キャンプ用品'},{name: 'BBQ用品'}])

#ユーザー
#User.create(email: "dammy@aiit.co.jp",password: "dammy",user_name: "dammy")
Member.create(email: "dammy@aiit.co.jp",password: "dammy",user_name: "dammy")

#貸すアイテム
LoanItem.create(item_name: "BBQコンロ",user_id: 1,category_id: 1,item_description: "コールマンBBQコンロ",fare: 1000,term: "aaaaaa",location: "bbbbbb",loan_state_id: 1,delete_flg: false)

#貸すアイテム画像
path = Rails.root.join("db/seeds/development", "sample1.jpg")
#readでバイナリーにする
file = Rack::Test::UploadedFile.new(path, "image/jpeg", true).read
LoanItemImage.create(loan_item_id: 1, image: file, content_type: "image/jpeg")

#借りたいアイテム
BorrowItem.create(item_name: "キャンプ",user_id: 1,category_id: 1,item_description: "キャンプ説明",fare: 1000,term: "aaaaaa",location: "bbbbbb",borrow_state_id: 1,delete_flg: false)

#借りたい返事
BorrowReply.create(borrow_item_id: 1,user_id: 1,message: "貸してください",message_state_id: 1,delete_flg: false)
