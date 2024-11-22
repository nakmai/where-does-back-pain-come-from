source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '3.1.4'

# GithubActions
gem 'actionmailer', '~> 7.0.8.5'  # Action Mailerのアップデート
gem 'actionpack', '~> 7.0.8.5'    # Action Packのアップデート
gem 'actiontext', '~> 7.0.8.5'    # Action Textのアップデート
gem 'rexml', '>= 3.3.9'           # REXMLのアップデート

gem 'bootsnap', require: false
gem 'bootstrap', '~> 5.3'
gem 'i18n'
gem 'importmap-rails'
gem 'jbuilder'
gem 'mysql2', '>= 0.5'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.8', '>= 7.0.8.5'
gem 'rubocop', require: false
gem 'sassc-rails', '~> 2.1'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'terser'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier'

# セキュリティ監査
gem 'brakeman', require: false
gem 'bundler-audit', require: false


# 静的OGP
gem 'meta-tags'

# google ログイン
gem 'dotenv-rails', groups: %i[development test]
gem 'oauth2', '~> 2.0'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

# gem 'sassc-rails'
# gem 'image_processing', '~> 1.2'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 5.0.0'
end

group :development do
  gem 'web-console'
  # gem 'rack-mini-profiler'
  # gem 'spring'
end

group :test do
  gem 'capybara'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
end

gem 'cssbundling-rails', '~> 1.4'
gem 'devise'

gem 'bcrypt', '~> 3.1.7'
