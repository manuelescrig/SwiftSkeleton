Pod::Spec.new do |s|
  s.name             = 'SwiftSkeleton'
  s.version          = '0.1.0'
  s.summary          = 'SwiftSkeleton is a set of Extensions and Utils for your Swift Project.'
  s.description      =
<<-DESC
SwiftSkeleton is a set of Extensions and Utils for your Swift Project.
Speed up to Swift App Development with SwiftSkeleton.
DESC
  s.homepage         = 'https://github.com/manuelescrig/SwiftSkeleton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Manuel Escrig Ventura' => 'manuelescrig@gmail.com' }
  s.source           = { :git => 'https://github.com/manuelescrig/SwiftSkeleton.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/manuelescrig'
  s.ios.deployment_target = '10.0'
  s.source_files = 'SwiftSkeleton/Classes/**/*'
  s.frameworks = 'UIKit', 'Foundation'
end
