module OurnaropaForum
  class Reply < ActiveRecord::Base
    
    belongs_to :conversation
    belongs_to :author, class_name: 'User'
    
    validates_presence_of :body, :author, :conversation
    
    # update conversation time
    after_create do
      self.conversation.touch
    end
  end
end
