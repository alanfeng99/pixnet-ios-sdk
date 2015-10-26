Pod::Spec.new do |s|
  s.name         = 'PIXNET-iOS-SDK'
  s.version      = '1.12.2'
  s.license      =  {:type => 'BSD'}
  s.homepage     = 'https://github.com/pixnet/pixnet-ios-sdk'
  s.authors      =  {'PIXNET' => 'sdk@pixnet.tw'}
  s.summary      = 'Integrate with PIXNET services.'

# Source Info
  s.platform     =  :ios, '6.0'
  s.source       =  {:git => 'https://github.com/pixnet/pixnet-ios-sdk.git', :tag => '1.12.2'}
  s.source_files =  'PIXNET-iOS-SDK/Classes/*.{h,m}', 'PIXNET-iOS-SDK/Classes/LROAuth2Client/*.{h,m}, 'PIXNET-iOS-SDK/SupportingFiles/**/*.*'
  s.framework    =  'CoreLocation'

  s.requires_arc = true
  
# Pod Dependencies
  s.dependency 'PIX-cocoa-oauth', '~> 0.0.1'
  s.dependency 'OMGHTTPURLRQ', '~> 2.1'
end
