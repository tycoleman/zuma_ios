//
//  LoginView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/14/23.
//


import SwiftUI
import FirebaseAuth


struct LoginView: View {
    @State private var countryCode: String = "US  +1"
    @State private var phoneNumber = ""

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var currentUser : CurrentUserViewModel
    @State private var navigate = false

    @State var showErrorMessage = false
    @State var errorMessage = ""
    
    
    var body: some View {
        VStack {
            VStack {
                
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


                
                VStack(alignment : .leading) {
                    Text("What's your number?")
                        .font(.custom("LexendMega-Bold", size : 25))
                        .tracking(-3.0)
                        .padding(.top, 40)
                    
                    Text("We'll send you a 6 digit code to login to your account with.")
                        .font(.custom("LexendMega-Regular", size : 12))
                        .tracking(-2.0)
                        .padding(.vertical, 15)
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame(width : 77, height : 55)
                                .offset(x : 4, y : 3)
                            
                            TextField("Enter your phone number", text : $countryCode)
                                .multilineTextAlignment(.center)
                                .font(.custom("LexendMega-Regular", size : 12))
                                .tracking(-2.0)
                                .frame(width : 77, height : 55)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                        }
                        .padding(.trailing, 15)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame(width : 177, height : 55)
                                .offset(x : 4, y : 3)
                            
                            TextField("Phone number", text : $phoneNumber)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color("Gray"))
                                .font(.custom("LexendMega-Medium", size : 14))
                                .tracking(-2.0)
                                .padding(.leading, 15)
                                .frame(width : 177, height : 55)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                                .keyboardType(.numberPad)
                        }
                    }
                }
                .frame(width : 320)
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    Button {
                        currentUser.phoneNumber = "+1\(self.phoneNumber)"
                        
                        PhoneAuthProvider.provider()
                            .verifyPhoneNumber("+1\(self.phoneNumber)", uiDelegate: nil) { verificationID, error in
                                  if let error = error {
                                      print(error.localizedDescription)
                                      self.errorMessage = error.localizedDescription
                                      showErrorMessage = true
                                      return
                                  }
                                  // Sign in using the verificationID and the code sent to the user
                                  // ...
                                navigate = true
                                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
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
                    .alert(errorMessage, isPresented: $showErrorMessage) {
                        Button("OK", role: .cancel) { }
                    }
                    
                    NavigationLink(destination: ConfirmPhoneLoginView(), isActive: $navigate) {
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
