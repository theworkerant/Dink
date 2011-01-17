module Stilts
  module Hooks

    def self.included(base)
      base.send(:include, InstanceMethods)
      base.before_filter :log_test
      base.after_filter :log_test
    end

    def log_test
      Rails.logger.debug {"i'm being executed after!! --- --- }
    end
  end
end
