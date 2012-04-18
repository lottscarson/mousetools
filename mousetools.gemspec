Gem::Specification.new do |s|
  s.name        = 'mousetools'
  s.version     = '0.1.1'
  s.add_runtime_dependency "ffi", 
    ["= 1.0.11"]
  s.date        = '2012-04-16'
  s.summary     = "Mousetools for Mac"
  s.description = "A gem that allows for basic mouse-manipulation functionality in Mac OS X (including left/right click, dragging, key-click, etc.) Should work with anything >= OS X 10.4"
  s.author      = ["Scott Larson"]
  s.email       = 'lottscarson@gmail.com'
  s.files       = ["lib/mousetools.rb"]
  s.homepage    =
    'http://rubygems.org/gems/mousetools'
end