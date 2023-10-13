//
//  ConfirmPhoneView.swift
//  Zuma
//
//  Created by Adrian Martushev on 5/27/23.
//

import SwiftUI
import FirebaseAuth
import Combine

extension UIPasteboard {
    var stringValue: String? {
        return UIPasteboard.general.string
    }
}


struct ConfirmPhoneView: View {
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
                        .onAppear {
                            print("test appear")
                        }
                    
                    Text("We protect our community by making sure everyone on Zuma is real.")
                        .font(.custom("LexendMega-Regular", size : 12))
                        .tracking(-2.0)
                        .padding(.vertical, 15)
                        .padding(.bottom, 15)
                    
                    HStack {
                        VerifyPhoneDigit(digit: $digit1)
                            .focused($activeField, equals: .digit1)
                            .onChange(of: digit1) { _ in activeField = .digit2 }
                            .onReceive(Just(UIPasteboard.general.stringValue ?? "")) { value in
                                guard value.count == 6, let digits = try? NSRegularExpression(pattern: "^\\d{6}$").firstMatch(in: value, options: [], range: NSRange(value.startIndex..., in: value)) else { return }

                                let characters = Array(value)
                                digit1 = String(characters[0])
                                digit2 = String(characters[1])
                                digit3 = String(characters[2])
                                digit4 = String(characters[3])
                                digit5 = String(characters[4])
                                digit6 = String(characters[5])
                            }
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
                
                Spacer()
                
                HStack {
                    HStack {
                        
                        Text("This text should arrive within 30s")
                            .font(.custom("LexendMega-Regular", size : 10))
                            .tracking(-2.0)
                            .multilineTextAlignment(.leading)
                            .frame(width: 180)
                        
                        Spacer()
                    }
                    .frame(width: 240)
                    
                    Spacer()
                    
                    Button {
                        let verificationCode = "\(digit1)\(digit2)\(digit3)\(digit4)\(digit5)\(digit6)"

                        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")

                        let credential = PhoneAuthProvider.provider().credential(
                            withVerificationID: verificationID ?? "",
                            verificationCode: verificationCode
                        )

                        Auth.auth().signIn(with : credential) { authResult, error in
                            if let error = error as NSError? {
                                print("Error: \(error.localizedDescription)")
                                print("Error code: \(error.code)")
                                self.errorMessage = error.localizedDescription
                                
                                if error.code == 17044 {
                                    self.errorMessage = "The code you entered is incorrect. Please try again"
                                } else {
                                    self.errorMessage = error.localizedDescription
                                }
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
                                .fill( digit6 == "" ? Color("LightGray") : Color("Yellow"))
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
                    .alert("\(self.errorMessage)", isPresented: $showErrorMessage) {
                        Button("OK", role: .cancel) { }
                    }
                    
                    NavigationLink(destination: LocationView(), isActive: $navigate) {
                        EmptyView()
                    }
                }
                
                Spacer().frame(height: 50)

            }
            .padding()
            .padding(.horizontal, 20)
        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}


struct VerifyPhoneDigit : View {
    @Binding var digit : String
    @FocusState private var isFocused: Bool
    
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .frame(width : 45, height : 55)
                .offset(x : 4, y : 3)
            
            TextField("", text: $digit)
                .placeholder(when: digit.isEmpty) {
                    Text("X").foregroundColor(Color("Gray"))
                        .frame(width : 45, height : 55)
                        .multilineTextAlignment(.center)
                        .font(.custom("LexendMega-Medium", size : 12))

                }
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .font(.custom("LexendMega-Medium", size : 14))
                .tracking(-2.0)
                .frame(width : 45, height : 55)
                .background(.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 4)
                )
                .keyboardType(.numberPad)
                .focused($isFocused)
                .onReceive(Just(digit)) { newValue in
                    if newValue.count >= 1 {
                        isFocused = false
                    }
                }
        }
    }
}



struct ConfirmPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmPhoneView()
    }
}
