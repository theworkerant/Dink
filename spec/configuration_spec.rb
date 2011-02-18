require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/dink/rails/helpers')

describe Dink::Configuration do

  it "should bla" do
    pending
  end

  def assert_config_default(option, default_value, config = nil)
    config ||= Dink::Configuration.new
    assert_equal default_value, config.send(option)
  end

end
