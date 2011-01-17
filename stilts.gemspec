# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stilts/version"

Gem::Specification.new do |s|
  s.name        = "stilts"
  s.version     = Stilts::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Graham Powrie"]
  s.email       = ["graham@developmentnow.com"]
  s.homepage    = ""
  s.summary     = %q{On-the-fly image resizing and management for mobile devices}
  s.description = %q{}

  s.rubyforge_project = "stilts"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency('addressable', '~> 2.2.2')
end
