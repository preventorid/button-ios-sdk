#
# Be sure to run `pod lib lint PreventorSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PreventorSDK'
  s.version          = '0.2.2'
  s.summary          = 'PreventorSDK aims to give users truth about their identity, through the use of AI among other resources'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
PreventorSDK aims to give users truth about their identity, through the use of AI among other resources
                       DESC

  s.homepage         = 'https://github.com/preventorid/button-ios-sdk.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'PreventorID' => 'preventorid.developer@gmail.com' }
  s.source           = { :git => 'https://github.com/preventorid/button-ios-sdk.git', :tag => s.version.to_s }
  s.swift_version = "5.0"
  s.ios.deployment_target = '13.0'
  # s.resource_bundles = {
  #   'PreventorSDK' => ['PreventorSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.vendored_frameworks = 'PreventorSDK.xcframework', 'Lottie.xcframework', 'Alamofire.xcframework'
  s.dependency 'DocumentReader', '6.1.2358'
  s.dependency 'DocumentReaderFullRFID', '6.1.5791'

end
