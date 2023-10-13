//
//  HomeView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/2/23.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var currentUser : CurrentUserViewModel
    @EnvironmentObject var match : MatchViewModel

    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HomeHeader()

                    if(match.hasMatchForToday) {
                        ConnectionProfileView(showChatButton: true)

                    } else {
                        NoMatchView()
                    }
                
                    Spacer()

                }
                .padding()
                
            }
            .background(Color("BabyBlue"))
            .edgesIgnoringSafeArea(.bottom)
            
        }
    }
}

struct HomeHeader : View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var currentUser : CurrentUserViewModel
    @EnvironmentObject var match : MatchViewModel
    
    
    var body : some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hi, \(currentUser.firstName)")
                    .font(.custom("LexendMega-SemiBold", size : 30))
                    .tracking(-5.0)
                    .foregroundColor(.black)
                    .padding(.bottom, 2)
                
                if(match.hasMatchForToday) {
                    Text("You matched with \(match.otherUser.firstName)!")
                        .font(.custom("LexendMega-Medium", size : 12))
                        .tracking(-2.0)
                        .foregroundColor(.black)
                } else {
                    Text("We're searching for your next match")
                        .font(.custom("LexendMega-Medium", size : 12))
                        .tracking(-2.0)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            NavigationLink {
                ProfileView()
            } label: {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.black)
                        .frame(width: 58, height: 58)
                        .offset(x : 3, y : 3)
                    
                    AsyncImage(url: URL(string: currentUser.photo1)) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 55, height: 55)
                            .clipShape(
                                Circle()
                                
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(.black, lineWidth : 2)
                            )
                    } placeholder: {
                        ProgressView()
                            .frame(width: 55, height: 55)
                            .clipShape(
                                Circle()

                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(.black, lineWidth : 2)
                            )
                    }
                }
            }
        }
        .padding(.vertical)
        .navigationTitle("")
        .navigationBarHidden(true)
        
    }
}




struct NoMatchView: View {
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black)
                    .frame(width : 320, height : 171)
                    .offset(x : 6, y : 6)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width : 320, height : 171)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 4)
                            )
                
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

                    Image("heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width : 35, height : 35)
                }
                .offset(x: -100, y: -80)
                
                VStack {
                    Text("Check back soon!")
                        .font(.custom("LexendMega-Bold", size : 24))
                        .tracking(-3.0)
                        .foregroundColor(.black)
                        .padding(.bottom, 5)
                    
                    Text("We'll notify you when we've found a match.")
                        .font(.custom("LexendMega-SemiBold", size : 14))
                        .tracking(-3.0)
                        .foregroundColor(.black)
                }
            }
            Spacer().frame(height: 100)
            
            Spacer()

        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
