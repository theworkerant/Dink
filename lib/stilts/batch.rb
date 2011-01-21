module Stilts
  class Batch
    
    attr_accessor :images
    
    # Batch is just an array of images
    def initialize
      self.images = []
    end
    
    # Send images to Stilts for transformation, first +screen+ and translate +to_json+
    def deliver
      Stilts.sender.send_image_transform_data(self.to_json)
    end
    
    # Ready images for transport across voidy vastness of teh interweb
    def to_json
      JSON.generate(self.images.collect{|i| i.to_hash})
    end
    
    # :nodoc:
    def << image
      self.images << image
    end
    
    # :nodoc:
    def size
      self.images.size
    end
    alias_method :length, :size
    
    # :nodoc:
    def empty?
      return true if self.size == 0
      false
    end

  end
end
