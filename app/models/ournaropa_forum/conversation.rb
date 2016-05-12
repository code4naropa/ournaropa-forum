module OurnaropaForum
  class Conversation < ActiveRecord::Base
    
    has_many :replies
    belongs_to :author, class_name: "User"
    
    validates_presence_of :title, :body, :author_id
    
  end
end
