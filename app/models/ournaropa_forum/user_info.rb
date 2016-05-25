module OurnaropaForum
  class UserInfo < ActiveRecord::Base
    belongs_to :user
        
    attr_accessor :first_name, :last_name
    attr_accessor :email
    
    validates_presence_of :first_name, :last_name, on: :update
    
    # PAPERCLIP
    has_attached_file :avatar, styles: { large: "300x300#", standard: "80x80#" }, default_url: "/images/:style/missing.png"
    validates_with AttachmentContentTypeValidator, attributes: :avatar, content_type: /\Aimage\/.*\Z/
    validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 2.megabytes
    
    # Init first name and last name from user this info belongs to
    after_initialize do
      if self.user.present?
        self.first_name = self.user.first_name unless self.first_name.present?
        self.last_name = self.user.last_name unless self.last_name.present?
        self.email = self.user.email unless self.email.present?
      end
    end
  
    # after update, set first_name and last_name of user
    after_update do
      self.user.update_attributes(:first_name => self.first_name, :last_name => self.last_name)
    end
    
  end
end
