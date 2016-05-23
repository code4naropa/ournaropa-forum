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


feature 'Link Parser' do 
  
  include_context "shared functions"
  include OurnaropaForum::ApplicationHelper

  scenario 'can correctly identify links and parse them' do
    
    
    cases = [
      "*LINK*", # link alone
      "*LINK* " + Faker::Lorem.words(5).join(" "), # link at beginning of sentence
      Faker::Lorem.words(5).join(" ") + " *LINK* " + Faker::Lorem.words(5).join(" "), # link at middle of sentence
      Faker::Lorem.words(5).join(" ") + " *LINK*.", # link at end of sentence
      Faker::Lorem.words(5).join(" ") + " *LINK*!", # link at end of sentence with exclamation mark
      Faker::Lorem.words(5).join(" ") + " *LINK*?", # link at end of sentence with question mark
      Faker::Lorem.words(5).join(" ") + " *LINK*...", # multiple dots
      Faker::Lorem.words(5).join(" ") + " (*LINK*) " + Faker::Lorem.words(5).join(" "), # link in parenhthesis
      Faker::Lorem.words(5).join(" ") + " (*LINK*).", # link in parenhthesis at end of sentence
      Faker::Lorem.words(5).join(" ") + " \'*LINK*\' " + Faker::Lorem.words(5).join(" "), # link in quotes
      Faker::Lorem.words(5).join(" ") + " \"*LINK*\" " + Faker::Lorem.words(5).join(" ") # link in quotes
    ]    
    
    links = [
      "www.ournaropa.org",
      "www.ournaropa.org/",
      "ournaropa.org",
      "ournaropa.org/",
      "http://www.ournaropa.org/",
      "https://www.ournaropa.org/",
      "http://127.0.0.1:3000",
      "valid-url.com", #hyphenated url
      "https://www.ournaropa.org.abc?what+is_love_baby_dont_hurt.me",
      "https://www.ournaropa.org.abc?what+is_love_baby_dont_hurt.me%wo45;lol"
    ]
      
    
    links.each do |link|
      
      cases.each do |test_case|
        
        text_with_link = parse_text test_case.gsub("*LINK*", link)
        protocol = link.match(/^https?:\/\//).present? ? "" : "http://"
        expect(text_with_link).to include("href=\"#{protocol}#{link}\"")
        expect(text_with_link).to include(">#{link}<")
        
      end
      
    end
 
    not_links = [
      "ournar@pa.org",
      "jonas$thegreat.com",
      "multi\n\nline\nlink\n.com",
      "invalid_url.com"
      ]    
    
    not_links.each do |not_link|
      
      cases.each do |test_case|
        
        text_with_no_link = parse_text test_case.gsub("*LINK*", not_link)
        expect(text_with_no_link).not_to include("<a href=")
        
      end
      
    end
      
  end

end