module Stilts
  require 'net/http'
  require 'net/https'
  require 'addressable/uri'
  require 'json'
  # begin
  #   require 'active_support'
  # rescue LoadError
  #   require 'activesupport'
  # end
  
  require 'stilts/configuration'
  require 'stilts/sender'
  require 'stilts/rack'
  require 'stilts/image'
  require 'stilts/batch'
  require 'stilts/railtie' if defined?(Rails)
  
  LOG_PREFIX = "[Stilts] "

  class << self
    
    # The sender object is responsible for delivering formatted data to the server.
    # Must respond to #send_to_hoptoad. See Stilts::Sender.
    attr_accessor :sender

    # A configuration object. Must act like a hash and return sensible
    # values for all configuration options. See Stilts::Configuration.
    attr_accessor :configuration
    
    def configure(silent = false)
      self.configuration ||= Configuration.new
      yield(configuration)
      self.sender = Sender.new(configuration)
    end
    
    def logger
      self.configuration.logger
    end
    
    # Prints out the environment info to the log for debugging help
    def report_environment_info
      write_verbose_log("Environment Info: #{environment_info}")
    end

    # Prints out the response body from Stilts for debugging help
    def report_response_body(response)
      write_verbose_log("Response from Server: \n#{response}")
    end

    # Returns the Ruby version, Rails version, and current Rails environment
    def environment_info
      info = "[Ruby: #{RUBY_VERSION}]"
      info << " [#{configuration.framework}]"
    end

    # Writes out the given message to the #logger
    def write_verbose_log(message)
      logger.info LOG_PREFIX + message if logger
    end

  end
end
