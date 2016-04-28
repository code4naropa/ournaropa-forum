class CreateOurnaropaForumConversations < ActiveRecord::Migration

  enable_extension 'uuid-ossp'
  
  def change
    create_table :ournaropa_forum_conversations, id: :uuid do |t|
      t.string :title, :null => false
      t.text :body, :null => false
      t.integer :author_id, :null => false

      t.timestamps null: false
    end
  end
end
