require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/stilts/image')

describe Stilts::Image do  
  
  describe "#url_id" do
    it "should generate a unique id for an image based on it's URL" do
      pending
      id = url_id(@test_images[1][:url])
      id.should be_a_kind_of(String)
      id.length.should be 40    
      
    end
  end
  
  describe "#params_slug" do
    it "should respond with a string representation of the resizing parameters " do
      pending
    end
  end
  
end