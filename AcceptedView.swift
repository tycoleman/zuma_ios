//
//  AcceptedView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/1/23.
//

import SwiftUI

struct AcceptedView: View {
    var body: some View {
        
        NavigationStack {
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
                                    .fill(Color("BabyBlue"))
                                    .frame(width : 65, height : 65)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 100)
                                            .stroke(.black, lineWidth: 4)
                                    )
                                
                                Image("star")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width : 35, height : 35)
                            }
                            .padding(.bottom)
                            
                            Text("Your application has been accepted")
                                .font(.custom("LexendMega-SemiBold", size : 25))
                                .tracking(-2.0)
                                .foregroundColor(.black)
      
                            Text("Welcome to the Zuma community. We’re excited to be part of your dating journey. \n\nWith love, the Zuma team")
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
                        NewMatchDailyView()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.black)
                                .frame(width : 300, height : 70)
                                .offset(x : 7, y : 7)

                            Text("Next")
                                .font(.custom("LexendMega-Bold", size : 15))
                                .tracking(-2.0)
                                .frame(width : 300, height : 70)
                                .foregroundColor(.black)
                                .background(Color("BabyBlue"))
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
            .background(Color("Yellow"))
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}

struct AcceptedView_Previews: PreviewProvider {
    static var previews: some View {
        AcceptedView()
    }
}
