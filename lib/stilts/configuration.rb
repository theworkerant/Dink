module Stilts
  # Used to set up and modify settings for the notifier.
  class Configuration

    OPTIONS = [:api_key, :host, :http_open_timeout, :http_read_timeout, :project_root,
    :port, :protocol, :secure, :framework].freeze

    # The API key for your project, found on the project edit form.
    attr_accessor :api_key

    # The host to connect to
    attr_accessor :host
    
    # The CDN host to connect to
    attr_accessor :cdn_host

    # The port on which your server runs (defaults to 443 for secure
    # connections, 80 for insecure connections).
    attr_accessor :port

    # +true+ for https connections, +false+ for http connections.
    attr_accessor :secure

    # The path to the project in which the error occurred, such as the RAILS_ROOT
    attr_accessor :project_root

    # The logger used by 
    attr_accessor :logger

    # The framework is configured to use
    attr_accessor :framework
    
    # The HTTP open timeout in seconds (defaults to 2).
    attr_accessor :http_open_timeout

    # The HTTP read timeout in seconds (defaults to 5).
    attr_accessor :http_read_timeout

    alias_method :secure?, :secure

    def initialize
      @secure                   = false
      # @host                     = 'stilts.developmentnow.com'
      # @port                     = 80
      @host                     = "localhost"
      @port                     = 3000
      @cdn_host                 = 'd15ceu2kbcb932.cloudfront.net'
      @framework                = 'Standalone'
      @protocol                 = protocol
      @http_open_timeout        = 2
      @http_read_timeout        = 5
    end

    # Allows config options to be read like a hash
    #
    # @param [Symbol] option Key for a given attribute
    def [](option)
      send(option)
    end
    
    def url
      url = URI::HTTP.build({
        :host => @host,
        :scheme => protocol,
        :path => "/",
        :port => @port
      })
    end

    # Returns a hash of all configurable options
    def to_hash
      OPTIONS.inject({}) do |hash, option|
        hash.merge(option.to_sym => send(option))
      end
    end

    # Returns a hash of all configurable options merged with +hash+
    #
    # @param [Hash] hash A set of configuration options that will take precedence over the defaults
    def merge(hash)
      to_hash.merge(hash)
    end

    def port
      @port || default_port
    end

    def protocol
      if secure?
        'https'
      else
        'http'
      end
    end

    private

    def default_port
      if secure?
        443
      else
        80
      end
    end
  end
end