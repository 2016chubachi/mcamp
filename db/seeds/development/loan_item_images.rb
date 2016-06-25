0.upto(9) do |idx|
  path = Rails.root.join("db/seeds/development", "sample#{idx % 4 + 1}.jpg")
  file = Rack::Test::UploadedFile.new(path, "image/jpeg", true)
  LoanItemImage.create(
    loan_item_id: idx + 1,
    uploaded_image: file
  )
end
