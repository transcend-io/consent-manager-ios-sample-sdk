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
         let transcendCoreConfigSimple: TranscendCoreConfig = TranscendCoreConfig(transcendConsentUrl: "https://transcend-cdn.com/cm/63b35d96-a6db-436f-a1cf-ea93ae4be24e/airgap.js")

        // If you have any webView that you would open on this application
        // and need to carry forward the consent state the use syncDomain
        // In the line below, we have include sync domain "https://eshopit.co/"
        // Which might, at some point, in this application be opened as a webview
        // and you might require consent data to passed on to this webview
         let transcendCoreConfigWithSyncDomain: TranscendCoreConfig = TranscendCoreConfig(transcendConsentUrl: "https://transcend-cdn.com/cm/63b35d96-a6db-436f-a1cf-ea93ae4be24e/airgap.js", syncDomains: ["https://eshopit.co/"])

        // If you want to use preference store to sync logged In users data
        let transcendCoreConfigWithPrefSync: TranscendCoreConfig = TranscendCoreConfig(transcendConsentUrl: "https://transcend-cdn.com/cm/63b35d96-a6db-436f-a1cf-ea93ae4be24e/airgap.js", token: "eyJhbGciOiJIUzM4NCIsInR5cCI6IkpXVCJ9.eyJlbmNyeXB0ZWRJZGVudGlmaWVyIjoiK3dJWXk2SkdmcGxaUUZMWS9ETnQrTUNRS0dISENWckYiLCJpYXQiOjE3MDY5MTA2ODd9.d4zZoMPtriAPwC0HvJ6BqkOGdG_qcPjmRYNNkN_MfLvZDob1OzQcFUbfKFtFZKix")

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
