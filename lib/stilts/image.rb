module Stilts

  # Intermediate utility class for image manipulation
  class Image

    SLUG_ABBREVIATIONS = { 
      :device_width_ratio => "dwr"
    }
    
    TRANSFORM_OPTIONS = [
      "device_width_ratio"
    ]

    # The public location of the image
    attr_accessor :url, :device_width_ratio
    
    # :nodoc:
    def initialize(args)
      self.url                  = args[:url]
      self.device_width_ratio   = args[:device_width_ratio] || 1
    end
    
    # Generates a SHA1 represenation for a particular URL
    def url_id
      Digest::SHA1.hexdigest(self.url)
    end
    
    # Combines resizing parameters into a short, unique slug to be appended to the final image name
    def params_slug
      TRANSFORM_OPTIONS.map do |option|
        param_slug(option)
      end.join("")
    end
    
    # The full image name, a combination of +url_id+ and +params_slug+
    def name
      url_id + "_" + params_slug
    end
    
    # Location on server that will server this image
    def transformed_url
      Stilts.configuration.protocol + "://" +
      Stilts.configuration.host +
      "/transform/" +
      Stilts.configuration.api_key +
      "/" + self.name
    end
    
    # A hash representation of the image attributes
    def to_hash
      {
        :url => self.url,
        :name => self.name,
      }
    end
    
    private
    def param_slug(param_name)
      SLUG_ABBREVIATIONS[param_name.to_sym] + self.send(param_name).to_s
    end

  end
end
