//
//  SwiftUIView.swift
//  sampleSDK
//
//  Created by Girish Jonnavithula on 11/1/23.
//

import SwiftUI
import WebKit
import Transcend

struct HomeView: View {
    @State public var showingPopover = false
    var body: some View {
        TabView {
            myWebView(url: URL(string: "https://transcend.io/")!)
                .tabItem {
                    Label("Transcend", systemImage: "safari")
                        .foregroundColor(.white)
                }
                .tag(1)

            myWebView(url: URL(string: "https://eshopit.co/")!)
                .tabItem {
                    Label("EshopIt", systemImage: "storefront")
                }
                .tag(2)
        }
        .onAppear {
            //  Usage of API is here
            //  Remember you created TranscendWebViewUI with didFinishNavigation on sampleSDKApp.swift
            //  our libray save this instance as a singleton instance as transcendAPI
            TranscendWebView.transcendAPI.webAppInterface.getRegimes(completionHandler: {result, error in
                if let error = error {
                    print("UI Error : \(error)")
                } else {
                    if result?.contains("us") == true {
                        self.showingPopover = true
                    }
                }
            })

            TranscendWebView.transcendAPI.webAppInterface.getConsent(completionHandler: {result, error in
                if let error = error {
                    print("UI Error : \(error)")
                } else {
                    let response: TrackingConsentDetails = (result) ?? TrackingConsentDetails()
                    for key in response.purposes.keys {
                        if let purpose = response.purposes[key] {
                            switch purpose {
                            case .bool(let value):
                                print("\(key) Bool Value: \(value)")
                            case .string(let value):
                                print("\(key) String Value: \(value)")
                            default:
                                print("No Value found for \(key)")
                            }
                        }
                    }
                }
            })

            TranscendWebView.transcendAPI.webAppInterface.getSDKConsentStatus(serviceId: "datadog-ios", completionHandler: {result, error in
                if let error = error {
                    print("UI Error : \(error)")
                } else {
                    if let status = result {
                        print(status)
                    }
                }
            })
        }
        .overlay {
            FloatingButton(action: {
                showingPopover = true
            }, showingPopover: $showingPopover)
        }

    }
}

struct FloatingButton: View {
    let action: () -> Void
    @State private var buttonOffset: CGSize = CGSize(width: 150, height: 280)
    @Binding public var showingPopover: Bool
    let transcendCoreConfigWithPrefSync: TranscendCoreConfig = TranscendCoreConfig(transcendConsentUrl: "https://transcend-cdn.com/cm/63b35d96-a6db-436f-a1cf-ea93ae4be24e/airgap.js", token: "eyJhbGciOiJIUzM4NCIsInR5cCI6IkpXVCJ9.eyJlbmNyeXB0ZWRJZGVudGlmaWVyIjoiK3dJWXk2SkdmcGxaUUZMWS9ETnQrTUNRS0dISENWckYiLCJpYXQiOjE3MDY5MTA2ODd9.d4zZoMPtriAPwC0HvJ6BqkOGdG_qcPjmRYNNkN_MfLvZDob1OzQcFUbfKFtFZKix")

    var body: some View {
        let onCloseListener: ((Result<TrackingConsentDetails, Error>) -> Void) = { result in
            switch result {
            case .success(let consentData):
                print("Onclose:: + \(consentData.purposes)")
                self.showingPopover = false
            case .failure(let error):
                print("Error during web view navigation: \(error.localizedDescription)")
            }
        }

            Button(action: action) {
                Image("transcendLogo")
                    .resizable()
                    .background(.white)
                    .frame(width: 60, height: 60)
                    .scaledToFit()
                    .cornerRadius(30)
            }
            .offset(buttonOffset)
            .frame(alignment: .bottom)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        withAnimation {
                            print(value)
                            buttonOffset = CGSize(width: value.location.x, height: value.location.y)
                        }
                    }
            )
            .sheet(isPresented: $showingPopover) {
                // Note: Belongs to Managed Consent Database demo Org
                // Initialized UI View
                TranscendWebViewUI(transcendCoreConfig: transcendCoreConfigWithPrefSync, onCloseListener: onCloseListener)
                .foregroundColor(Color.transcendDefault)
                .padding()
        }
    }
}

public struct myWebView: UIViewRepresentable {
    let webView = WKWebView()
    var url: URL

    public init(url: URL) {
        self.url = url
        self.webView.isInspectable = true
    }

    public func makeUIView(context: Context) -> WKWebView {
        return self.webView
    }
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }

}

#Preview {
    HomeView()
}
