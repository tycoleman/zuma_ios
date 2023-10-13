//
//  ContentView.swift
//  Zuma
//
//  Created by Adrian Martushev on 5/27/23.
//
import SwiftUI

struct WelcomeView: View {
    var body: some View {
        
        NavigationStack {
            VStack {
                VStack {
                    Spacer()
                    Image("ZumaLogoClear")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                    Spacer()
                    
                    HStack {
                        Spacer()
                    }
                    
                    NavigationLink {
                        PhoneView()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.black)
                                .frame(width : 320, height : 60)
                                .offset(x : 7, y : 7)

                            Text("Apply")
                                .font(.custom("LexendMega-Bold", size : 15))
                                .tracking(-2.0)
                                .frame(width : 320, height : 60)
                                .foregroundColor(.black)
                                .background(Color("Yellow"))
                                .cornerRadius(100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                        .stroke(.black, lineWidth: 4)
                                )
                        }
                    }

                    
                    HStack (spacing : 0) {
                        Text("Already a member? ")
                            .font(.custom("LexendMega-Regular", size : 12))
                            .tracking(-2.0)
                        
                        
                        NavigationLink {
                            PhoneView()
                        } label: {
                            Text("Log-In")
                                .font(.custom("LexendMega-Bold", size : 12))
                                .tracking(-2.0)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.top, 20)
                    
                    Spacer().frame(height: 50)

                }
                .padding()
            }
            .background(Color("BabyBlue"))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
