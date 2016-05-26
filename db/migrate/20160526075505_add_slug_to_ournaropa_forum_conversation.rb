class AddSlugToOurnaropaForumConversation < ActiveRecord::Migration
  def change
    add_column :ournaropa_forum_conversations, :slug, :string
    add_index :ournaropa_forum_conversations, :slug, unique: true
    OurnaropaForum::Conversation.find_each(&:save)
  end
end
