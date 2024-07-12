# Sample IOS Application

We provide an IOS xcframework that includes release builds(archives) for the following destinations:

- `generic/platform=iOS`
- `generic/platform=iOS Simulator`
- `platform=macOS`

The framework contains the majority of the logic for saving TCF-related data and interacting with the organization-specific mobile/bridge.js which handles displaying the UI and passing information between the WebView and the SDK. Below is a list of steps necessary to utilize the Transcend WebView library:

## Include Our Framework

- You can integrate the Framework into your application using one of the following methods:

### Manual Steps

- Download the most recent version of our framework for Xcode from links below, and extract the file. Make sure your Xcode version ≥ 12.
[Transcend.xcframework.tar.gz](https://github.com/transcend-io/consent-manager-ios-sample-sdk/files/13526419/Transcend.xcframework.tar.gz)
[Transcend.xcframework.zip](https://github.com/transcend-io/consent-manager-ios-sample-sdk/files/13526425/Transcend.xcframework.zip)
- Select your project and appropriate target in Xcode.
- Scroll down to `Frameworks, Libraries, and Embedded Content`.
- **Approach 1**: Dragging in the Transcend XCFramework will automatically establish it as a dependency for your target.
- **Approach 2:**
    - Click ‘+’ symbol just below the `Frameworks, Libraries, and Embedded Content`click on to see
    - Notice that `choose frameworks and libraries to add` pop-up opens up.
    - Click on `Add other files` option to search and add the extracted Transcend.xcframework.

![image](https://github.com/transcend-io/consent-manager-ios-sample-sdk/assets/23165664/d007cf9b-8c53-4f49-a2d1-f5a4dab67494)

### Using Cocoapods

- Add the dependency on your project's Podfile
    - `pod 'Transcend'`
- Run `pod install` to fetch the Transcend Framework.

### Using Swift Package Manager

```
    https://github.com/transcend-io/Transcend-spm-sdk.git
```

## Usage
Please consult the documentation [here](https://docs.transcend.io/docs/consent-management/mobile-consent/ios) for more details.

### Initialization of API instance 

A reference for the API instance in this repository can be found [here](https://github.com/transcend-io/consent-manager-ios-sample-sdk/blob/dev/sampleSDK/sampleSDKApp.swift#L45)
- Note: This will not render Consent Banner on UI but would allow you to call API's such as `getRegimes()` which is listed below.
```
    import SwiftUI
    import Transcend
    
    // Usage
    // completionHandler
    let BUNDLE_ID = "your-airgap-bundle-id"
    let MOBILE_APP_ID = "your-mobile-app-id"
    let didFinishNavigation: ((Result<Void, Error>) -> Void) = { result in
      switch result {
        case .success():
          // Your logic goes here
        case .failure(let error):
          print("Error during web view navigation: \(error.localizedDescription)")
      }
    }
    // Create TranscendCoreConfig
    let simpleCoreConfig: TranscendCoreConfig = TranscendCoreConfig(
      transcendConsentUrl: "https://transcend-cdn.com/cm/\(BUNDLE_ID)/airgap.js", mobileAppId: MOBILE_APP_ID)
    
    TranscendWebViewUI(transcendCoreConfig: simpleCoreConfig, didFinishNavigation: didFinishNavigation)
```


### API Usage

A reference for the API Usage in this repository can be found [here](https://github.com/transcend-io/consent-manager-ios-sample-sdk/blob/dev/sampleSDK/HomeView.swift#L33).
- Full list of support APIs are listed [here](https://docs.transcend.io/docs/consent-management/mobile-consent/ios/api#1.0.9:definitions-and-usage-of-the-api).
```
// Usage
// Note: can be used only after didFinishNavigation returns .success
TranscendWebView.transcendAPI.webAppInterface.getRegimes(completionHandler: { result, error in
  if let error = error {
    // Your logic goes here
    print("UI Error : \(error)")
  } else {
    // Your logic goes here
    if result?.contains("us") == true {
      self.showTranscendWebView = true
    }
  }
})
```

### Show Consent banner
A reference for displaying the consent banner in this repository can be found [here](https://github.com/transcend-io/consent-manager-ios-sample-sdk/blob/dev/sampleSDK/HomeView.swift#L121)

```
import Transcend

struct ContentView: View {
    let BUNDLE_ID = "your-airgap-bundle-id"
    let MOBILE_APP_ID = "your-mobile-app-id"
    let simpleCoreConfig: TranscendCoreConfig = TranscendCoreConfig(
      transcendConsentUrl: "https://transcend-cdn.com/cm/\(BUNDLE_ID)/airgap.js", mobileAppId: MOBILE_APP_ID)

    var body: some View {
      // Sample Use of TranscendWebViewUI
      Button(action: {
          showingPopover = true
      })
      {
          Image("google")
              .font(.system(size: 20))
          
      }
      .popover(isPresented: $showingPopover) {
            TranscendWebViewUI(transcendCoreConfig: simpleCoreConfig, didFinishNavigation: didFinishNavigation)
              .foregroundColor(Color.transcendDefault)
              .padding()
      }
    }
                        
  }
}

#Preview {
    ContentView()
}
```
