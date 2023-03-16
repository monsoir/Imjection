Pod::Spec.new do |spec|

  spec.name         = "Imjection"
  spec.version      = "1.0.0"
  spec.summary      = "Simple global dependency injection in Swift"

  spec.homepage     = "https://github.com/monsoir/Imjection.git"

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "author" => "author@gmail.com" }
  spec.social_media_url   = "https://github.com/monsoir"

  spec.swift_version = "5.0"

  #  When using multiple platforms
  spec.ios.deployment_target = "11.0"

  spec.source       = { :git => "https://github.com/monsoir/Imjection.git", :branch => "master", :tag => "#{spec.version}" }

  spec.source_files  = ["Imjection/AlphahomSwiftyKit.h", "Imjection/Sources/**/*.swift"]

  spec.requires_arc = true

end
