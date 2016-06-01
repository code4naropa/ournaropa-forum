class AddIsDeveloperToOurnaropaForumUsers < ActiveRecord::Migration
  def change
    add_column :ournaropa_forum_users, :is_developer, :boolean, default: false, null: false
  end
end
