class CreateOurnaropaForumConversations < ActiveRecord::Migration

  enable_extension 'uuid-ossp'
  
  def change
    create_table :ournaropa_forum_conversations, id: :uuid do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.uuid :author_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
