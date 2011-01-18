require 'stilts'
require 'rails'

module Stilts
  class Railtie < Rails::Railtie
    initializer "stilts.use_rack_middleware" do |app|
      app.config.middleware.use "Stilts::Rack"
    end

    config.before_initialize do
      Stilts.configure do |config|
        config.host             = "localhost"
        config.port             = 3000
        config.logger           ||= Rails.logger
        config.framework        = "Rails: #{::Rails::VERSION::STRING}"
      end

      config.to_prepare do
        require 'stilts/rails/hooks'
        ActiveSupport.on_load(:action_controller) do
          include Stilts::Hooks
        end
      end


      if defined?(ActionView::Base)

        require 'stilts/rails/helpers'
        ActionView::Base.send :include, Stilts::Helpers

      end
    end
  end
end
