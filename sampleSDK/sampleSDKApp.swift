//
//  sampleSDKApp.swift
//  sampleSDK
//
//  Created by Girish Jonnavithula on 11/1/23.
//

import SwiftUI
import Transcend
@main
struct sampleSDKApp: App {
    @State var canUseAPI: Bool = false
    
    var body: some Scene {
        
        let didFinishNavigation: ((Result<Void, Error>) -> Void) = { result in
            switch result {
            case .success:
                self.canUseAPI = true
            case .failure(let error):
                print("Error during web view navigation: \(error.localizedDescription)")
            }
        }
        
        // Simple config object
        // expects only your airgap bundle url
        let transcendCoreConfigSimple: TranscendCoreConfig = TranscendCoreConfig(transcendConsentUrl: "https://transcend-cdn.com/cm/0016865d-822d-4574-8235-546152a5b53e/airgap.js",  mobileAppId: "TextNow iOS")
        
        // If you have any webView that you would open on this application
        // and need to carry forward the consent state the use syncDomain
        // In the line below, we have include sync domain "https://example.com/"
        // Which might, at some point, in this application be opened as a webview
        // and you might require consent data to passed on to this webview
        let transcendCoreConfigWithSyncDomain: TranscendCoreConfig = TranscendCoreConfig(transcendConsentUrl: "https://transcend-cdn.com/cm/0016865d-822d-4574-8235-546152a5b53e/airgap.js", syncDomains: ["https://example.com/"], mobileAppId: "TextNow iOS")
        
        // If you want to use preference store to sync logged In users data
        let transcendCoreConfigWithPrefSync: TranscendCoreConfig = TranscendCoreConfig(transcendConsentUrl: "https://transcend-cdn.com/cm/0016865d-822d-4574-8235-546152a5b53e/airgap.js", token: "eyJhbGciOiJIUzM4NCIsInR5cCI6IkpXVCJ9.eyJlbmNyeXB0ZWRJZGVudGlmaWVyIjoiYlZWaW05TXBqWWRESVVsaFM3dVF2dkhWYkcxMXFIejduZkZrM3l2X3d5ST0iLCJpYXQiOjE3Mzk4MTUzMjZ9.53haOFCAmB4pby1bT5v6Es5ILZH_UyctxZtBkXf6T0gq1icXbfvDn9aG8fwzKI0Y", mobileAppId: "TextNow iOS")
        
        WindowGroup {
            ContentView(canUseAPI: $canUseAPI)
            // Note: Belongs to Managed Consent Database demo Org
            // Backend API instance init
            // Will not show any UI when didFinishNavigation is attached
            // assumes it to be a backend instance
            TranscendWebViewUI(transcendCoreConfig: transcendCoreConfigWithPrefSync, didFinishNavigation: didFinishNavigation)
        }
    }
    
}
