module Dink
  module Helpers
    include ActionView::Helpers
    
    # Take image transform parameters and generate an image tag and stick it into the batch
    def dink!(source, process_options = {}, image_options = {})
      image = Dink::Image.new(source, process_options).deliver
      Rails.logger.debug{ image.inspect }
      # @image_batch << image
      image_tag(image["results"]["url"], image_options)
    end

    # def stream_resize(image_source)
    #   b = Benchmark.measure do
    #     @params = Addressable::URI.parse(url.to_s) # TODO get URI.parse out of Addressable to remove the dependency
    #     @params.query_values = {:image_source => image_source, :stream => "1"}
    #   end
    #   # logger.debug { "STREAM BENCHMARK :: #{b}" }
    # 
    #   stream_url = url
    #   stream_url.path = "/resize"
    #   stream_url.query = @params.query
    #   stream_url.to_s
    # end
    
    def logger
      Dink.configuration.logger
    end

  end
end
