Pod::Spec.new do |spec|

  spec.name         = "AmazingEvent"
  spec.version      = "2.0.0"
  spec.summary      = "Generic and retention cycle free Event that enables instance of any type to notify multiple classes when something of interest occurs."

  spec.homepage     = "https://github.com/khamitimur/AmazingEvent"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author    = "Timur Khamidov"

  spec.ios.deployment_target = "11.0"
  spec.osx.deployment_target = "10.14"
  spec.tvos.deployment_target = "11.0"
  spec.watchos.deployment_target = '4.0'

  spec.source       = { :git => "https://github.com/khamitimur/AmazingEvent.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/**/*.swift"
  
  spec.swift_versions = ['5.0']

end
