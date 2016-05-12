class CreateOurnaropaForumUserInfos < ActiveRecord::Migration
  def change
    create_table :ournaropa_forum_user_infos do |t|
      t.string :hometown, null: true
      t.string :major, null: true
      t.string :age, null: true
      t.text :description, null: true
      t.boolean :show_email, null: false, default: false
      t.uuid :user_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
