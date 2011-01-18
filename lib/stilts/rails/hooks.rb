module Stilts
  module Hooks

    def self.included(base)
      base.before_filter :clear_resize_batch
      base.after_filter :resize_batch
    end

    def clear_resize_batch
      @resize_batch = []
    end
    def resize_batch
      @resize_batch
    end
  end
end
