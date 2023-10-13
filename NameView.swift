//
//  NameView.swift
//  Zuma
//
//  Created by Adrian Martushev on 5/28/23.
//

import SwiftUI

struct NameView: View {
    @State var firstName = ""
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    
    var body: some View {
        VStack {
            VStack {
                
                HStack(spacing: 0) {
                    Rectangle()
                        .frame(width: 60, height: 5)
                    Rectangle()
                        .fill(Color("LightGray"))
                        .frame(width: 260, height: 5)
                        
                }
                .padding(.top, 70)
                .navigationTitle("")
                .navigationBarHidden(true)
                
                VStack(alignment : .leading) {
                    Text("What's your first name?")
                        .font(.custom("LexendMega-Bold", size : 25))
                        .tracking(-3.0)
                        .padding(.top, 40)
                    
                    Text("You won't be able to change this later.")
                        .font(.custom("LexendMega-Regular", size : 12))
                        .tracking(-2.0)
                        .padding(.top, 15)
                        .padding(.bottom, 30)
                    
                    HStack {                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame(width : 320, height : 55)
                                .offset(x : 4, y : 3)
                            
                            TextField("Add your first name", text : $firstName)
                                .placeholder(when: firstName.isEmpty) {
                                    Text("Add your first name").foregroundColor(Color("Gray"))
                                }
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                                .font(.custom("LexendMega-Medium", size : 14))
                                .tracking(-2.0)
                                .padding(.leading, 15)
                                .frame(height : 55)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                        }
                    }
                }
                .frame(width : 320)
                
                Spacer()
                
                HStack {

                    
                    HStack(spacing : 0) {
                        Image("eye")
                            .resizable()
                            .scaledToFit()
                            .frame(width : 15)
                        
                        Text("This will be shown on your profile.")
                            .font(.custom("LexendMega-Regular", size : 10))
                            .tracking(-2.0)
                            .multilineTextAlignment(.leading)
                            .frame(width: 180)

                    }
                    .frame(width: 240)
                    
                    Spacer()
                    
                    NavigationLink {
                        InstagramView()
                            .onAppear {
                                currentUser.firstName = self.firstName
                            }
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.black)
                                .frame(width : 68, height : 68)
                                .offset(x : 3, y : 3)
                            
                            RoundedRectangle(cornerRadius: 100)
                                .fill(self.firstName == "" ? Color("LightGray") : Color("Yellow"))
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
            .padding()
        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
    }
}
