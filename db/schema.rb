# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160612091358) do

  create_table "ad_users", force: :cascade do |t|
    t.string   "company"
    t.string   "email"
    t.string   "password"
    t.integer  "authority_id"
    t.integer  "point"
    t.integer  "business_id"
    t.string   "user_name"
    t.binary   "avator"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "ads", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "link"
    t.integer  "ad_user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "authorities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "borrow_items", force: :cascade do |t|
    t.string   "item_name"
    t.integer  "member_id"
    t.integer  "category_id"
    t.text     "item_description"
    t.integer  "fare"
    t.text     "term"
    t.string   "location"
    t.integer  "borrow_state_id",  default: 1
    t.boolean  "delete_flg",       default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "borrow_replies", force: :cascade do |t|
    t.integer  "borrow_item_id"
    t.integer  "member_id"
    t.text     "message"
    t.integer  "message_state_id"
    t.boolean  "delete_flg"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "borrow_reply_images", force: :cascade do |t|
    t.integer  "borrow_reply_id"
    t.binary   "image"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "borrow_states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "businesses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enquiry_infos", force: :cascade do |t|
    t.string   "title"
    t.string   "enquiry_content"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "generations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loan_item_images", force: :cascade do |t|
    t.integer  "loan_item_id"
    t.binary   "image"
    t.string   "content_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "loan_items", force: :cascade do |t|
    t.string   "item_name"
    t.integer  "member_id"
    t.integer  "category_id"
    t.text     "item_description"
    t.integer  "fare",             default: 0
    t.text     "term"
    t.text     "location"
    t.integer  "loan_state_id"
    t.boolean  "delete_flg",       default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "loan_states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.integer  "authority_id"
    t.integer  "point"
    t.integer  "gender"
    t.string   "self_introduction"
    t.integer  "generation_id"
    t.string   "user_name"
    t.binary   "avator"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "message_states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_images", force: :cascade do |t|
    t.integer  "post_id"
    t.binary   "image"
    t.integer  "post_kind_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "post_kinds", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_replies", force: :cascade do |t|
    t.integer  "post_id"
    t.string   "title"
    t.text     "content"
    t.integer  "member_id"
    t.boolean  "delete_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_reply_images", force: :cascade do |t|
    t.integer  "post_reply_id"
    t.binary   "image"
    t.integer  "post_kind_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "post_states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "member_id"
    t.integer  "post_state_id"
    t.boolean  "delete_flg"
    t.integer  "post_kind_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "question_details", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "question"
    t.text     "answer"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "classification"
    t.string   "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "loan_item_id"
    t.integer  "member_id"
    t.text     "message"
    t.integer  "message_state_id", default: 1
    t.boolean  "delete_flg",       default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

end
