module Dink
  module Hooks
  
    def self.included(base)
      base.before_filter :image_batch
      base.append_before_filter :deliver_batch
    end

    def image_batch
      @image_batch = Dink::Batch.new
    end
    def deliver_batch
      @image_batch.deliver unless @image_batch.empty?
    end
    
  end
end
