module OurnaropaForum
  class Conversation < ActiveRecord::Base
    
    has_many :replies
    belongs_to :author, class_name: "User"
    has_and_belongs_to_many :subscriptions, :class_name => "User"
    
    validates_presence_of :title, :body, :author_id
    
    after_create do
      self.subscriptions << self.author
    end
    
  end
end
