module Stilts
  class Sender
    TRANSFORM_HEADERS = {
      'Content-Type'    => 'application/json',
      'Accept'          => 'application/json'
    }

    HTTP_ERRORS = [Timeout::Error,
      Errno::EINVAL,
      Errno::ECONNRESET,
      EOFError,
      Net::HTTPBadResponse,
      Net::HTTPHeaderSyntaxError,
      Net::ProtocolError,
    Errno::ECONNREFUSED].freeze

    attr_accessor :user_agent

    def initialize(options = {})
      [:protocol, :host, :port, :secure, :http_open_timeout, :http_read_timeout].each do |option|
        instance_variable_set("@#{option}", options[option])
      end
    end

    def send_image_transform_data(data)
      http              = Net::HTTP.new(Stilts.configuration.host, Stilts.configuration.port)

      http.read_timeout = Stilts.configuration.http_read_timeout
      http.open_timeout = Stilts.configuration.http_open_timeout
      http.use_ssl      = false
      headers           = TRANSFORM_HEADERS.merge({'User-Agent' => user_agent})

      response = begin
        http.post("transform", data, headers)
      rescue *HTTP_ERRORS => e
        log :error, "Timeout while contacting the server. #{e}"
        nil
      end

      case response
      when Net::HTTPSuccess then
        log :info, "Success: #{response.class}", response
        return JSON.parse(response.body)
      else
        log :error, "Failure: #{response.class}", response
      end
    end

    def log(level, message, response = nil)
      logger.send level, LOG_PREFIX + message if logger
      Stilts.report_environment_info
      Stilts.report_response_body(response.body) if response && response.respond_to?(:body)
    end

    def logger
      Stilts.configuration.logger
    end

  end
end
