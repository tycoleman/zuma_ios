//
//  MatchExpirationView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/1/23.
//

import SwiftUI

struct MatchExpirationView: View {
    var body: some View {
        VStack {
            VStack {
                Spacer().frame(height: 100)
                    .navigationTitle("")
                    .navigationBarHidden(true)
                
                HStack {

                    VStack(alignment: .leading) {
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
                            
                            Image("moon")
                                .resizable()
                                .scaledToFit()
                                .frame(width : 35, height : 35)
                        }
                        .padding(.bottom)
                        
                        Text("Your daily match expires at midnight")
                            .font(.custom("LexendMega-SemiBold", size : 25))
                            .tracking(-2.0)
                            .foregroundColor(.black)
  
                        Text("Chat all you want on the app until then.")
                            .font(.custom("LexendMega-Regular", size : 11))
                            .tracking(-2.0)
                            .foregroundColor(.black)
                            .padding(.top, 10)
                    }
                    .padding(.leading)
                    
                    Spacer()
                }


                
                Spacer()

                NavigationLink {
                    SayGoodbyeView()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(.black)
                            .frame(width : 300, height : 70)
                            .offset(x : 7, y : 7)

                        Text("Got it")
                            .font(.custom("LexendMega-Bold", size : 15))
                            .tracking(-2.0)
                            .frame(width : 300, height : 70)
                            .foregroundColor(.black)
                            .background(Color("Yellow"))
                            .cornerRadius(100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(.black, lineWidth: 4)
                            )
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

struct MatchExpirationView_Previews: PreviewProvider {
    static var previews: some View {
        MatchExpirationView()
    }
}
