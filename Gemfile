source 'https://rubygems.org'

gem 'rails', '~> 3.2.14'

gem 'mongoid', '~> 3.1.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'ngmin-rails'

  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

# Using a fork of Slim with a change so it doesn't interpret Angular's double
# braces as wrapping tag attributes.
gem 'slim', github: 'brennancheung/slim', branch: 'angularjs_support'
gem 'slim-rails', group: [:development, :test]

gem 'rabl'

gem 'momentjs-rails'
gem 'angularjs-rails'
gem 'angularjs-rails-resource'
gem 'ng-rails-csrf'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'quiet_assets'

  gem 'guard', '~> 2.0.5'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-livereload'
  gem 'coderay', '~> 1.0.5'
end
