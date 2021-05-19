source 'https://rubygems.org'

# Ruby and Rails
ruby '2.6.5'

# Server
gem 'puma', '~> 4.3'

# Rails
gem 'bootsnap', '>= 1.4.2', require: false
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'

# Frontend
gem 'haml'
gem 'haml-rails'
gem 'normalize-rails'
gem 'react-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
