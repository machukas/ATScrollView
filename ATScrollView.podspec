#
#  Be sure to run `pod spec lint ATParse.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "ATScrollView"
  s.version      = "1.0.0"
  s.summary      = "UIScrollView with compressible header"
  s.description  = "This library makes it easy to set up a scrollview with a compressible header"
  s.homepage     = "http://EXAMPLE/ATParse"
  s.license      = "MIT"
  s.author             = { "machukas" => "machukkas@gmail.com" }


  s.platform     = :ios
  s.ios.deployment_target = '9.0'

  s.source       = { :git => 'https://github.com/machukas/ATScrollView.git' }

  s.source_files  = "ATScrollView/**/*.{h,m,swift}"

end
