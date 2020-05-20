Pod::Spec.new do |s|

  s.name         = "PLOP"
  s.version      = "1.1.1"
  s.platform     = :ios, "9.0"
  s.summary      = "Debug Panel for Development."
  
  s.description  = <<-DESC
  Debug panel that can be utilized for handling debug features (toggles, shortcuts, etc.)
  DESC
  
  s.homepage     = "https://github.com/Jake-Prickett/plop-ios"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Jake Prickett" => "jprickett821@gmail.com" }
  s.source       = { :git => "https://github.com/Jake-Prickett/plop-ios.git", :tag => "1.1.1" }
  
  s.swift_version = "5.0"
  s.source_files = "Sources/**/*.{h,swift}"
  
  end