require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    config.load_defaults 7.0

    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'

    config.action_view.field_error_proc = proc { |html_tag, _instance| html_tag }
    config.assets.paths << Rails.root.join('app/assets/stylesheets')

    config.autoload_lib(ignore: %w(assets tasks))

    config.public_file_server.enabled = true
  end
end
