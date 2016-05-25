class AddShareEmailToUserInfos < ActiveRecord::Migration
  def change
    add_column :ournaropa_forum_user_infos, :share_email, :boolean, null: false, default: false
  end
end
