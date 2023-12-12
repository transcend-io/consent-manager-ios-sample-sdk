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
        let didFinishNavigation: ((Result<Void,Error>) -> Void) = { result in
            switch result {
            case .success():
                self.canUseAPI = true
            case .failure(let error):
                print("Error during web view navigation: \(error.localizedDescription)")
            }
        }
        
        WindowGroup {
            ContentView(canUseAPI: $canUseAPI)
            TranscendWebViewUI(transcendConsentUrl: "https://transcend-cdn.com/cm/a3b53de6-5a46-427a-8fa4-077e4c015f93/airgap.js",
                                    isInit: true, didFinishNavigation: didFinishNavigation)
        }
    }
}
