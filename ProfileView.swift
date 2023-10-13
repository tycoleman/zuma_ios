//
//  HomeView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/1/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
                //Body
                ZStack {
                    //ScrollView
                    ScrollView {
                        VStack {
                            
                            //Header
                            HStack {
                                Button {
                                    self.presentationMode.wrappedValue.dismiss()
                                } label: {
                                    HStack {
                                        Image("backArrow")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30)
                                        Spacer()
                                    }
                                    .padding(.leading, 15)
                                }
                                
                                Spacer()
                                
                                NavigationLink {
                                    SettingsView()
                                } label: {
                                    Image("gear")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                        .padding(.trailing, 15)
                                }
                            }
                            .frame(height: 100)
                            .navigationTitle("")
                            .navigationBarHidden(true)
                            
                            
                            VStack {
                                CurrentUserMainPhotoView(height : geometry.size.height * 0.7, width : geometry.size.width * 0.9)
                                    .padding(.bottom, 30)
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.black)
                                        .frame( height : 150)
                                        .frame(width : geometry.size.width * 0.9)
                                        .offset(x : 6, y : 6)
        
                                    HStack {
                                        VStack {
                                            
                                            Text(currentUser.bio)
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
                                    .frame(width : geometry.size.width * 0.9)
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
                                    CurrentUserPhotoView(image : currentUser.photo2, height : geometry.size.height * 0.8, width : geometry.size.width * 0.9)
                                    UserPhotoView(image : currentUser.photo3, height : geometry.size.height * 0.8, width : geometry.size.width * 0.9)
        
                                    CurrentUserInterests(interests: currentUser.interests)
                                        .padding(.bottom, 20)
                                        .frame(width: geometry.size.width * 0.9)
        
                                    CurrentUserPhotoView(image : currentUser.photo4, height : geometry.size.height * 0.8, width : geometry.size.width * 0.9)
                                    CurrentUserPhotoView(image : currentUser.photo5, height : geometry.size.height * 0.8, width : geometry.size.width * 0.9)
                                    CurrentUserPhotoView(image : currentUser.photo6, height : geometry.size.height * 0.8, width : geometry.size.width * 0.9)
                                }
                            }
                        }
                    }
                    
                    //Chat Button
                    VStack {
                        Spacer()
                        
                        VStack {
                            NavigationLink {
                                EditProfileView()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 100)
                                        .fill(.black)
                                        .frame( height : 60)
                                        .offset(x : 7, y : 7)

                                    Text("Edit Profile")
                                        .font(.custom("LexendMega-Bold", size : 15))
                                        .tracking(-2.0)
                                        .foregroundColor(.black)
                                        .frame(height : 60)
                                        .frame(maxWidth : .infinity)
                                        .background(Color("Pink"))
                                        .cornerRadius(100)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 100)
                                                .stroke(.black, lineWidth: 4)
                                        )
                                }
                                .padding(.bottom, 40)
                                .padding(.top, 20)
                            }
                            .frame(width : geometry.size.width * 0.9)

                        }
                        .frame(width : geometry.size.width)
                        .background(Color("BabyBlue"))
                    }
                }
                .background(Color("BabyBlue"))
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}




struct CurrentUserMainPhotoView : View {
    @EnvironmentObject var currentUser : CurrentUserViewModel

    var height : CGFloat
    var width : CGFloat

    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black)
                    .frame(height : height)
                    .frame(width : width)
                    .offset(x : 7, y : 7)
                
                AsyncImage(url: URL(string : currentUser.photo1)) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width : width)
                        .frame(height : height)
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
                                Text(currentUser.firstName)
                                    .font(.custom("LexendMega-SemiBold", size : 28))
                                    .tracking(-4.0)
                                    .foregroundColor(.white)
                                
                                Text("\(currentUser.age)")
                                    .font(.custom("LexendMega-Regular", size : 15))
                                    .tracking(-2.0)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 5)
                            }
                            .padding(.bottom, 5)

                            Text(currentUser.currentCity)
                                .font(.custom("LexendMega-Regular", size : 10))
                                .tracking(-2.0)
                                .foregroundColor(.white)
                                .padding(.bottom, 5)

                            
                            if (currentUser.isOnline) {

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


struct CurrentUserPhotoView : View {
    
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




struct CurrentUserInterests : View {
    
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
                                .frame(width : 85, height : 85)
                                .offset(x : 3, y : 3)
                            
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.white)
                                .frame(width : 85, height : 85)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                        .stroke(.black, lineWidth: 4)
                                )
                            
                            Image(interest)
                                .resizable()
                                .scaledToFit()
                                .frame(width : 40, height : 55)
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
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
