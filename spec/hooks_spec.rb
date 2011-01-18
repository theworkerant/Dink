require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/stilts/rails/hooks')

describe Stilts::Hooks do
  it "should gather up all the images on a page for resizing" do
    pending "This should really be an integration test"
  end
  it "should check local cache to see if any of the images have already been processed" do
    pending
  end
  it "should send a hash of unprocessed images to Stilts" do
    pending
  end
  it "should skip sending of already processed images to Stilts" do
    pending
    # cache fake result, try to resend image
  end
  
end