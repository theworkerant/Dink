module Stilts
  module Hooks
  
    def self.included(base)
      base.before_filter :clear_image_batch
      base.after_filter :deliver_batch
    end

    def clear_image_batch
      @image_batch = Stilts::Batch.new
    end
    def deliver_batch
      @image_batch.deliver unless @image_batch.empty?
    end
    
  end
end
