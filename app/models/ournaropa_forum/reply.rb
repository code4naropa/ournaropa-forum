module OurnaropaForum
  class Reply < ActiveRecord::Base
    
    # Assocations
    belongs_to :conversation
    belongs_to :author, class_name: 'User'
    
    # Scopes
    scope :recent, -> { where("created_at > ?", Time.now - 1.minute ) }
    
    # Validations
    validates_presence_of :body, :author, :conversation
    validate :is_not_a_double_post?, on: :create
    
    # verify that this is not a double post
    def is_not_a_double_post?

      # load all recent replies (< 1 minute ago)
      recent_replies = OurnaropaForum::Reply.where(:author_id => self.author.id).recent

      # scan each reply and check whether it is has the same body, if so give error and return false
      recent_replies.each do |reply|
        if reply.body == self.body
          errors[:base] << "Reply has already been posted."
          return false
        end
      end
      
      # if we made it through, there are no recent replies with the same body -> this is not a double post
      return true

    end
    
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
