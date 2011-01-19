require "rails"
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/stilts/rails/helpers')
include Stilts::Helpers

describe Stilts::Helpers do  
  
  before(:each) do
    @image = test_images[rand(3)]
  end
  
  describe "#transform" do
    it "should respond with some image tag HTML" do
      
      transform(@image).should =~ /^\<img/
      
      
    end
  end
  
end