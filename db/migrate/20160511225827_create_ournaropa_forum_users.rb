class CreateOurnaropaForumUsers < ActiveRecord::Migration
  def change
    create_table :ournaropa_forum_users, id: :uuid do |t|
      t.string :email
      t.string :name
      t.string :password_hash
      t.string :reset_token

      t.timestamps null: false
    end
    add_index :ournaropa_forum_users, :email, unique: true
  end
end
