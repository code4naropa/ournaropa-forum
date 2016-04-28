module OurnaropaForum
  class Reply < ActiveRecord::Base
    
    belongs_to :conversation
    
    validates :title, :body, :author_id, :conversation, presence: true
  end
end
