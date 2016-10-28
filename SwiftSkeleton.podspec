#
# Be sure to run `pod lib lint SwiftSkeleton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftSkeleton'
  s.version          = '0.1.0'
  s.summary          = 'SwiftSkeleton is a set of Extensions and Utils for your Swift Project.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      =
<<-DESC
SwiftSkeleton is a set of Extensions and Utils for your Swift Project.

Speed up to Swift App Development with SwiftSkeleton.


DESC

  s.homepage         = 'https://github.com/manuelescrig/SwiftSkeleton'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Manuel Escrig Ventura' => 'manuelescrig@gmail.com' }
  s.source           = { :git => 'https://github.com/manuelescrig/SwiftSkeleton.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/manuelescrig'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SwiftSkeleton/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwiftSkeleton' => ['SwiftSkeleton/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
