source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.4"

gem "rails", "~> 7.0.8", ">= 7.0.8.4"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'sassc-rails', '~> 2.1'
gem 'uglifier'
gem 'terser'
gem 'bootstrap', '~> 5.3'
gem 'i18n'

#google ログイン
gem 'dotenv-rails', groups: [:development, :test]
gem 'oauth2', '~> 2.0'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'





# gem "sassc-rails"
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 5.0.0' 
end

group :development do
  gem "web-console"
  # gem "rack-mini-profiler"
  # gem "spring"
end

# 開発・テスト環境専用のgem
group :development, :test do
  gem 'mysql2', '>= 0.5'
end

# 本番環境専用のgem
group :production do
  gem 'mysql2', '>= 0.5'
end



group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

gem "cssbundling-rails", "~> 1.4"
gem 'devise'


