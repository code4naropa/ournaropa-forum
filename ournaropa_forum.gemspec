$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ournaropa_forum/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ournaropa_forum"
  s.version     = OurnaropaForum::VERSION
  s.authors     = ["Finn Woelm"]
  s.email       = ["finn.woelm@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of OurnaropaForum."
  s.description = "TODO: Description of OurnaropaForum."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "pg"
  
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  
  s.add_development_dependency 'pry-rails'
  
  
  s.test_files = Dir["spec/**/*"]
  
end
