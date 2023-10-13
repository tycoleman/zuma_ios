//
//  EnterCodeView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/1/23.
//

import SwiftUI
import Combine


struct EnterCodeView: View {
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    @State private var digit1: String = ""
    @State private var digit2: String = ""
    @State private var digit3: String = ""
    @State private var digit4: String = ""
    @State private var digit5: String = ""
    @State private var digit6: String = ""

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigate = false
    
    @State var showErrorMessage = false
    @State var showConfirmMessage = false

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
                    
                    
                    Text("Enter your code")
                        .font(.custom("LexendMega-Bold", size : 25))
                        .tracking(-3.0)
                        .padding(.top, 40)
                    
                    Text("Wow, you must know someone famous!")
                        .font(.custom("LexendMega-Regular", size : 12))
                        .tracking(-2.0)
                        .padding(.top, 5)
                        .padding(.bottom, 30)
                    
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
                
                Spacer()
                
                
                HStack {
                    Spacer()
                    
                    
                    Button {
                        let verificationCode = "\(digit1)\(digit2)\(digit3)\(digit4)\(digit5)\(digit6)"
                        
                        currentUser.verifyReferralCode(code : verificationCode) { done in
                            if(done) {
                                showConfirmMessage = true
                                self.errorMessage = "This code is valid. Welcome to Zuma!"
                                
                            } else {
                                showErrorMessage = true
                                self.errorMessage = "That code is invalid"
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
                    .alert("\(self.errorMessage)", isPresented: $showErrorMessage) {
                        Button("OK", role: .cancel) { }
                    }
                    
                    
                }

                
                NavigationLink(destination: OpenZumaView(), isActive: $navigate) {
                    EmptyView()
                }
                .alert("\(self.errorMessage)", isPresented: $showConfirmMessage) {
                    Button("Continue", role: .cancel) {
                        navigate = true
                        currentUser.updateMembership(status: "accepted")
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




struct VerifyCodeDigit : View {
    @Binding var digit : String
    @FocusState private var isFocused: Bool
    
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .frame(width : 45, height : 55)
                .offset(x : 4, y : 3)
            
            TextField("X", text: $digit)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("Gray"))
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

struct EnterCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeView()
    }
}
