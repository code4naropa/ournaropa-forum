source 'https://rubygems.org'

# Declare your gem's dependencies in ournaropa_forum.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

gem 'sass-rails'
gem 'materialize-sass'
gem 'material_icons'
gem 'bcrypt'
gem 'roadie-rails', '~> 1.0'

gem 'piwik_analytics', '~> 1.0.0'

#gem 'friendly_id', '~> 5.1.0' # Note: You MUST use 5.0.0 or greater for Rails 4.0+

group :development, :test do
  gem 'thin', '~> 1.7'
  gem 'jquery-rails'
  # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
  gem 'turbolinks'
  # Fix turbolinks issues
  gem 'jquery-turbolinks'
  gem 'pry-rails'
  gem 'figaro'
  gem 'paperclip'
end

group :test do
  gem 'shoulda-matchers', '~> 3.0', require: false
  gem 'database_cleaner', '~> 1.5'
  gem 'faker', '~> 1.6.1'
  gem 'launchy'
  gem 'poltergeist'
end
