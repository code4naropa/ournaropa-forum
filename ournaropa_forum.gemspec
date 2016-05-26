$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ournaropa_forum/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ournaropa_forum"
  s.version     = OurnaropaForum::VERSION
  s.authors     = ["Finn Woelm"]
  s.email       = ["finn.woelm@gmail.com"]
  s.homepage    = "http://www.ournaropa.org"
  s.summary     = "spaceholder"
  s.description = "spaceholder"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "pg"
  
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'  
  
  # For CSS to inline in emails
  s.add_dependency 'roadie-rails', '~> 1.0'
  
  # For turning conversation titles into slugs
  s.add_dependency 'friendly_id', '~> 5.1.0' # Note: You MUST use 5.0.0 or greater for Rails 4.0+
    
  s.add_dependency 'jquery-rails'
  s.add_dependency 'turbolinks'
  s.add_dependency 'jquery-turbolinks'
  s.add_dependency 'bcrypt'
  
  s.add_dependency 'sass-rails'
  s.add_dependency 'materialize-sass'
  s.add_dependency 'material_icons'
  
  s.add_dependency 'paperclip', "~> 5.0.0.beta1"
  
  s.test_files = Dir["spec/**/*"]
  
end
