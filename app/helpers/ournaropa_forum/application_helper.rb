module OurnaropaForum
  module ApplicationHelper
    
    def render_text text
      
      # safe text
      text = h(text)
      
      # add line breaks
      text.gsub!("\n","<br />")
      
      # add links
      text.gsub!( /((http(s?):\/\/)?(\S*\.\S*\.\S*))/, '<a href="http\3://\4" target="_blank">\1</a>' )
      
      # strong text
      #text.gsub!(/^(.*)\*(.*?)\*(.*)$/, '\1<strong>\2</strong>\3')  
        
      # italic text
      #text.gsub!(/_(.*)_/, '<i>\1</i>')  
        
      return text.html_safe
    end
    
  end
end
