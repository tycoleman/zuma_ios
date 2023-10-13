//
//  SwiftUIView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/1/23.
//

import SwiftUI

struct EmailZumaView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var notifications : Notifications
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    
    @State var isSelected = ""
    @State var placeholderString = "How can we help?"
    @State var content = ""
    @State var email = ""
    @State var showingErrorAlert = false
    @State var showingCompleteAlert = false
    

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image("backArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36)
                            Spacer()
                        }
                        .padding(.top, 70)
                        .padding(.leading, 15)
                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    
                    Spacer()
                    
                }
                
                HStack {
                    Text("Email Zuma")
                        .font(.custom("LexendMega-SemiBold", size : 15))
                        .tracking(-2.0)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.bottom, 20)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black)
                        .frame(height : 171)
                        .offset(x : 6, y : 6)
                    
                    
                    TextEditor(text : $content)
                        .onAppear {
                            if content.isEmpty {
                                content = placeholderString
                            }
                        }
                        .onTapGesture {
                            if content == placeholderString {
                                content = ""
                            }
                        }
                        .placeholder(when: content.isEmpty) {
                            Text("How can we help?").foregroundColor(Color("Gray"))
                        }
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("Gray"))
                        .font(.custom("LexendMega-Medium", size : 14))
                        .tracking(-2.0)
                        .padding(15)
                        .frame( height : 171)
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 4)
                        )
                    

                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black)
                        .frame( height : 55)
                        .offset(x : 4, y : 3)
                                        
                    TextField("What's your email?", text : $email)
                        .placeholder(when: email.isEmpty) {
                            Text("What's your email?").foregroundColor(Color("Gray"))
                        }
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                        .font(.custom("LexendMega-Medium", size : 14))
                        .tracking(-2.0)
                        .padding(.leading, 15)
                        .frame(height : 55)
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 4)
                        )
                }
                .padding(.top, 40)
                
                
                Button {
                    if(content == "" || content == "How can we help?" || email == "") {
                        showingErrorAlert = true
                    } else {
                        notifications.sendSupportEmail(title: "New Support Email", message: self.content, email: self.email)
                        showingCompleteAlert = true
                    }
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(.black)
                            .frame( height : 60)
                            .offset(x : 7, y : 7)

                        HStack {
                            Image("airplane")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 27, height: 27)
                                .padding(.leading, 30)
                            Spacer()

                            Text("Send")
                                .font(.custom("LexendMega-Bold", size : 15))
                                .tracking(-2.0)
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                                .offset(x:-40)
                            
                            Spacer()
                        }
                        .frame(height : 60)
                        .frame(maxWidth : .infinity)
                        .background(content == "" || content == "How can we help?" || email == "" ? Color("LightGray") : Color("Yellow") )
                        .cornerRadius(100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(.black, lineWidth: 4)
                        )
                    }
                }
                .padding(.top, 30)
                .alert("Please enter a message and email", isPresented: $showingErrorAlert) {
                    Button("OK", role: .cancel) { }

                }
                .alert("Thanks for reaching out! We'll get back to you shortly", isPresented: $showingCompleteAlert) {
                    Button("OK", role: .cancel) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            
                Spacer()

            }
            .padding(.vertical)
            .padding(.horizontal, 30)
        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct EmailZumaView_Previews: PreviewProvider {
    static var previews: some View {
        EmailZumaView()
    }
}
