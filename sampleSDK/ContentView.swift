//
//  ContentView.swift
//  sampleSDK
//
//  Created by Girish Jonnavithula on 11/1/23.
//

import SwiftUI
import WebKit
import WebView

struct ContentView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingPopover = false
    @State private var isLoggedIn = false
    var body: some View {
        NavigationStack {
            GeometryReader{ geo in
                VStack {
                    VStack{
                        Color.transcendDefault
                            .mask(Image("transcendMainLogo")
                                .resizable()
                                .scaledToFit()
                            )
                            .padding()
                    }
                    .frame(height: geo.size.height * (1/4))
                    
                    VStack(){
                        TextField("Email", text: $email)
                            .padding(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                            }
                            .padding(.horizontal)
                        
                        TextField("Password", text: $password)
                            .padding(10)
                            .foregroundColor(Color("transcendTextDefault"))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray,  lineWidth: 2)
                            }.padding(.horizontal)
                        
                        Button(action: {
                            isLoggedIn = true
                        })
                        {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .font(.title3)
                                .frame(maxWidth: geo.size.width)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color("transcendBlue"))
                                .cornerRadius(100)
                        }
                        .padding()
                        .padding(.vertical)
                        
                        HStack {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color.gray)
                            
                            Text("OR")
                                .foregroundColor(Color.gray)
                            
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color.gray)
                        }
                        .padding(.horizontal, 20)
                        
                        HStack {
                            Button(action: {
                                print("do Something")
                            })
                            {
                                Image("facebook")
                                    .font(.system(size: 20))
                                
                            }
                            Button(action: {
                                print("do Something")
                            })
                            {
                                Image("twitter")
                                    .font(.system(size: 20))
                                
                            }
                            
                            // Sample Use of TranscendWebViewUI
                            Button(action: {
                                showingPopover = true
                            })
                            {
                                Image("google")
                                    .font(.system(size: 20))
                                
                            }
                            .popover(isPresented: $showingPopover) {
                                TranscendWebViewUI(transcendConsentUrl: "https://transcend-cdn.com/cm/a3b53de6-5a46-427a-8fa4-077e4c015f93/airgap.js")
                                    .foregroundColor(Color.transcendDefault)
                                    .padding()
                            }
                        }
                        .padding()
                        .padding(.vertical)
                        
                        
                        HStack {
                            Text("New?")
                            Link(destination: URL(string: "https://transcend.io/contact")!, label: {
                                Text("Sign-up")
                            })
                            Text("for new account.")
                        }.padding()
                        
                        
                    }.frame(height: geo.size.height * (3/4))
                    
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
            .navigationDestination(
                isPresented: $isLoggedIn) {
                    HomeView()
                        .navigationBarBackButtonHidden()
            }
        }
    }
}


#Preview {
    ContentView()
}
