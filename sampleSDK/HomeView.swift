//
//  SwiftUIView.swift
//  sampleSDK
//
//  Created by Girish Jonnavithula on 11/1/23.
//

import SwiftUI
import WebKit


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
        }.overlay {
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
    
    var body: some View{
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
//                TranscendWebViewUI(transcendConsentUrl: "https://transcend-cdn.com/cm/a3b53de6-5a46-427a-8fa4-077e4c015f93/airgap.js")
//                    .foregroundColor(Color.transcendDefault)
//                    .padding()
        }
    }
}

public struct myWebView: UIViewRepresentable  {
    let webView = WKWebView()
    var url: URL;

    public init(url: URL) {
        self.url = url
    }
    
    public func makeUIView(context: Context) -> WKWebView{
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
