//
//  EmailView.swift
//  Zuma
//
//  Created by Adrian Martushev on 5/28/23.
//

import SwiftUI


struct EmailView: View {
    @State var email = ""
    @EnvironmentObject var currentUser : CurrentUserViewModel

    var body: some View {
        VStack {
            VStack {
                
                HStack(spacing: 0) {
                    Rectangle()
                        .frame( height: 5)
                }
                .padding(.top, 70)
                .navigationTitle("")
                .navigationBarHidden(true)
                
                
                VStack(alignment : .leading) {
                    Text("What's your email?")
                        .font(.custom("LexendMega-Bold", size : 25))
                        .tracking(-3.0)
                        .padding(.top, 40)
                    
                    Text("We use this to recover your account if you can't login.")
                        .font(.custom("LexendMega-Regular", size : 12))
                        .tracking(-2.0)
                        .padding(.vertical, 15)
                        .padding(.bottom, 30)
                    
                    HStack {

                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame(height : 55)
                                .offset(x : 4, y : 3)
                            
                            TextField("", text : $email)
                                .placeholder(when: email.isEmpty) {
                                    Text("Add your email").foregroundColor(Color("Gray"))
                                }
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                                .font(.custom("LexendMega-Medium", size : 14))
                                .tracking(-2.0)
                                .padding(.leading, 15)
                                .frame( height : 55)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                        }
                    }
                }
                
                
                Spacer()
                
                HStack {
                    
                    NavigationLink {
                        ThanksView()
                        
                    } label : {
                        Text("Skip")
                            .font(.custom("LexendMega-SemiBold", size : 14))
                            .tracking(-2.0)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                            .padding(.leading)
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        ThanksView()
                            .onAppear {
                                currentUser.email = email
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


struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        EmailView()
    }
}
