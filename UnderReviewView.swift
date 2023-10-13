//
//  UderReviewView.swift
//  Zuma
//
//  Created by Adrian Martushev on 5/28/23.
//

import SwiftUI


struct UnderReviewView: View {
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    var body: some View {
        VStack {
            VStack {
                
                Spacer().frame(height: 170)
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
                                .fill(Color("BabyBlue"))
                                .frame(width : 65, height : 65)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                        .stroke(.black, lineWidth: 4)
                                )
                            
                            Image("person")
                                .resizable()
                                .scaledToFit()
                                .frame(width : 35, height : 35)
                        }
                        .padding(.bottom)
                        
                        Text("Your membership is under review.")
                            .font(.custom("LexendMega-SemiBold", size : 25))
                            .tracking(-3.0)
                            .foregroundColor(.black)
  
                        Text("We'll get back to you as soon as possible!")
                            .font(.custom("LexendMega-Regular", size : 11))
                            .tracking(-2.0)
                            .foregroundColor(.black)
                            .padding(.top, 10)
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
                
                Spacer()

            }
            .padding()

        }
        .background(Color("Yellow"))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            currentUser.listen()
        }
    }
}

struct UnderReviewView_Previews: PreviewProvider {
    static var previews: some View {
        UnderReviewView()
    }
}
