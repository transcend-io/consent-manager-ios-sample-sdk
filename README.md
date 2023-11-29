# Sample IOS Application

We provide an IOS xcframework that includes release builds(archives) for the following destinations:

- `generic/platform=iOS`
- `generic/platform=iOS Simulator`
- `platform=macOS`

The framework contains the majority of the logic for saving TCF-related data and interacting with the organization-specific mobile/bridge.js which handles displaying the UI and passing information between the WebView and the SDK. Below is a list of steps necessary to utilize the Transcend WebView library:

### Step 1: Include Our Framework

- The package can be added Manually or using Cocoapods.

Note: Just a heads up, the Cocoapod approach isn't ready for use just yet. We'll be rolling it out by Nov 30th.

### Manual Steps

- Download the most recent version of our framework for Xcode from links below, and extract the file. Make sure your Xcode version ≥ 12.
    
    [Transcend.xcframework.tar.gz](https://prod-files-secure.s3.us-west-2.amazonaws.com/f1be32b9-2269-4d29-904a-8034e91c4d79/97bdb3d8-8e9d-4353-ac7b-9dbc2946b755/Transcend.xcframework.tar.gz)
    
    [Transcend.xcframework.zip](https://prod-files-secure.s3.us-west-2.amazonaws.com/f1be32b9-2269-4d29-904a-8034e91c4d79/c0877dea-d1dd-466f-93f4-e59e8f39ff39/Transcend.xcframework.zip)
    
- Select your project and appropriate target in Xcode.
- Scroll down to `Frameworks, Libraries, and Embedded Content`.
- **Approach 1**: Dragging in the Transcend XCFramework will automatically establish it as a dependency for your target.
- **Approach 2:**
    - Click ‘+’ symbol just below the `Frameworks, Libraries, and Embedded Content`click on to see
    - Notice that `choose frameworks and libraries to add` pop-up opens up.
    - Click on `Add other files` option to search and add the extracted Transcend.xcframework.

![image](https://github.com/transcend-io/consent-manager-ios-sample-sdk/assets/23165664/d007cf9b-8c53-4f49-a2d1-f5a4dab67494)


### Step 2: Use the custom Transcend WebView (Share the AirgapUrl)

- Application developers collecting consent with our WebView have the flexibility to employ this view in various contexts based on their application's logic. They can integrate this view during their application's startup view , or in response to a button click event. To use Transcend’s webView in SwiftUI the following changes are required:
    
    ### Documentation for TranscendConsentWebViewUI
    
    ```swift
    // For iOS.V>=13.0 we expose TranscendConsentWebViewUI 
    @available(iOS 13.0, *)
    public struct TranscendWebViewUI : View {
    
        public var transcendConsentUrl: String
    
        public init(transcendConsentUrl: String)
    
        /// The content and behavior of the view.
        ///
        /// When you implement a custom view, you must implement a computed
        /// `body` property to provide the content for your view. Return a view
        /// that's composed of built-in views that SwiftUI provides, plus other
        /// composite views that you've already defined:
        ///
        ///     struct MyView: View {
        ///         var body: some View {
        ///             Text("Hello, World!")
        ///         }
        ///     }
        ///
        /// For more information about composing views and a view hierarchy,
        /// see <doc:Declaring-a-Custom-View>.
        @MainActor public var body: some View { get }
    
        /// The type of view representing the body of this view.
        ///
        /// When you create a custom view, Swift infers this type from your
        /// implementation of the required ``View/body-swift.property`` property.
        public typealias Body = some View
    }
    ```
    
    ### Usage of TransendConsentWebViewUI
    
    ```swift
    struct ContentView: View {
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
              TranscendWebViewUI(transcendConsentUrl: "https://transcend-cdn.com/cm/a3b53de6-5a46-427a-8fa4-077e4c015f93/airgap.js")
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
    
    ### Documentation of TranscendWebView

    ```swift
    // for iOS.V<13.0 we expose the following TranscendWebView class
    // that inherits WKWebView, WKNavigationDelegate
    
    @MainActor @objc public class TranscendWebView : WKWebView, WKNavigationDelegate {
    
        @MainActor public var transcendConsentUrl: String
    
        @MainActor public init(frame: CGRect, configuration: WKWebViewConfiguration, transcendConsentUrl: String)
    
        @MainActor override dynamic public init(frame: CGRect, configuration: WKWebViewConfiguration)
    
        @MainActor required dynamic public init?(coder: NSCoder)
    
        @MainActor public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    
        @MainActor public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)
    }
    
    // Usage would be similar to that of how we use WKWebView but notice that
    // the init has an extra parameter of transcendConsentUrl 
    // transcendConsentUrl would require your Organizations Airgap bundle url
    // Note: transendConsenturl can be found at
    // https://app.transcend.io/consent-manager/developer-settings/installation
    ```


  
