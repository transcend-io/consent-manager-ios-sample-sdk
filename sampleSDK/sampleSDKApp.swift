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
        
        // If you have any webView that you would open on this application
        // and need to carry forward the consent state the use syncDomain
        // In the line below, we have include sync domain "https://example.com/"
        // Which might, at some point, in this application be opened as a webview
        // and you might require consent data to passed on to this webview
        let transcendCoreConfigWithSyncDomain: TranscendCoreConfig = TranscendCoreConfig(transcendConsentUrl: "https://transcend-cdn.com/cm-test/e622c065-89e6-4b3c-b31f-46428a1e7b86/airgap.js", syncDomains: ["https://example.com/"], mobileAppId: "RideshareTest")
        
        // If you want to use preference store to sync logged In users data
        let transcendCoreConfigWithPrefSync: TranscendCoreConfig = TranscendCoreConfig(transcendConsentUrl: "https://transcend-cdn.com/cm-test/e622c065-89e6-4b3c-b31f-46428a1e7b86/airgap.js", token: "{TOKEN}")
        
        WindowGroup {
            ContentView(canUseAPI: $canUseAPI)
            // Note: Belongs to Managed Consent Database demo Org
            // Backend API instance init
            // Will not show any UI when didFinishNavigation is attached
            // assumes it to be a backend instance
            TranscendWebViewUI(transcendCoreConfig: transcendCoreConfigWithSyncDomain, didFinishNavigation: didFinishNavigation)
        }
    }
    
}
