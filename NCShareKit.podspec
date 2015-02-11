Pod::Spec.new do |s|
  s.name         = 'NCShareKit'
  s.version      = '0.0.1'
  s.summary      = 'Categories and macros for convenience.'
  s.homepage     = 'https://github.com/nickcheng/NCShareKit'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'nickcheng' => 'n@nickcheng.com' }

  s.source       = { :git => 'https://github.com/nickcheng/NCShareKit.git', :tag => '0.0.1' }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'NCShareKit/**/*.{h,m}'
  s.public_header_files = 'NCShareKit/**/*.h'
  s.resource_bundles = { 'NCShareKit' => 'NCShareKit/*.xcassets'}

  s.dependency 'libWeChatSDK', '1.5'
  s.dependency 'WeiboSDK', '3.0.1'
  s.dependency 'UIImage-ResizeMagick', '0.0.1'

end
