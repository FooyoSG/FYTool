Pod::Spec.new do |s|
    s.name             = 'FYTool'
    s.version          = '0.1.3'
    s.summary          = 'Tool library and constant.'
   
    s.description      = <<-DESC
    Some commonly used extension methods, Tool library.
                         DESC
   
    s.homepage         = 'https://fooyo.sg'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'chinghoi' => '56465334@qq.com' }
    s.source           = { :git => 'https://github.com/FooyoSG/FYTool.git', :tag => s.version.to_s }
    s.source_files = 'Source/*.swift'
   
    s.swift_versions = ['5.1', '5.2']
    s.ios.deployment_target = '10.0'
   
  end