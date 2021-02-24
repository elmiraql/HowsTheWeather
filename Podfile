 platform :ios, '13.0'

target 'HowsTheWeather' do
  use_frameworks!

  # Pods for HowsTheWeather
pod 'IQKeyboardManagerSwift'
end


post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
end
