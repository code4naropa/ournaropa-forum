require "erb"

module OurnaropaForum
  module ApplicationHelper
    
    STARTER_CHARS = /[[:space:]]|\(|^/
    LEGIT_CHARS = /[a-zA-Z0-9_]/
    INTERCEPT_CHARS = /([[:space:]])|(\.([[:space:]]|$))|(\)[[:space:]])|$/
    URL_REGEX = /(#{STARTER_CHARS})((https?:\/\/)?#{LEGIT_CHARS}+?\.#{LEGIT_CHARS}+?.*?)(#{INTERCEPT_CHARS})/u
    
    include ERB::Util
    
    def render_text text
      
      # safe text
      text = h(text)
            
      # add links
      text.gsub!( /((http(s?):\/\/)?(\S*?\.\S*\.\S*))/, '<a href="http\3://\4" target="_blank">\1</a>' )
      
      # add line breaks
      text.gsub!("\n","<br />")  
        
      # strong text
      #text.gsub!(/^(.*)\*(.*?)\*(.*)$/, '\1<strong>\2</strong>\3')  
        
      # italic text
      #text.gsub!(/_(.*)_/, '<i>\1</i>')  
        
      return text.html_safe
    end
    
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
