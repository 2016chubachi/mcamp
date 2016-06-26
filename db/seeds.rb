#データを作成したいテーブルの名称を記述
#データの作成は以下のファイルに作成
#db/seeds/環境(development, production)/テーブル名称.rb
#
table_names = %w(loan_states message_states borrow_states
 generations authorities businesses questions post_states
 post_kinds categories members loan_items loan_item_images
 borrow_items)
# table_names = %w(loan_items loan_item_images)
# #table_names = %w(borrow_items)

table_names.each do |table_name|
  path = Rails.root.join("db/seeds", Rails.env, table_name + ".rb")
  if File.exist?(path)
    puts "Creating #{table_name}..."
    require path
  end
end
