//
//  AccountDeletionViews.swift
//  Zuma
//
//  Created by Adrian Martushev on 7/3/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import Combine

struct AccountDeletionView : View {
    
    @State private var countryCode: String = "US  +1"
    @State private var phoneNumber = ""

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var currentUser : CurrentUserViewModel
    @State private var navigate = false

    @State var showErrorMessage = false
    @State var errorMessage = ""
    
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image("backArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24)
                            Spacer()
                        }

                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)


                    
                    VStack(alignment : .leading) {
                        Text("Please confirm your phone number to continue with account deletion")
                            .font(.custom("LexendMega-Bold", size : 16))
                            .tracking(-3.0)
                            .padding(.top, 40)
                        
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.black)
                                    .frame(width : 77, height : 55)
                                    .offset(x : 4, y : 3)
                                
                                TextField("US +1", text : $countryCode)
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
                                    .frame(width : 45, height : 45)
                                    .offset(x : 3, y : 3)
                                
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(Color("Yellow"))
                                    .frame(width : 45, height : 45)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 100)
                                            .stroke(.black, lineWidth: 4)
                                    )
                                
                                Image("chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width : 14, height : 18)


                            }
                        }
                        .alert(errorMessage, isPresented: $showErrorMessage) {
                            Button("OK", role: .cancel) { }
                        }
                        
                        NavigationLink(destination: ConfirmPhoneForAccountDeletionView(), isActive: $navigate) {
                            EmptyView()
                        }
                    }
                    
                    Spacer().frame(height: 50)

                }
                .padding(.vertical)
                .padding(.horizontal, 30)
            }
            .background(Color("BabyBlue"))
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}



struct ConfirmPhoneForAccountDeletionView : View {
    
    @State private var digit1: String = ""
    @State private var digit2: String = ""
    @State private var digit3: String = ""
    @State private var digit4: String = ""
    @State private var digit5: String = ""
    @State private var digit6: String = ""

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigate = false
    
    @State var showErrorMessage = false
    @State var errorMessage = ""
    

    @FocusState private var activeField: Field?
    
    private enum Field {
        case digit1, digit2, digit3, digit4, digit5, digit6
    }
    
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
                                .frame(width: 24)
                            Spacer()
                        }
                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    
                    
                    Text("Verify your number")
                        .font(.custom("LexendMega-Bold", size : 25))
                        .tracking(-3.0)
                        .padding(.top, 40)
                        .onAppear {
                            print("test appear")
                        }
                    
                    HStack {
                        VerifyPhoneDigit(digit: $digit1)
                            .focused($activeField, equals: .digit1)
                            .onChange(of: digit1) { _ in activeField = .digit2 }
                        VerifyPhoneDigit(digit: $digit2)
                            .focused($activeField, equals: .digit2)
                            .onChange(of: digit2) { _ in activeField = .digit3 }
                        VerifyPhoneDigit(digit: $digit3)
                            .focused($activeField, equals: .digit3)
                            .onChange(of: digit3) { _ in activeField = .digit4 }
                        VerifyPhoneDigit(digit: $digit4)
                            .focused($activeField, equals: .digit4)
                            .onChange(of: digit4) { _ in activeField = .digit5 }
                        VerifyPhoneDigit(digit: $digit5)
                            .focused($activeField, equals: .digit5)
                            .onChange(of: digit5) { _ in activeField = .digit6 }
                        VerifyPhoneDigit(digit: $digit6)
                            .focused($activeField, equals: .digit6)
                    }
                }
                .frame(width : 320)
                
                HStack {
                    Spacer()
                    Text("This text should arrive within 30s")
                        .font(.custom("LexendMega-Regular", size : 10))
                        .tracking(-2.0)
                        .multilineTextAlignment(.leading)
                        .frame(width: 180)
                    Spacer()

                }
                
                Spacer()
                
                VStack {
                    
                    Spacer()
                    
                    Button {
                        let verificationCode = "\(digit1)\(digit2)\(digit3)\(digit4)\(digit5)\(digit6)"

                        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")

                        let credential = PhoneAuthProvider.provider().credential(
                            withVerificationID: verificationID ?? "",
                            verificationCode: verificationCode
                        )

                        let user = Auth.auth().currentUser
                        let userID = user!.uid
                        // Prompt the user to re-provide their sign-in credentials

                        user?.reauthenticate(with : credential) { authResult, error in
                          if let error = error {
                            // An error happened.
                          } else {
                            // User re-authenticated, continue to delete
                              
                              let userRef = database.collection("users").document(userID)
                              
                              userRef.updateData([
                                  "accountStatus": "deleted"
                              ]) { err in
                                  if let err = err {
                                      print("Error updating document: \(err)")
                                  } else {
                                      print("Application Status : Deleted" )
                                    
                                      user?.delete { error in
                                        if let error = error {
                                          // An error happened.
                                            print(error.localizedDescription)
                                        } else {
                                          // Account deleted.
                                            print("User Deleted")
           
                                        }
                                      }
                                  }
                              }
                          }
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.black)
                                .frame( height : 60)
                                .offset(x : 7, y : 7)

                            HStack {
                                Spacer()

                                Image(systemName: "trash.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 27, height: 27)
                                    .foregroundColor(.black)

                                
                                Text("Confirm Delete")
                                    .font(.custom("LexendMega-Bold", size : 15))
                                    .tracking(-2.0)
                                    .foregroundColor(.black)
                                    .padding(.leading, 10)
                                
                                Spacer()
                            }
                            .frame(height : 60)
                            .frame(maxWidth : .infinity)
                            .background(Color("LightGray"))
                            .cornerRadius(100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(.black, lineWidth: 4)
                            )
                        }
                        .padding(.horizontal)
                        
                    }
                    .alert("\(self.errorMessage)", isPresented: $showErrorMessage) {
                        Button("OK", role: .cancel) { }
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
