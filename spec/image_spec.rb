require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/stilts/image')

describe Stilts::Image do  
  
  before(:each) do
    @image = random_image
  end
  
  it "should have some default values assigned" do
    assert_default_value :device_width_ratio, 1
  end
  
  describe "#url_id" do
    it "should generate a unique id for an image based on it's URL" do
      id = @image.url_id
      id.should be_a_kind_of(String)
      id.length.should be 40
    end
  end
  
  describe "#params_slug" do
    it "should respond with a string representation of the transform parameters " do
      @image.params_slug.should be_a_kind_of(String)
    end
  end
  
  describe "#name" do
    it "should respond with the url_id and abbreviated transform params" do
      @image.name.should =~ /^[\w\d]{40}_[\w\d]+$/
    end
  end
  
  describe "#s3_url" do
    it "should respond with the full url of a post-transform and distributed image" do
      @image.cdn_url.should =~ /^http:\/\//
    end
  end
  
  describe "#to_hash" do
    it "should respond to to_hash" do
      @image.to_hash.should be_a_kind_of(Hash)
    end
    it "should have some specific keys" do
      hash = @image.to_hash
      hash[:source].should_not be nil
      hash[:name].should_not be nil
    end
  end
  
  describe "#cached?" do
    it "should return true if the image name is in local cache" do
      pending
    end
    it "should return false if the image name is not found in local cache" do
      pending
    end
  end
  
  describe "#to_json" do
    it "should respond to to_json" do
      json = @image.to_json
      json.should be_a_kind_of(String)
      JSON.parse(json).should be_a_kind_of(Hash)
    end
  end
  
  def assert_default_value(option, default_value)
    default_value.should be @image.send(option)
  end
  
end