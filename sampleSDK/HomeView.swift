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
    @State var showTranscendWebView = false

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
            if self.showTranscendWebView {
                // Note: Belongs to Managed Consent Database demo Org
                TranscendWebViewUI(transcendConsentUrl: "https://transcend-cdn.com/cm/ 63b35d96-a6db-436f-a1cf-ea93ae4be24e/airgap.js",
                                   isInit: false, didFinishNavigation: nil)
                    .tabItem {
                        Label("Consent", systemImage: "storefront")
                    }
                    .tag(3)
            }
        }
        .onAppear {
            TranscendWebView.transcendAPI.webAppInterface.getRegimes(completionHandler: {result, error in
                if let error = error {
                    print("UI Error : \(error)")
                } else {
                    if result?.contains("us") == true {
                        self.showTranscendWebView = true
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

    var body: some View {
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
            .popover(isPresented: $showingPopover) {
                // Note: Belongs to Managed Consent Database demo Org
                TranscendWebViewUI(transcendConsentUrl: "https://transcend-cdn.com/cm/63b35d96-a6db-436f-a1cf-ea93ae4be24e/airgap.js",
                                   isInit: false, didFinishNavigation: nil)
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
