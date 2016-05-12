class CreateOurnaropaForumPermittedUsers < ActiveRecord::Migration
  def change
    create_table :ournaropa_forum_permitted_users, id: :uuid do |t|
      t.string :email
      t.string :name
      t.string :role
      t.boolean :has_signed_up, default: false, null: false

      t.timestamps null: false
    end
    add_index :ournaropa_forum_permitted_users, :email, unique: true
  end
end
