Pod::Spec.new do |s|
  s.name             = 'PreventorSDK'
  s.version          = '3.1.0'
  s.summary          = 'Preventor identifies, onboards, and monitors your clients in a single, AI-powered platform.'
  s.description      = <<-DESC 
Preventor is the next generation self-service digital identity and financial crime risk management platform for individuals and businesses. 
Preventor identifies, onboards, and monitors your clients in a single, AI-powered platform.
        DESC
  s.homepage         = 'https://github.com/preventorid/button-ios-sdk.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'PreventorID' => 'preventorid.developer@gmail.com' }
  s.source           = { :git => 'https://github.com/preventorid/button-ios-sdk.git', :tag => s.version.to_s }
  s.swift_version = "5.7.1"
  s.ios.deployment_target = '13.0'
  
  s.vendored_frameworks = 'PreventorSDK.xcframework', 'PSDKUIKit.xcframework', 'PSDKCommon.xcframework'
  s.dependency 'DocumentReader'
  s.dependency 'DocumentReaderFullRFID'
  s.dependency 'Alamofire'
  s.dependency 'lottie-ios'
  
  s.pod_target_xcconfig = {
    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES'
  }

  s.dependency 'Alamofire' do |dep|
      dep.xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }
    end
  s.dependency 'lottie-ios' do |dep|
      dep.xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }
    end
  
end
