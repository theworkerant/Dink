module Stilts
  class Batch
    
    attr_accessor :images
    
    def initialize
      self.images = []
    end
    
    # Send images to Stilts for transformation, first +screen+ and translate +to_json+
    def deliver
      self.screen
      Stilts.sender.send_image_transform_data(images.to_json)
    end

    # Check if images should be sent for transforming (cached already?)
    def screen
      
    end
    
    # Ready images for transport across voidy vastness of teh interweb
    def to_json
      json = ""
      
      json += "["
      self.images.each do |image|
        json += JSON.generate(image.to_hash)
      end
      json += "]"
    end
    
    def << image
      self.images << image
    end
    
    def size
      self.images.size
    end
    alias_method :length, :size

  end
end
