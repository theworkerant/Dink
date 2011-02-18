module Dink
  class Sender
    PROCESS_HEADERS = {
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

    def send_image_process_data(data)
      http              = Net::HTTP.new(@host, @port)

      http.read_timeout = @http_read_timeout
      http.open_timeout = @http_open_timeout
      http.use_ssl      = false
      headers           = PROCESS_HEADERS.merge({'User-Agent' => user_agent})

      logger.debug { "Sending to: #{@host}:#{@port}" }
      response = begin
        http.post("/link/#{Dink.configuration.api_key}", data, headers)
      rescue *HTTP_ERRORS => e
        log :error, "Timeout while contacting the server. #{e}"
        nil
      end

      Dink.receiver.receive(response)
    end

    def log(level, message, response = nil)
      logger.send level, LOG_PREFIX + message if logger
      Dink.report_environment_info
      Dink.report_response_body(response.body) if response && response.respond_to?(:body)
    end

    def logger
      Dink.configuration.logger
    end

  end
end
