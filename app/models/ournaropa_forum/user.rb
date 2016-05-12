module OurnaropaForum
  
  require 'bcrypt'
  
  class User < ActiveRecord::Base
    include BCrypt

    validates_uniqueness_of :email
    validates_presence_of :name, :email
    
    def password
      @password ||= Password.new(password_hash)
    end

    def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    end
    
    def authenticate password
      return self.password == password
    end

    before_save do
      self.email.downcase!
    end
    
    after_create do
      p_user = PermittedUser.find_by email: self.email
      p_user.update_attributes(:has_signed_up => true)
    end
    
  end
end
