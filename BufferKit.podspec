#
# Be sure to run `pod lib lint BufferKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BufferKit"
  s.version          = "0.1.0"
  s.summary          = "Buffer SDK for iOS/OSX/tvOS/Linux"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
  Swift based Buffer SDK for iOS/OSX/tvOS/Linux
                       DESC

  s.homepage         = "https://humberaquino.me"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Humber Aquino" => "humberaquino@gmail.com" }
  s.source           = { :git => "https://github.com/humberaquino/BufferKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/goku2'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'BufferKit' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Moya', '~> 6.2'
  s.dependency 'ObjectMapper', '~> 1.1'

end
