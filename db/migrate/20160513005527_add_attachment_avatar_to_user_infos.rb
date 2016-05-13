class AddAttachmentAvatarToUserInfos < ActiveRecord::Migration
  def self.up
    change_table :ournaropa_forum_user_infos do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :ournaropa_forum_user_infos, :avatar
  end
end
