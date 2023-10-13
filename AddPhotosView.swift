//
//  AddPhotosView.swift
//  Zuma
//
//  Created by Adrian Martushev on 5/28/23.
//

import SwiftUI
import FirebaseStorage


struct AddPhotosView: View {
    @EnvironmentObject var currentUser : CurrentUserViewModel

    var body: some View {
        VStack {
            
            GeometryReader { geometry in
                VStack {
                    HStack(spacing: 0) {
                        Rectangle()
                            .frame(width: 200, height: 5)
                        Rectangle()
                            .fill(Color("LightGray"))
                            .frame(width: 120, height: 5)
                            
                    }
                    .padding(.top, 70)
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    
                    VStack(alignment : .leading) {
                        Text("Add your photos")
                            .font(.custom("LexendMega-Bold", size : 25))
                            .tracking(-3.0)
                            .padding(.top, 40)
                        
                        Text("Choose six photos for your profile. You can change these later")
                            .font(.custom("LexendMega-Regular", size : 12))
                            .tracking(-2.0)
                            .padding(.top, 15)
                            .padding(.bottom, 30)
                        
                        HStack {
                            AddImageButton2(index : 1, image: currentUser.photo1, width : geometry.size.width * 0.28)
                            Spacer()
                            AddImageButton2(index : 2, image: currentUser.photo2, width : geometry.size.width * 0.28)
                            Spacer()
                            AddImageButton2(index : 3, image: currentUser.photo3, width : geometry.size.width * 0.28)
                        }
                        .padding(.bottom)
                        
                        HStack {
                            AddImageButton2(index : 4, image: currentUser.photo4, width : geometry.size.width * 0.28)
                            Spacer()
                            AddImageButton2(index : 5, image: currentUser.photo5, width : geometry.size.width * 0.28)
                            Spacer()
                            AddImageButton2(index : 6, image: currentUser.photo6, width : geometry.size.width * 0.28)
                        }
                    }
                    .padding(.horizontal)
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
                            BirthdayView()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(.black)
                                    .frame(width : 68, height : 68)
                                    .offset(x : 3, y : 3)
                                
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(currentUser.photo1 == "" ? Color("LightGray") : Color("Yellow"))
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
            
        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}


struct AddImageButton : View {
    var index : Int
    var image : String
    
    @State var showImagePicker: Bool = false
    private let storage = Storage.storage().reference()
    
    @EnvironmentObject var currentUser: CurrentUserViewModel
    

    var body: some View {
        Button {
            self.showImagePicker.toggle()

        } label: {
            
            if image == "" {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black)
                        .frame(width : 100, height : 155)
                        .offset(x : 4, y : 3)
                    
                    Image(systemName: "plus")
                        .foregroundColor(Color("Gray"))
                        .frame( height : 155)
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 4)
                        )
                }
                
            } else {
                AsyncImage(url: URL(string : image) ) { image in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.black)
                            .frame(width : 100, height : 155)
                            .offset(x : 4, y : 3)
                        
                        image.resizable()
                            .scaledToFill()
                            .frame(width : 100, height : 155)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 4)
                            )
                    }
                } placeholder: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.black)
                            .frame(width : 100, height : 155)
                            .offset(x : 4, y : 3)
                        
                        ProgressView()
                            .frame(width : 100, height : 155)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 4)
                            )
                    }
                }
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(sourceType: .photoLibrary) { image in
                
                guard let imageData = image.jpegData(compressionQuality: 0.60) else {return}
                
                var imageID = currentUser.getRandomID(length : 8)
                let ref = self.storage.child("profileImages/\(imageID).jpeg")
                
                ref.putData(imageData, metadata: nil) { (_, error) in
                    if error != nil {
                        print("failed to upload image")
                        return
                    }
                    ref.downloadURL { (url, error) in
                        if error != nil {
                            print("failed to get image url")
                            return
                        }
                        
                        let urlString = (url?.absoluteString ?? "https://firebasestorage.googleapis.com/v0/b/irisapp-7d38d.appspot.com/o/defaultProfile.png?alt=media&token=5fc41cee-fbdd-430f-9659-7660baf194a3") as String
                        
                        switch index {
                            case 1 :
                                currentUser.photo1 = urlString
                            
                            case 2 :
                                currentUser.photo2 = urlString
                            
                            case 3 :
                                currentUser.photo3 = urlString
                            
                            case 4 :
                                currentUser.photo4 = urlString
                            
                            case 5 :
                                currentUser.photo5 = urlString
                            
                            case 6 :
                                currentUser.photo6 = urlString
                            
                            default :
                                currentUser.photo1 = urlString

                        }
                    }
                }
            } // end imagePickerView
        }
    }
}


struct AddImageButton2 : View {
    var index : Int
    var image : String
    var width : Double
    
    @State var showImagePicker: Bool = false
    private let storage = Storage.storage().reference()
    
    @EnvironmentObject var currentUser: CurrentUserViewModel
    

    var body: some View {
        Button {
            self.showImagePicker.toggle()

        } label: {
            
            if image == "" {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black)
                        .frame(width : width, height : 155)
                        .offset(x : 4, y : 3)
                    
                    Image(systemName: "plus")
                        .foregroundColor(Color("Gray"))
                        .frame( width : width, height : 155)
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 4)
                        )
                }
                
            } else {
                AsyncImage(url: URL(string : image) ) { image in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.black)
                            .frame(width : width, height : 155)
                            .offset(x : 4, y : 3)
                        
                        image.resizable()
                            .scaledToFill()
                            .frame(width : width, height : 155)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 4)
                            )
                    }
                } placeholder: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.black)
                            .frame(width : width, height : 155)
                            .offset(x : 4, y : 3)
                        
                        ProgressView()
                            .frame(width : width, height : 155)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 4)
                            )
                    }
                }
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(sourceType: .photoLibrary) { image in
                
                guard let imageData = image.jpegData(compressionQuality: 0.60) else {return}
                
                var imageID = currentUser.getRandomID(length : 8)
                let ref = self.storage.child("profileImages/\(imageID).jpeg")
                
                ref.putData(imageData, metadata: nil) { (_, error) in
                    if error != nil {
                        print("failed to upload image")
                        return
                    }
                    ref.downloadURL { (url, error) in
                        if error != nil {
                            print("failed to get image url")
                            return
                        }
                        
                        let urlString = (url?.absoluteString ?? "https://firebasestorage.googleapis.com/v0/b/irisapp-7d38d.appspot.com/o/defaultProfile.png?alt=media&token=5fc41cee-fbdd-430f-9659-7660baf194a3") as String
                        
                        switch index {
                            case 1 :
                                currentUser.photo1 = urlString
                            
                            case 2 :
                                currentUser.photo2 = urlString
                            
                            case 3 :
                                currentUser.photo3 = urlString
                            
                            case 4 :
                                currentUser.photo4 = urlString
                            
                            case 5 :
                                currentUser.photo5 = urlString
                            
                            case 6 :
                                currentUser.photo6 = urlString
                            
                            default :
                                currentUser.photo1 = urlString

                        }
                    }
                }
            } // end imagePickerView
        }
    }
}

struct AddPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotosView()
    }
}
