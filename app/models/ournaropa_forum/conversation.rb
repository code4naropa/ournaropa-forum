module OurnaropaForum
  class Conversation < ActiveRecord::Base
        
    # Assocations
    has_many :replies
    belongs_to :author, class_name: "User"
    has_and_belongs_to_many :subscriptions, :class_name => "User"
    
    # Scopes
    scope :recent, -> { where("created_at > ?", Time.now - 1.minute ) }
    
    # Validations
    validates_presence_of :title, :body, :author_id
    validate :is_not_a_double_post?, on: :create
    
    # Parameterize slug
    extend FriendlyId
    friendly_id :title, use: :slugged
    
    # verify that this is not a double post
    def is_not_a_double_post?

      # load all recent conversations (< 1 minute ago)
      recent_conversations = OurnaropaForum::Conversation.where(:author_id => self.author.id).recent

      # scan each conversation and check whether it is has the same title and body, if so give error and return false
      recent_conversations.each do |conversation|
        if conversation.title == self.title and conversation.body == self.body
          errors[:base] << "Conversation has already been posted."
          return false
        end
      end
      
      # if we made it through, there are no recent conversations with the same title and body -> this is not a double post
      return true

    end
    
    after_create do
      self.subscriptions << self.author
    end
    
  end
end
