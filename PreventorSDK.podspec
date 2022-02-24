#
# Be sure to run `pod lib lint PreventorSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PreventorSDK'
  s.version          = '0.1.0'
  s.summary          = 'PreventorSDK aims to give users truth about their identity, through the use of AI among other resources'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'git@github.com:preventorid/button-ios-sdk.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alexander Rodriguez' => 'adragonrc@gmail.com' }
  s.source           = { :git => 'git@github.com:preventorid/button-ios-sdk.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version      = "5.0"
  s.ios.deployment_target = '13.0'

  s.source_files = 'PreventorSDKWrapper/**/*'
  
  # s.resource_bundles = {
  #   'PreventorSDK' => ['PreventorSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.vendored_frameworks = "PreventorSDK.xcframework"
  s.dependency 'DocumentReader', '6.1.2358'
  s.dependency 'DocumentReaderFullRFID', '6.1.5791'

end
