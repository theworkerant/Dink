module Stilts
  class Sender
    RESIZER_PATH = "/resize"
    RESIZER_HEADERS = {
      'Content-Type'             => 'application/json',
      'Accept'                   => 'application/json'
    }

    STREAMER_PATH = "/resize"
    STREAMER_HEADERS = {
      'Content-Type'             => 'image/jpeg',
      'Accept'                   => 'image/jpeg'
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
      [:protocol, :host, :port, :secure].each do |option|
        instance_variable_set("@#{option}", options[option])
      end
      # , :http_open_timeout, :http_read_timeout
    end

    def send_to_resizer(data)
      http =
      Net::HTTP.new(url.host, url.port)

      http.read_timeout = 5
      http.open_timeout = 5
      http.use_ssl      = false
      headers           = RESIZER_HEADERS.merge({'User-Agent' => user_agent})

      response = begin
        logger.debug{"POSTED JSON: #{data} TO: #{url.to_s}" }
        http.post(RESIZER_PATH, data, headers)
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

    def send_to_streamer(data)
      http =
      Net::HTTP.new(url.host, url.port)

      http.read_timeout = 5
      http.open_timeout = 5
      http.use_ssl      = false

      response = begin
        http.get(STREAMER_PATH+data, STREAMER_HEADERS)
      rescue *HTTP_ERRORS => e
        log :error, "Timeout while contacting the server. #{e}"
        nil
      end

      case response
      when Net::HTTPSuccess then
        log :info, "Success: #{response.class}", response
        return response.body
      else
        log :error, "Failure: #{response.class}", response
      end
    end

    def url
      Stilts.configuration.url.dup
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
