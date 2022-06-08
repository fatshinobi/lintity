source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in lintity.gemspec.
gemspec

gem 'sprockets-rails'

group :development do
  gem 'rubocop-rails', require: false
end

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end
# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"
