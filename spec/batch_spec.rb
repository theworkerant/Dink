require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/dink/batch')

describe Dink::Batch do
  before(:each) do
    @image1, @image2 = random_image, random_image
    @batch = Dink::Batch.new
  end
  
  it "should gather up all the images on a page for resizing" do
    pending "This should really be an integration test"
  end

  it "should accept new images like an array" do
    @batch << @image1
    @batch.size.should be 1
  end
  
  it "should respond to empty?" do
    @batch.empty?.should be true
    @batch << @image1
    @batch.empty?.should be false
  end
  
  it "should respond to #to_json" do
    @batch << @image1
    @batch << @image2
    @batch.to_json.should be_a_kind_of(String)
  end

  describe "#deliver" do
    before(:each) do
      @batch << @image1
      @batch << @image2
    end
    
    it "should send a hash of unprocessed images to Dink" do
      Dink.sender.user_agent = "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A543a Safari/419.3"
      @batch.deliver
    end
  end

  # describe "#screen" do
  #   it "should check local cache to see if any of the images have already been processed" do
  #     pending
  #   end
  #   it "should skip sending of already processed images to Dink" do
  #     pending
  #     # cache fake result, try to resend image
  #   end
  # end

  
end
