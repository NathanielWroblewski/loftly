require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Loftly
  class Application < Rails::Application
    # config.time_zone = 'Central Time (US & Canada)'
    config.assets.precompile += %w(vendor/modernizr .svg .eot .woff .ttf .otf)
    config.assets.enabled = true
    config.assets.paths << Rails.root.join('app', 'assets')
  end
end
