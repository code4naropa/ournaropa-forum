require 'rails_helper.rb'

require "shared.rb"

RSpec::Matchers.define :contain_link do |href, visible_text|
  match do |parsed_text|
    return (parsed_text.include?('href="'+href+'"') and parsed_text.include?('>'+visible_text+'</a>'))
  end
end

RSpec::Matchers.define :not_contain_link do |arg|
  match do |parsed_text|
    return (not parsed_text.include?('<a href='))
  end
end


feature 'Conversations' do 
  
  include_context "shared functions"
  
  before do
    create_and_sign_in_user
  end
  
  scenario 'can correctly identify links and parse them' do
    
    links = [
      {:text => "www.ournaropa.org", :href => "http://www.ournaropa.org"},
      {:text => "www.ournaropa.org/", :href => "http://www.ournaropa.org/"},
      {:text => "ournaropa.org", :href => "http://ournaropa.org"},
      {:text => "ournaropa.org/", :href => "http://ournaropa.org/"},
      {:text => "http://www.ournaropa.org/", :href => "http://www.ournaropa.org/"},
      {:text => "https://www.ournaropa.org/", :href => "https://www.ournaropa.org/"}]
    
    not_links = [
      "ournar@pa.org",
      "jonas$thegreat.com"
      ]
    
    links.each do |link|
      
      # link alone
      text_with_link = link[:text]
      parsed_text = parse_text(text_with_link)
      expect(parsed_text).to contain_link(link[:href], link[:text])
      
      # link at beginning of sentence
      text_with_link = link[:text] + " " + Faker::Lorem.words(5).join(" ")
      parsed_text = parse_text(text_with_link)
      expect(parsed_text).to contain_link(link[:href], link[:text])
      
      # link at middle of sentence
      text_with_link = Faker::Lorem.words(5).join(" ") + " " + link[:text] + " " + Faker::Lorem.words(5).join(" ")
      parsed_text = parse_text(text_with_link)
      expect(parsed_text).to contain_link(link[:href], link[:text])
      
      # link at end of sentence
      text_with_link = Faker::Lorem.words(5).join(" ") + " " + link[:text] + "."
      parsed_text = parse_text(text_with_link)
      expect(parsed_text).to contain_link(link[:href], link[:text])
      
      # link in parenhthesis
      text_with_link = Faker::Lorem.words(5).join(" ") + " (" + link[:text] + ") " + Faker::Lorem.words(5).join(" ")
      parsed_text = parse_text(text_with_link)
      expect(parsed_text).to contain_link(link[:href], link[:text])
      
    end
    
    not_links.each do |link|
      
      # link alone
      text_with_link = link
      parsed_text = parse_text(text_with_link)
      expect(parsed_text).to not_contain_link
      
      # link at beginning of sentence
      text_with_link = link + " " + Faker::Lorem.words(5).join(" ")
      parsed_text = parse_text(text_with_link)
      expect(parsed_text).to not_contain_link
      
      # link at middle of sentence
      text_with_link = Faker::Lorem.words(5).join(" ") + " " + link + " " + Faker::Lorem.words(5).join(" ")
      parsed_text = parse_text(text_with_link)
      expect(parsed_text).to not_contain_link
      
      # link at end of sentence
      text_with_link = Faker::Lorem.words(5).join(" ") + " " + link + "."
      parsed_text = parse_text(text_with_link)
      expect(parsed_text).to not_contain_link
      
      # link in parenhthesis
      text_with_link = Faker::Lorem.words(5).join(" ") + " (" + link + ") " + Faker::Lorem.words(5).join(" ")
      parsed_text = parse_text(text_with_link)
      expect(parsed_text).to not_contain_link
      
    end
      
  end

end