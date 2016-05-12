class CreateOurnaropaForumReplies < ActiveRecord::Migration
  
  def change
    create_table :ournaropa_forum_replies do |t|
      t.string :title
      t.text :body
      t.uuid :author_id, index: true, foreign_key: true
      t.uuid :conversation_id, index: true, foreign_key: true

      t.timestamps null: false
    end
    
    #add_index :ournaropa_forum_replies, :conversation_id, name: :idx_onf_conversation
    
  end
end
