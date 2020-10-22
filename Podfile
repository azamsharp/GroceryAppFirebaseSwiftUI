# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GroceryApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GroceryApp
# add the Firebase pod for Google Analytics
pod 'Firebase/Analytics'
# add pods for any other desired Firebase products
# https://firebase.google.com/docs/ios/setup#available-pods
pod 'Firebase/Firestore'

# Optionally, include the Swift extensions if you're using Swift.
pod 'FirebaseFirestoreSwift'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
