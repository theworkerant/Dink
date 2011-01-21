module Stilts
  class Receiver

    def initialize(options = {})
    end
    
    def receive(response)
      case response
      when Net::HTTPSuccess then
        log :info, "Success: #{response.class}", response
        return JSON.parse(response.body)
      else
        log :error, "Failure: #{response.class}", response
      end
      
      @some_url = "Erglle!"
    end

    def logger
      Stilts.configuration.logger
    end

    def log(level, message, response = nil)
      logger.send level, LOG_PREFIX + message if logger
      Stilts.report_environment_info
      Stilts.report_response_body(response.body) if response && response.respond_to?(:body)
    end

  end
end
