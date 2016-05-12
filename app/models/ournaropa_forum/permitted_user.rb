module OurnaropaForum
  class PermittedUser < ActiveRecord::Base
    
    def self.available_roles
      return ["Incoming Student", "Current Student", "Staff"]
    end
    
    validates_presence_of :first_name, :last_name
    validates_format_of :email, with: /.+@.+/
    validates_uniqueness_of :email
    validates_inclusion_of :role, in: OurnaropaForum::PermittedUser.available_roles
    
    # make email lowercase
    before_save do
      self.email.downcase!
    end
    
  end
end
