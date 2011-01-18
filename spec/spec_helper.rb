require File.expand_path(File.dirname(__FILE__) + '/../lib/stilts')
require "rails/all"

RSpec.configure do |config|
  # == Mock Framework
  config.mock_with :rspec
end

@test_images = [
  { :url => "http://www.crazy-frog.us/donthotlink-crazy-frog-1024x768-1.jpg" },
  { :url => "https://totalfright.websitesource.net/mm5/pics/32901.jpg" },
  { :url => "http://iamthatmommy.files.wordpress.com/2010/04/unicorn1.jpg"}
]
