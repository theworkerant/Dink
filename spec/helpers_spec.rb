require "rails"
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/dink/rails/helpers')
include Dink::Helpers

describe Dink::Helpers do  
  
  before(:each) do
    @image_batch = Dink::Batch.new
    @image = test_images[rand(3)]
  end
  
  describe "#transform" do
    it "should respond with some image tag HTML" do
      
      transform_image("http://bla.com/image.jpg", {}).should =~ /^\<img/
      
      
    end
  end
  
end