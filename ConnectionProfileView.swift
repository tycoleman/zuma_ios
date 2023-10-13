//
//  ConnectionProfileView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/2/23.
//

import SwiftUI

struct ConnectionProfileView: View {
    
    var showChatButton : Bool
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var match : MatchViewModel
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                //ScrollView
                ScrollView {
                    VStack {
                        VStack {
                            if(!showChatButton) {
                                HStack {
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
                                        .padding(.leading, 15)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.top, 70)
                                .padding(.bottom, 20)
                                .navigationTitle("")
                                .navigationBarHidden(true)
                            } else {
                                HomeHeader()
                                    .frame(width : geometry.size.width * 0.95)
                                    .frame(height: 100)
                            }
                            
                            
                            MainPhotoView(height : geometry.size.height * 0.7, width : geometry.size.width * 0.95)
                                .padding(.bottom, 20)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.black)
                                    .frame( height : 150)
                                    .frame(width : geometry.size.width * 0.95)
                                    .offset(x : 6, y : 6)
    
                                HStack {
                                    VStack {
                                        
                                        Text(match.otherUser.bio)
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(Color(.black))
                                            .font(.custom("LexendMega-Medium", size : 18))
                                            .tracking(-2.0)
                                            .padding(30)
                                            .padding(.top, 15)
                                        
                                        Spacer()
                                    }
                                    
                                    Spacer()

                                }
                                .frame(height : 150)
                                .frame(width : geometry.size.width * 0.95)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                                
                                VStack {
                                    
                                    HStack {
                                        
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 100)
                                                .fill(.black)
                                                .frame(width : 60, height : 60)
                                                .offset(x : 3, y : 3)
                                            
                                            RoundedRectangle(cornerRadius: 100)
                                                .fill(Color("Pink"))
                                                .frame(width : 60, height : 60)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 100)
                                                        .stroke(.black, lineWidth: 4)
                                                )
                                            
                                            Image("heart")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width : 30, height : 30)
                                        }
                                        .offset(x : 30, y : -30)
                                        
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                }
                                
                                
                            }
                            .padding(.vertical, 20)
    
                            Group {
                                UserPhotoView(image : match.otherUser.photo2, height : geometry.size.height * 0.8, width : geometry.size.width * 0.95)
                                UserPhotoView(image : match.otherUser.photo3, height : geometry.size.height * 0.8, width : geometry.size.width * 0.95)
    
                                ConnectionInterests(interests: match.otherUser.interests)
                                    .padding(.bottom, 20)
                                
                                UserPhotoView(image : match.otherUser.photo4, height : geometry.size.height * 0.8, width : geometry.size.width * 0.95)
                                UserPhotoView(image : match.otherUser.photo5, height : geometry.size.height * 0.8, width : geometry.size.width * 0.95)
                                UserPhotoView(image : match.otherUser.photo6, height : geometry.size.height * 0.8, width : geometry.size.width * 0.95)
                            }
    
                            Spacer().frame(height: 200)
                        }
                    }
                }
                .background(Color("BabyBlue"))
                .edgesIgnoringSafeArea(.all)
                
                //Chat Button
                VStack {
                    Spacer()
                    
                    if showChatButton {
                        
                        VStack {
                            NavigationLink {
                                ChatView()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 100)
                                        .fill(.black)
                                        .frame( height : 60)
                                        .offset(x : 7, y : 7)

                                    Text("Chat")
                                        .font(.custom("LexendMega-Bold", size : 15))
                                        .tracking(-2.0)
                                        .foregroundColor(.black)
                                        .frame(height : 60)
                                        .frame(maxWidth : .infinity)
                                        .background(Color("Yellow"))
                                        .cornerRadius(100)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 100)
                                                .stroke(.black, lineWidth: 4)
                                        )
                                }
                                .padding(.bottom, 20)
                                .padding(.top, 20)
                            }
                            .frame(width : geometry.size.width * 0.95)

                        }
                        .frame(width : geometry.size.width)
                        .background(Color("BabyBlue"))
                    }
                }
            }
        }
    }
}

struct MainPhotoView : View {
    @EnvironmentObject var match : MatchViewModel

    var height : CGFloat
    var width : CGFloat

    
    var body: some View {

        
        
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black)
                    .frame(height : height)
                    .frame(width : width)
                    .offset(x : 7, y : 7)
                
                AsyncImage(url: URL(string : match.otherUser.photo1)) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width : width, height : height)
                } placeholder: {
                    ProgressView()
                }
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .frame(height : height)
                .frame(width : width)


                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 4)
                    .frame(height : height)
                    .frame(width : width)

                VStack {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading, spacing : 0) {
                            HStack(alignment: .bottom) {
                                Text(match.otherUser.firstName)
                                    .font(.custom("LexendMega-SemiBold", size : 28))
                                    .tracking(-4.0)
                                    .foregroundColor(.white)
                                
                                Text("\(match.otherUser.age)")
                                    .font(.custom("LexendMega-Regular", size : 15))
                                    .tracking(-2.0)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 5)
                            }
                            .padding(.bottom, 5)

                            Text(match.otherUser.city)
                                .font(.custom("LexendMega-Regular", size : 10))
                                .tracking(-2.0)
                                .foregroundColor(.white)
                                .padding(.bottom, 5)

                            
                            if(match.otherUser.isOnline) {
                                
                                HStack(spacing : 0) {
                                    Circle()
                                        .foregroundColor(Color("Green"))
                                        .frame(width: 6, height: 6)
                                        .padding(.trailing, 5)
                                    
                                    Text("Active Now  ")
                                        .font(.custom("LexendMega-Regular", size : 10))
                                        .tracking(-2.0)
                                        .foregroundColor(.green)
                                        .padding(.top, 2)
                                    
                                    Spacer()
                                }

                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 40)
                    .padding(.leading, 25)

                }
                .frame(height : height)
                .frame(width : width)
                
            }
    }
}

struct UserPhotoView : View {
    
    var image : String
    var height : CGFloat
    var width : CGFloat
    
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .frame(width : width, height : height)
                .offset(x : 7, y : 7)
            
            AsyncImage(url: URL(string: image)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width : width, height : height)

            } placeholder: {
                ProgressView()

            }
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .frame(width : width, height : height)

            
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 4)
                .frame(width : width, height : height)
        }
        .padding(.bottom, 20)
    }
}



struct ConnectionInterests : View {
    
    let interests : [String]
    
    
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .frame( height : 171)
                .offset(x : 6, y : 6)

            HStack {
                Spacer()
                
                ForEach(interests, id : \.self) { interest in
                    VStack(spacing : 0) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.black)
                                .frame(width : 75, height : 75)
                                .offset(x : 3, y : 3)
                            
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.white)
                                .frame(width : 75, height : 75)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                        .stroke(.black, lineWidth: 4)
                                )
                            
                            Image(interest)
                                .resizable()
                                .scaledToFit()
                                .frame(width : 36, height : 36)
                        }
                        .padding(.bottom)
                        
                        Text(interest)
                            .font(.custom("LexendMega-SemiBold", size : 12))
                            .tracking(-2.0)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()

                }
            }
            .frame( height : 171)
            .background(Color("Pink"))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 4)
            )
        }
        .padding(.horizontal, 5)
        
    }
}

struct ConnectionProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionProfileView(showChatButton: true)
    }
}
