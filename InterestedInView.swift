//
//  InterestedInView.swift
//  Zuma
//
//  Created by Adrian Martushev on 5/28/23.
//

import SwiftUI


struct InterestedInView: View {
    @State var isSelected = ""
    @EnvironmentObject var currentUser : CurrentUserViewModel

    var body: some View {
        VStack {
            VStack {
                
                VStack {
                    HStack(spacing: 0) {
                        Rectangle()
                            .frame(width: 300, height: 5)
                        Rectangle()
                            .fill(Color("LightGray"))
                            .frame( height: 5)
                            
                    }
                    .padding(.top, 70)
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    
                    HStack {
                        Text("Who are you interested in?")
                            .font(.custom("LexendMega-Bold", size : 25))
                            .tracking(-3.0)
                            .padding(.top, 40)
                        
                        Spacer()
                    }

                    
                    HStack {
                        Text("You can change this later.")
                            .font(.custom("LexendMega-Regular", size : 12))
                            .tracking(-2.0)
                            .padding(.top, 15)
                            .padding(.bottom, 30)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)

                
                VStack(alignment : .leading, spacing : 20) {
                    
                    
                    Button {
                        isSelected = "Men"
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame( height : 70)
                                .offset(x : 7, y : 7)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(isSelected == "Men" ? Color("Yellow") : Color("LightGray"))
                                .frame( height : 70)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                            
                            HStack {
                                Text("I'm interested in Men")
                                    .font(.custom("LexendMega-Bold", size : 15))
                                    .tracking(-2.0)
                                    .foregroundColor(.black)
                                    .padding(.leading, 20)
                                Spacer()
                                if(isSelected == "Men") {
                                    Image("checkmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width : 25)
                                        .padding(.trailing, 20)
                                }
                            }

                        }
                    }
                    
                    Button {
                        isSelected = "Women"
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame(height : 70)
                                .offset(x : 7, y : 7)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(isSelected == "Women" ? Color("Yellow") : Color("LightGray"))
                                .frame( height : 70)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                            
                            HStack {
                                Text("I'm interested in Women")
                                    .font(.custom("LexendMega-Bold", size : 15))
                                    .tracking(-2.0)
                                    .foregroundColor(.black)
                                    .padding(.leading, 20)
                                Spacer()
                                
                                if(isSelected == "Women") {
                                    Image("checkmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width : 25)
                                        .padding(.trailing, 20)
                                }
                            }
                        }
                    }
                    
                    Button {
                        isSelected = "Everyone"
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame(height : 70)
                                .offset(x : 7, y : 7)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(isSelected == "Everyone" ? Color("Yellow") : Color("LightGray"))
                                .frame( height : 70)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                            
                            HStack {
                                Text("I'm interested in Everyone")
                                    .font(.custom("LexendMega-Bold", size : 15))
                                    .tracking(-2.0)
                                    .foregroundColor(.black)
                                    .padding(.leading, 20)
                                Spacer()
                                
                                if(isSelected == "Everyone") {
                                    Image("checkmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width : 25)
                                        .padding(.trailing, 20)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        BioView()
                            .onAppear {
                                currentUser.interestedIn = self.isSelected
                            }
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.black)
                                .frame(width : 68, height : 68)
                                .offset(x : 3, y : 3)
                            
                            RoundedRectangle(cornerRadius: 100)
                                .fill(self.isSelected == "" ? Color("LightGray") : Color("Yellow"))
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
            .padding(.horizontal)
        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct InterestedInView_Previews: PreviewProvider {
    static var previews: some View {
        InterestedInView()
    }
}
