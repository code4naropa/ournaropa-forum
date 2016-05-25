class AddShareEmailToUser < ActiveRecord::Migration
  def change
    add_column :ournaropa_forum_users, :share_email, :boolean, null: false, default: false
  end
end
