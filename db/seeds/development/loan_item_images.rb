#貸すアイテム画像
0.upto(9) do |idx|
  path = Rails.root.join("db/seeds", Rails.env, "sample#{idx % 4 + 1}.jpg")
  file = Rack::Test::UploadedFile.new(path, "image/jpeg", true)
  LoanItemImage.create(
    loan_item_id: idx + 1,
    uploaded_image: file
  )
end

#uploaded_imageの実装ができていないときは下記のようにしてテストデータを作る
#path = Rails.root.join("db/seeds/development", "sample1.jpg")
#readでバイナリーにする
#file = Rack::Test::UploadedFile.new(path, "image/jpeg", true).read
#LoanItemImage.create(loan_item_id: 1, image: file, content_type: "image/jpeg")
