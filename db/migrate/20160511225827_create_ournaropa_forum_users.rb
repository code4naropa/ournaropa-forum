class CreateOurnaropaForumUsers < ActiveRecord::Migration
  def change
    create_table :ournaropa_forum_users, id: :uuid do |t|
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
      t.string :role
      t.string :password_hash, null: false
      t.string :reset_token
      t.boolean :is_superuser, default: false, null: false

      t.timestamps null: false
    end
    add_index :ournaropa_forum_users, :email, unique: true
  end
end
