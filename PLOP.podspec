Pod::Spec.new do |s|
  s.name                  = "PLOP"
  s.version               = "1.0.0"
  s.summary               = "Debug Panel for Development"
  s.description           = "Debug panel that can be utilized for handling debug features (toggles, shortcuts, etc.)"
  s.homepage              = "https://github.com/Jake-Prickett/plop-ios"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "Jake-Prickett" => "jprickett821@gmail.com" }
  s.social_media_url      = ""
  s.ios.deployment_target = "11.0"
  s.source                = { :git => "git@github.com:Jake-Prickett/plop-ios", :tag => s.version.to_s }
  s.source_files          = "Sources/*"
  s.frameworks            = { "Foundation"}
  s.swift_version         = "5.1"
end