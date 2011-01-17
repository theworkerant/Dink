require 'stilts'
require 'rails'

module Stilts
  class Railtie < Rails::Railtie

    initializer "stilts.use_rack_middleware" do |app|
      app.config.middleware.use "Stilts::Rack"
    end

    config.after_initialize do
      HoptoadNotifier.configure(true) do |config|
        config.logger           ||= Rails.logger
        # config.environment_name ||= Rails.env
        config.framework        = "Rails: #{::Rails::VERSION::STRING}"
      end

      if defined?(::ActionView::Base)
        
        require 'stilts/rails/helpers'
        ::ActionView::Base.send :include, Stilts::Helpers
        
      end
    end
  end
end
