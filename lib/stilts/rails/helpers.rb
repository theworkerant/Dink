module Stilts
  module Helpers
    include ActionView::Helpers
    
    def transform(image)
      image = Stilts::Image.new(image)
      # @response = Stilts.sender.send_to_resizer({:image_source => image_source}.to_json.to_s)
      image_tag(image.transformed_url)
    end

    def stream_resize(image_source)
      b = Benchmark.measure do
        @params = Addressable::URI.parse(url.to_s) # TODO get URI.parse out of Addressable to remove the dependency
        @params.query_values = {:image_source => image_source, :stream => "1"}
      end
      # logger.debug { "STREAM BENCHMARK :: #{b}" }

      stream_url = url
      stream_url.path = "/resize"
      stream_url.query = @params.query
      stream_url.to_s
    end

    def url
      Stilts.configuration.url.dup
    end
    
    def logger
      Stilts.configuration.logger
    end

  end
end
