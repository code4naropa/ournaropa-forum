module OurnaropaForum
  class Reply < ActiveRecord::Base
    
    belongs_to :conversation
    belongs_to :author, class_name: 'User'
    
    validates_presence_of :body, :author, :conversation
    
    # update conversation time & manage subscription
    after_create do
      
      # update updated_at attribute of conversation
      self.conversation.touch
      
      # subscribe user if this is the first post in this conversation. Otherwise, leave everything as is!
      if self.conversation.replies.where(author: self.author).count == 1 and not self.conversation.author.id == self.author.id
        self.conversation.subscriptions << self.author unless self.conversation.subscriptions.exists?(self.author.id)
      end
    end
  end
end
