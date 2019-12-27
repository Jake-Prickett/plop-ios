Pod::Spec.new do |s|
  s.name                  = "PLOP"
  s.version               = "0.0.1"
  s.summary               = "Debug Panel for Development"
  s.description           = "Debug panel that can be utilized for handling debug features (toggles, shortcuts, etc.)"
  s.homepage              = "https://github.com/fordmps/plop-ios.git"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "jpricke1-ford" => "jpricke1@ford.com" }
  s.social_media_url      = ""
  s.ios.deployment_target = "10.0"
  s.source                = { :git => "git@github.com:fordmps/plop-ios.git", :tag => s.version.to_s }
  s.source_files          = "Sources/*"
  s.frameworks            = { "Foundation"}
  s.swift_version         = "4.2"
end