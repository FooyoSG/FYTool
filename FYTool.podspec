#
# Be sure to run `pod lib lint FYTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FYTool'
  s.version          = '0.2.2'
  s.summary          = 'Tool library and constant.'
  
  s.description      = <<-DESC
Some commonly used extension methods, Tool library.
                       DESC

  s.homepage         = 'https://fooyo.sg'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chinghoi' => '56465334@qq.com' }
  
  s.swift_versions = ['5']

  s.ios.deployment_target = '10.3'

  s.source           = { :git => 'https://github.com/FooyoSG/FYTool.git', :tag => s.version.to_s }
  s.source_files = 'FYTool/Classes/*.swift'
  
  # s.resource_bundles = {
  #   'FYTool' => ['FYTool/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'SnapKit'
  s.dependency 'AlamofireImage'
  s.dependency 'Alamofire'
end
