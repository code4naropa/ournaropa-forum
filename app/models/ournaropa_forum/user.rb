module OurnaropaForum
  
  require 'bcrypt'
  
  class User < ActiveRecord::Base
    include BCrypt

    has_one :info, class_name: "UserInfo"
    has_many :conversations, foreign_key: 'author_id'
    has_many :replies, foreign_key: 'author_id'
    
    validates_uniqueness_of :email
    validates_presence_of :first_name, :last_name, :email, :password_hash
    
    validate :user_is_permitted_to_signup, on: :create
    
    def user_is_permitted_to_signup
      if self.email.present?
        p_user = PermittedUser.find_by email: self.email
        errors.add(:email, "is not associated with an account") unless p_user
        errors.add(:email, "is already signed up") unless not p_user.has_signed_up
      end
    end
    
    def name
      return self.first_name
    end
    
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
      
      # Create User Info
      UserInfo.create(:user => self)
      
      # Update Permitted User
      p_user = PermittedUser.find_by email: self.email
      p_user.update_attributes(:has_signed_up => true)
      
    end
    
    
    def self.generate_reset_token
      return SecureRandom.hex(2).upcase + "-" + SecureRandom.hex(2).upcase + "-" + SecureRandom.hex(2).upcase + "-" + SecureRandom.hex(2).upcase
    end
    
  end
end
