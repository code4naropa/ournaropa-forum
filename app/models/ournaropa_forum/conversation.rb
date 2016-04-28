module OurnaropaForum
  class Conversation < ActiveRecord::Base
    
    has_many :replies
    
    validates :title, :body, :author_id, presence: true
    
  end
end
