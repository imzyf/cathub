source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

target 'cathub' do

  pod 'R.swift', '5.0.0'
  pod 'SwiftLint', '0.29.2'
 
  pod 'SwifterSwift', '~> 4.6.0'  # https://github.com/SwifterSwift/SwifterSwift
  
    pod 'RxDataSources'
  
  # Image
  pod 'Kingfisher', '~> 5.0'
  
   pod 'SwiftyJSON'
  
   pod 'Moya/RxSwift'
  
  pod 'SnapKit'

  #  pod 'Moya-SwiftyJSON', :path => '../myPods/Moya-SwiftyJSON'

  pod 'Reveal-SDK', :configurations => ['Debug']

  
  target 'cathubTests' do
    inherit! :search_paths
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
      config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
      config.build_settings['SWIFT_VERSION'] = '4.2'
    end
  end
end
