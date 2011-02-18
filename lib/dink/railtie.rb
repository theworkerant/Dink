require 'dink'
require 'rails'

module Dink
  class Railtie < Rails::Railtie
    initializer "dink.use_rack_middleware" do |app|
      app.config.middleware.use "Dink::Rack"
    end

    config.before_initialize do
      Dink.configure do |config|
        # config.host             = "localhost"
        # config.port             = 3000
        config.logger           ||= Rails.logger
        config.framework        = "Rails: #{::Rails::VERSION::STRING}"
      end

      config.to_prepare do
        require 'dink/rails/hooks'
        ActiveSupport.on_load(:action_controller) do
          include Dink::Hooks
        end
      end


      if defined?(ActionView::Base)

        require 'dink/rails/helpers'
        ActionView::Base.send :include, Dink::Helpers

      end
    end
  end
end
