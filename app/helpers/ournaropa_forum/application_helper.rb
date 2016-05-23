require "erb"

module OurnaropaForum
  module ApplicationHelper
    
    STARTER_CHARS = /[[:space:]]|&#39;|&quot;|[\(\{\[]|^/
    LEGIT_CHARS = /[a-zA-Z0-9-]/
    ENDING_CHARS_IF_FOLLOWED_BY_SPACE = /[\.!\?:;\)\]\}]/
    ENDING_CHARS_IN_ANY_CASE = /[[[:space:]]\"]|&#39;|&quot;|$/
    INTERCEPT_CHARS = /(#{ENDING_CHARS_IN_ANY_CASE})|(#{ENDING_CHARS_IF_FOLLOWED_BY_SPACE}+([[:space:]]|$))/
    URL_REGEX = /(#{STARTER_CHARS})((https?:\/\/)?#{LEGIT_CHARS}+?\.#{LEGIT_CHARS}+?.*?)(#{INTERCEPT_CHARS})/u
    
    include ERB::Util
        
    # test case here: http://rubyfiddle.com/riddles/c4e0b/2
    def parse_text text
      
      # safe text
      text = html_escape(text)  

      # parse links
      text = text.to_str.gsub(URL_REGEX) { |m| $1.to_s + '<a href="' + ($3 ? "" : "http://") + $2.to_s + '" target="_blank">' + $2.to_s + '</a>' + $4.to_s }
      
      # add line breaks
      text.gsub!("\n","<br />")  
        
      return text.html_safe
      
    end
        
  end
end
