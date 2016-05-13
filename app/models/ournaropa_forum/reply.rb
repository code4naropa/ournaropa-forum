module OurnaropaForum
  class Reply < ActiveRecord::Base
    
    belongs_to :conversation
    belongs_to :author, class_name: 'User'
    
    validates_presence_of :body, :author, :conversation
    
    # update conversation time
    after_create do
      self.conversation.touch
      self.conversation.subscriptions << self.author unless self.conversation.subscriptions.exists?(self.author.id)
    end
  end
end
