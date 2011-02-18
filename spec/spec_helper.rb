require File.expand_path(File.dirname(__FILE__) + '/../lib/dink')
require "rails/all"

RSpec.configure do |config|
  # == Mock Framework
  config.mock_with :rspec
end


def test_images
  [
    { :source => "http://www.crazy-frog.us/donthotlink-crazy-frog-1024x768-1.jpg",
      :options => {} },
    { :source => "https://totalfright.websitesource.net/mm5/pics/32901.jpg",
      :options => {} },
    { :source => "http://iamthatmommy.files.wordpress.com/2010/04/unicorn1.jpg",
      :options => {} }
  ]
end

def random_image
  image_number = rand(test_images.size) 
  Dink::Image.new(test_images[image_number][:source], test_images[image_number][:options])
end

Dink.configure do |c|
  c.api_key = "1234123412341234"
end
