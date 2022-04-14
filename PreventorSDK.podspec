Pod::Spec.new do |s|
  s.name             = 'PreventorSDK'
  s.version          = '1.0.5'
  s.summary          = 'Preventor identifies, onboards, and monitors your clients in a single, AI-powered platform.'
  s.description      = <<-DESC 
Preventor is the next generation self-service digital identity and financial crime risk management platform for individuals and businesses. 
Preventor identifies, onboards, and monitors your clients in a single, AI-powered platform.
        DESC
  s.homepage         = 'https://github.com/preventorid/button-ios-sdk.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'PreventorID' => 'preventorid.developer@gmail.com' }
  s.source           = { :git => 'https://github.com/preventorid/button-ios-sdk.git', :tag => s.version.to_s }
  s.swift_version = "5.0"
  s.ios.deployment_target = '13.0'
  s.vendored_frameworks = 'PreventorSDK.xcframework', 'Lottie.xcframework', 'Alamofire.xcframework'
  s.dependency 'DocumentReader', '6.1.2358'
  s.dependency 'DocumentReaderFullRFID', '6.1.5791'
end
