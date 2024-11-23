require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Test1111
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # アプリケーションのデフォルト言語を日本語に設定
    config.i18n.default_locale = :ja

    # 許可するホストを設定
    config.hosts << 'https://where-does-back-pain-come-from.com/'

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = 'Central Time (US & Canada)'
    # config.eager_load_paths << Rails.root.join('extras')
    config.middleware.use Rack::Rewrite do
      r301 %r{^https://where-does-back-pain-come-from-07a8b4b21813.herokuapp.com(.*)}, 'https://where-does-back-pain-come-from.com$1', :if => Proc.new { |rack_env|
        rack_env['HTTP_HOST'] == 'where-does-back-pain-come-from-07a8b4b21813.herokuapp.com'
      }
    end
  end
end
