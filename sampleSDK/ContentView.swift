//
//  ContentView.swift
//  sampleSDK
//
//  Created by Girish Jonnavithula on 11/1/23.
//

import SwiftUI
import WebKit
import Transcend

struct ContentView: View {
    @Binding var canUseAPI: Bool
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingPopover = false
    @State private var isLoggedIn = false
    @State private var showTranscendWebView = true

    var body: some View {
        let onCloseListener: ((Result<Void, Error>) -> Void) = { result in
            switch result {
            case .success:
                self.showTranscendWebView = false // Set showTranscendWebView to false
            case .failure(let error):
                print("Error during web view navigation: \(error.localizedDescription)")
            }
        }
       
        ZStack {
            WebView(url: URL(string: "https://www.booking.com/")!)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            if showTranscendWebView {
                Color.black.opacity(0.5)
                TranscendWebViewUI(transcendConsentUrl: "https://transcend-cdn.com/cm/90ab36ce-3da0-481c-ba8d-98eb820d716f/airgap.js",
                isInit: false, onCloseListener: onCloseListener)
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

#Preview {
    ContentView(canUseAPI: Binding<Bool>(get: { true }, set: { _ in }))
}
