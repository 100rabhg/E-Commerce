# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_605_130_248) do
  create_table 'active_admin_comments', force: :cascade do |t|
    t.string 'namespace'
    t.text 'body'
    t.string 'resource_type'
    t.integer 'resource_id'
    t.string 'author_type'
    t.integer 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[author_type author_id], name: 'index_active_admin_comments_on_author'
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace'
    t.index %w[resource_type resource_id], name: 'index_active_admin_comments_on_resource'
  end

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'admin_users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'cart_items', force: :cascade do |t|
    t.integer 'quantity'
    t.decimal 'sub_total'
    t.integer 'user_id', null: false
    t.integer 'product_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['product_id'], name: 'index_cart_items_on_product_id'
    t.index ['user_id'], name: 'index_cart_items_on_user_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'devise_api_tokens', force: :cascade do |t|
    t.string 'resource_owner_type', null: false
    t.bigint 'resource_owner_id', null: false
    t.string 'access_token', null: false
    t.string 'refresh_token'
    t.integer 'expires_in', null: false
    t.datetime 'revoked_at'
    t.string 'previous_refresh_token'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['access_token'], name: 'index_devise_api_tokens_on_access_token'
    t.index ['previous_refresh_token'], name: 'index_devise_api_tokens_on_previous_refresh_token'
    t.index ['refresh_token'], name: 'index_devise_api_tokens_on_refresh_token'
    t.index %w[resource_owner_type resource_owner_id], name: 'index_devise_api_tokens_on_resource_owner'
  end

  create_table 'order_items', force: :cascade do |t|
    t.integer 'quantity'
    t.decimal 'sub_total'
    t.integer 'order_id', null: false
    t.integer 'product_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_order_items_on_order_id'
    t.index ['product_id'], name: 'index_order_items_on_product_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.decimal 'total_price'
    t.date 'purchase_date'
    t.integer 'status'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
    t.string 'address'
    t.string 'mobile_number'
    t.string 'pincode'
    t.string 'state'
    t.integer 'payment'
    t.index ['user_id'], name: 'index_orders_on_user_id'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.decimal 'price'
    t.integer 'quantity'
    t.integer 'store_id', null: false
    t.integer 'category_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_products_on_category_id'
    t.index ['store_id'], name: 'index_products_on_store_id'
  end

  create_table 'stores', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_stores_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email', null: false
    t.string 'encrypted_password', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'role'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'cart_items', 'products'
  add_foreign_key 'cart_items', 'users'
  add_foreign_key 'order_items', 'orders'
  add_foreign_key 'order_items', 'products'
  add_foreign_key 'orders', 'users'
  add_foreign_key 'products', 'categories'
  add_foreign_key 'products', 'stores'
  add_foreign_key 'stores', 'users'
end
