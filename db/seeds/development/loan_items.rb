item_names = ["BBQコンロ","シュノーケルセット","テント", "ランタン"]
fares = %w(0 500 1000 2000)
locations = ["神奈川県川崎市", "神奈川県横浜市", "東京都世田谷区", "東京都調布市"]

0.upto(9) do |idx|
  LoanItem.create(
    item_name: item_names[idx % 4] + "#{idx}",
    member_id:  (idx % 4) + 1,
    category_id: (idx % 2) + 1,
    fare: fares[idx % 4],
    location: locations[idx % 4],
    loan_state_id: 1,
    delete_flg: false
  )
end

# LoanItem.create(item_name: "BBQコンロ1",member_id: 1,category_id: 1,item_description: "コールマンBBQコンロ",
#     fare: 1000,term: "aaaaaa",location: "bbbbbb",loan_state_id: 1,delete_flg: false)
