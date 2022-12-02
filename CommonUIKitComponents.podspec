#
# Be sure to run `pod lib lint CommonUIKitComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CommonUIKitComponents'
  s.version          = '1.3.1'
  s.summary          = 'Generic and reusable views.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'Common UI kit components help you build the interface of your app with generic and reusable views.'
                       DESC

  s.homepage         = 'https://github.com/luisMan97/CommonUIKitComponents'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'luisMan97' => 'riveraladinojorgeluis@gmail.com' }
  s.source           = { :git => 'https://github.com/luisMan97/CommonUIKitComponents.git', :tag => s.version.to_s }
  #s.social_media_url = 'https://www.linkedin.com/in/jorge-luis-rivera-ladino-396a01163/'

  s.ios.deployment_target = '12.0'

  s.source_files = 'Sources/CommonUIKitComponents/**/*'
  s.swift_version = '5.0'
  s.platforms = {
      "ios": "12.0"
  }
  
  # s.resource_bundles = {
  #   'CommonUIKitComponents' => ['CommonUIKitComponents/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'RxCocoa'
end
