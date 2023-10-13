//
//  Bioview.swift
//  Zuma
//
//  Created by Adrian Martushev on 5/28/23.
//

import SwiftUI


struct BioView: View {
    
    @State var usersBio = ""
    
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    var placeholderString = "150 characters max"

    
    var body: some View {
        VStack {
            VStack() {
                
                HStack(spacing: 0) {
                    Rectangle()
                        .frame(width: 320, height: 5)
                    Rectangle()
                        .fill(Color("LightGray"))
                        .frame( height: 5)
                        
                }
                .padding(.top, 70)
                .padding(.horizontal)
                .navigationTitle("")
                .navigationBarHidden(true)
                
                
                VStack(alignment : .leading, spacing : 20) {
                    Text("Add a few words about yourself")
                        .multilineTextAlignment(.leading)
                        .font(.custom("LexendMega-Bold", size : 25))
                        .tracking(-3.0)
                        .padding(.top, 40)
                    
                    Text("All members have a short bio on their profiles.")
                        .font(.custom("LexendMega-Regular", size : 12))
                        .tracking(-2.0)
                        .padding(.top, 15)
                        .padding(.bottom, 30)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.black)
                            .frame(height : 171)
                            .offset(x : 6, y : 6)

                        TextEditor(text : $usersBio)
                            .onAppear {
                                if usersBio.isEmpty {
                                    usersBio = placeholderString
                                }
                            }
                            .onTapGesture {
                                if usersBio == placeholderString {
                                    usersBio = ""
                                }
                            }
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color(.black))
                            .font(.custom("LexendMega-Medium", size : 14))
                            .tracking(-2.0)
                            .padding(15)
                            .frame( height : 171)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 4)
                            )
                    }

                }
                .padding(.horizontal)
                
                
                Spacer()
                
                HStack {

                    Spacer()
                    
                    NavigationLink {
                        ChooseInterestsView()
                            .onAppear {
                                currentUser.bio = self.usersBio
                            }
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.black)
                                .frame(width : 68, height : 68)
                                .offset(x : 3, y : 3)
                            
                            RoundedRectangle(cornerRadius: 100)
                                .fill(self.usersBio == "" || self.usersBio == "150 characters max" ? Color("LightGray") : Color("Yellow"))
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

struct BioView_Previews: PreviewProvider {
    static var previews: some View {
        BioView()
    }
}
