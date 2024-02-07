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

        WindowGroup {
            ContentView(canUseAPI: $canUseAPI)
            // Note: Belongs to Managed Consent Database demo Org
            TranscendWebViewUI(transcendConsentUrl: "https://transcend-cdn.com/cm/90ab36ce-3da0-481c-ba8d-98eb820d716f/airgap.js",
                               isInit: true, didFinishNavigation: didFinishNavigation)
        }
    }

}
