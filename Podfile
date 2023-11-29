# Uncomment the next line to define a global platform for your project
platform :ios, '17.0'

target 'sampleSDK' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Approach 1: For Transced Developers, If you are building sample appliciation locally
  # Note: Transcend customers cannot use this approach yet since we didn't pulish our cocoapod live
  # Step 1: Clone https://github.com/transcend-io/consent-manager-ios-library
  # Step 2: Build the library by clicking play button on Xcode or refer build command for ios-library's .github/workflows/build.yaml
  # Step 3: Uncomment the line below to use our library
  # pod 'WebView', :path=> "../WebView/"
  
  # Approach 2:
  # For Transcend Developers
  # We already have our framework build included in sampleSDK Frameworks(on XCODE check sampleSDK/Frameworks/Release-iphonesimulator)
  # But if you are working on ios-library and want to change functionality in framework
  # Step 1: Build the library and find the build directory path
  # Step 2: delete the sampleSDK/Frameworks/Release-iphonesimulator and upload latest build
  # For Transcend Customers:
  # Step 1: Download the Build.tar.gz or Build.zip
  # Step 2: Unizp and include the WebView.Framework and Pod_WebView.Framework on you applications Framework folder.
  target 'sampleSDKTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'sampleSDKUITests' do
    # Pods for testing
  end

end
