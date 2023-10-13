//
//  ConfirmPhoneLoginView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/14/23.
//

import SwiftUI
import FirebaseAuth

struct ConfirmPhoneLoginView: View {
    @State private var digit1: String = ""
    @State private var digit2: String = ""
    @State private var digit3: String = ""
    @State private var digit4: String = ""
    @State private var digit5: String = ""
    @State private var digit6: String = ""

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigate = false
    
    @State var showErrorMessage = true
    @State var errorMessage = ""
    
    
    var body: some View {
        VStack {
            VStack {
                VStack(alignment : .leading) {
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
                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    
                    
                    Text("Verify your number")
                        .font(.custom("LexendMega-Bold", size : 25))
                        .tracking(-3.0)
                        .padding(.top, 40)
                
                    
                    HStack {
                        ConfirmPhoneDigit(digit: $digit1)
                        ConfirmPhoneDigit(digit: $digit2)
                        ConfirmPhoneDigit(digit: $digit3)
                        ConfirmPhoneDigit(digit: $digit4)
                        ConfirmPhoneDigit(digit: $digit5)
                        ConfirmPhoneDigit(digit: $digit6)
                    }
                }
                .frame(width : 320)
                
                Spacer()
                
                HStack {
                    HStack {
                        
                        Text("This text should arrive within 30s")
                            .font(.custom("LexendMega-Regular", size : 10))
                            .tracking(-2.0)
                            .multilineTextAlignment(.leading)
                            .frame(width: 180)

                    }
                    .frame(width: 240)
                    
                    Spacer()
                    
                    Button {
                        let verificationCode = "\(digit1)\(digit2)\(digit3)\(digit4)\(digit5)\(digit6)"
//                        navigate = true
                        
                        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")

                        let credential = PhoneAuthProvider.provider().credential(
                            withVerificationID: verificationID ?? "",
                            verificationCode: verificationCode
                        )
                        
                        Auth.auth().signIn(with : credential) { authResult, error in
                            if error != nil {
                                print(error?.localizedDescription)
                                self.errorMessage = error?.localizedDescription ?? "Something went wrong."
                                showErrorMessage = true
                                
                            } else {
                                print("signed in")
                                navigate = true

                            }
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.black)
                                .frame(width : 68, height : 68)
                                .offset(x : 3, y : 3)
                            
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color("Yellow"))
                                .frame(width : 65, height : 65)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                        .stroke(.black, lineWidth: 4)
                                )
                            
                            Image("chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width : 16, height : 24)
                        }
                    }
                    
                    NavigationLink(destination: LocationView(), isActive: $navigate) {
                        EmptyView()
                    }

                }

                
                Spacer().frame(height: 50)

            }
            .padding()
        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}


struct ConfirmPhoneLoginView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmPhoneLoginView()
    }
}
