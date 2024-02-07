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

    var body: some View {
        let onCloseListener: ((Result<Void, Error>) -> Void) = { result in
            switch result {
            case .success:
                self.showingPopover = false
            case .failure(let error):
                print("Error during web view navigation: \(error.localizedDescription)")
            }
        }
        ZStack {
           WebView(url: URL(string: "https://www.booking.com/")!)
               .frame(maxWidth: .infinity, maxHeight: .infinity)

            TranscendWebViewUI(transcendConsentUrl: "https://transcend-cdn.com/cm/90ab36ce-3da0-481c-ba8d-98eb820d716f/airgap.js",
                               isInit: false, onCloseListener: onCloseListener)
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

// NavigationStack {
//    GeometryReader { geo in
//        VStack {
//            VStack {
//                Color.transcendDefault
//                    .mask(Image("transcendMainLogo")
//                        .resizable()
//                        .scaledToFit()
//                    )
//                    .padding()
//            }
//            .frame(height: geo.size.height * (1/4))
//
//            VStack {
//                TextField("Email", text: $email)
//                    .padding(10)
//                    .overlay {
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.gray, lineWidth: 2)
//                    }
//                    .padding(.horizontal)
//
//                TextField("Password", text: $password)
//                    .padding(10)
//                    .foregroundColor(Color("transcendTextDefault"))
//                    .overlay {
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.gray, lineWidth: 2)
//                    }.padding(.horizontal)
//
//                Button(action: {
//                    if canUseAPI {
//                        isLoggedIn = true
//                    }
//                }) {
//                    Text("Sign In")
//                        .fontWeight(.semibold)
//                        .font(.title3)
//                        .frame(maxWidth: geo.size.width)
//                        .padding()
//                        .foregroundColor(.white)
//                        .background(Color("transcendBlue"))
//                        .cornerRadius(100)
//                }
//                .padding()
//                .padding(.vertical)
//
//                HStack {
//                    Rectangle()
//                        .frame(height: 2)
//                        .foregroundColor(Color.gray)
//
//                    Text("OR")
//                        .foregroundColor(Color.gray)
//
//                    Rectangle()
//                        .frame(height: 2)
//                        .foregroundColor(Color.gray)
//                }
//                .padding(.horizontal, 20)
//
//                HStack {
//                    Button(action: {
//                        print("do Something")
//                    }) {
//                        Image("facebook")
//                            .font(.system(size: 20))
//
//                    }
//                    Button(action: {
//                        print("do Something")
//                    }) {
//                        Image("twitter")
//                            .font(.system(size: 20))
//
//                    }
//
//                    // Sample Use of TranscendWebViewUI
//                    Button(action: {
//                        showingPopover = true
//                    }) {
//                        Image("google")
//                            .font(.system(size: 20))
//
//                    }
//                    .sheet(isPresented: $showingPopover) {
//                        // Note: Belongs to Managed Consent Database demo Org
//                       
//                    }
//                    
//                }
//                .padding()
//                .padding(.vertical)
//
//                HStack {
//                    Text("New?")
//                    Link(destination: URL(string: "https://transcend.io/contact")!, label: {
//                        Text("Sign-up")
//                    })
//                    Text("for new account.")
//                }.padding()
//
//            }.frame(height: geo.size.height * (3/4))
//
//        }
//        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//    }
//    .navigationDestination(
//        isPresented: $isLoggedIn) {
//            HomeView()
//                .navigationBarBackButtonHidden()
//    }
// }
