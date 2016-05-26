class AddIsReceivingInactivityEmailInactivityEmailSentAtSeenAtToOurnaropaForumUser < ActiveRecord::Migration
  def change
    add_column :ournaropa_forum_users, :is_receiving_inactivity_email, :boolean, null: false, default: true
    add_column :ournaropa_forum_users, :inactivity_email_sent_at, :datetime, null: true
    add_column :ournaropa_forum_users, :seen_at, :datetime, null: true
  end
end
