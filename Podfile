# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

workspace 'thermalcamera.workspace'

def shared_pods
  # No pods are currently shared.
end

target 'UIFramework' do
  project './BoothUI/BoothUI.xcodeproj'
  shared_pods
end

target 'thermalcamera' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  shared_pods

  # Pods for thermalcamera
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'GoogleSignIn'
  pod 'Alamofire'
  pod 'FirebaseUI'
  pod 'Firebase/Core'
  pod 'Firebase'
  pod 'ZIPFoundation', '~> 0.9'
  
  target 'thermalcameraTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'thermalcameraUITests' do
    # Pods for testing
  end

end
