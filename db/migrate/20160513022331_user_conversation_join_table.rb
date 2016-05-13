class UserConversationJoinTable < ActiveRecord::Migration
  def change
    create_table :ournaropa_forum_conversations_users do |t|
      t.uuid :user_id, index: true, foreign_key: true
      t.uuid :conversation_id, index: true, foreign_key: true
    end
  end
end
