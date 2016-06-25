table_names = %w(loan_states message_states borrow_states generations
 authorities businesses generations post_states post_kinds members loan_items
 loan_item_images)
# table_names = %w(loan_items loan_item_images)
# table_names = %w(loan_item_images)

table_names.each do |table_name|
  path = Rails.root.join("db/seeds", Rails.env, table_name + ".rb")
  if File.exist?(path)
    puts "Creating #{table_name}..."
    require path
  end
end
