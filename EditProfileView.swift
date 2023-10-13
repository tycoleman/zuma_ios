//
//  EditProfileView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/2/23.
//

import SwiftUI

struct EditProfileView: View {
    
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {

        
        
        NavigationStack {
            GeometryReader { geometry in
                
                ZStack {
                    VStack {
                        ScrollView(showsIndicators: false) {
                            VStack {
                                Button {
                                    currentUser.updateBio()
                                    
                                    self.presentationMode.wrappedValue.dismiss()
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 100)
                                            .fill(.black)
                                            .frame( height : 60)
                                            .offset(x : 7, y : 7)

                                        Text("Done")
                                            .font(.custom("LexendMega-Bold", size : 15))
                                            .tracking(-2.0)
                                            .foregroundColor(.black)
                                            .frame(height : 60)
                                            .frame(maxWidth : .infinity)
                                            .background(Color("Green"))
                                            .cornerRadius(100)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 100)
                                                    .stroke(.black, lineWidth: 4)
                                            )
                                    }
                                }
                                .navigationTitle("")
                                .navigationBarHidden(true)
                                
                                
                                PhotosSection(photoWidth : geometry.size.width * 0.28)
                                AboutMeSection()
                                InterestsSection()

            


                                Spacer()
                            }
                            .padding()
                        }

                    }
                    
                    VStack {
                        Spacer().frame(width : geometry.size.width,height: 10).background(Color("BabyBlue"))
                        Spacer()
                        Spacer().frame(width : geometry.size.width,height: 10).background(Color("BabyBlue"))
                    }

                }


            }
        }
        .background(Color("BabyBlue"))

    }
}


struct PhotosSection : View {
    
    @EnvironmentObject var currentUser : CurrentUserViewModel

    var photoWidth : Double
    
    var body: some View {
        HStack(spacing : 0) {
            Image("grid")
                .resizable()
                .scaledToFit()
                .frame(height: 15)
                .padding(.trailing, 5)
            
            Text("My Photos")
                .font(.custom("LexendMega-SemiBold", size : 15))
                .tracking(-2.0)
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding(.top, 30)
        .padding(.bottom, 5)

        HStack {
            AddImageButton2(index : 1, image: currentUser.photo1, width : photoWidth)
            Spacer()
            AddImageButton2(index : 2, image: currentUser.photo2, width : photoWidth)
            Spacer()
            AddImageButton2(index : 3, image: currentUser.photo3, width : photoWidth)
        }
        .padding(.bottom, 5)
        
        HStack {
            AddImageButton2(index : 4, image: currentUser.photo4, width : photoWidth)
            Spacer()
            AddImageButton2(index : 5, image: currentUser.photo5, width : photoWidth)
            Spacer()
            AddImageButton2(index : 6, image: currentUser.photo6, width : photoWidth)
        }
        
        HStack {
            Spacer()
            Text("Tap to edit")
                .font(.custom("LexendMega-Medium", size : 10))
                .tracking(-2.0)
                .foregroundColor(.black)
        }
        .padding(.top, 10)
    }
}



struct AboutMeSection : View {
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    var placeholderString = "Write a little bit about yourself"

    var body : some View {
        
        HStack(spacing : 0) {
            Image("person")
                .resizable()
                .scaledToFit()
                .frame(height: 15)
                .padding(.trailing, 5)
            
            Text("About Me")
                .font(.custom("LexendMega-SemiBold", size : 15))
                .tracking(-2.0)
                .foregroundColor(.black)
            
            Spacer()
            
        }
        .padding(.top, 40)
        .padding(.bottom, 5)
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .frame( height : 171)
                .offset(x : 6, y : 6)
            
            RoundedRectangle(cornerRadius: 10)  // This will act as the background
                .fill(Color("LightGray"))
                .frame(height: 171)
            
            TextEditor(text : $currentUser.bio)
            
                .onAppear {
                    if currentUser.bio.isEmpty {
                        currentUser.bio = placeholderString
                    }
                }
                .onTapGesture {
                    if currentUser.bio == placeholderString {
                      currentUser.bio = ""
                    }
                }
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(.black))
                .font(.custom("LexendMega-Medium", size : 14))
                .tracking(-2.0)
                .padding(15)
                .frame( height : 171)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 4)
                )
                .scrollContentBackground(.hidden) // <- Hide it

                .background(Color.clear)  // Make sure the TextEditor itself is transparent

        }
        
        HStack {
            Spacer()
            Text("Tap to edit")
                .font(.custom("LexendMega-Medium", size : 10))
                .tracking(-2.0)
                .foregroundColor(.black)
        }
        .padding(.top, 10)
        
        HStack {
            Spacer()
            Text("\(currentUser.maxLength - currentUser.bio.count) characters remaining")
                .font(.custom("LexendMega-SemiBold", size : 12))
                .tracking(-2.0)
                .foregroundColor(.black)
        }
        .padding(.top, 5)
    }
}


struct InterestsSection : View {
    @EnvironmentObject var currentUser : CurrentUserViewModel

    var body: some View {
        
        
        HStack(spacing : 0) {
            Image("star")
                .resizable()
                .scaledToFit()
                .frame(height: 15)
                .padding(.trailing, 5)
            
            Text("Interests")
                .font(.custom("LexendMega-SemiBold", size : 15))
                .tracking(-2.0)
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding(.top, 40)
        .padding(.bottom, 5)

        
        NavigationLink {
            InterestsView()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black)
                    .frame( height : 171)
                    .offset(x : 6, y : 6)

                HStack {
                    
                    Spacer()
                    
                    ForEach(currentUser.interests, id :\.self) { interest in
                        InterestLabel(label : interest)
                        Spacer()
                    }

                }
                .frame( height : 171)
                .background(Color("Yellow"))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 4)
                )
            }
        }
    
        HStack {
            Spacer()
            Text("Tap to edit")
                .font(.custom("LexendMega-Medium", size : 10))
                .tracking(-2.0)
                .foregroundColor(.black)
        }
        .padding(.top, 10)
    }
}



struct InterestLabel : View {
    var label : String
    
    var body: some View {
        VStack(spacing : 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 100)
                    .fill(.black)
                    .frame(width : 68, height : 68)
                    .offset(x : 3, y : 3)
                
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color("LightGray"))
                    .frame(width : 65, height : 65)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(.black, lineWidth: 4)
                    )
                
                Image(label)
                    .resizable()
                    .scaledToFit()
                    .frame(width : 35, height : 35)
            }
            .padding(.bottom)
            
            Text(label)
                .font(.custom("LexendMega-SemiBold", size : 12))
                .tracking(-2.0)
                .foregroundColor(.black)
        }
    }
}


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
