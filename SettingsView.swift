//
//  SettingsView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/1/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    @State var showLogoutAlert = false

    var body: some View {
        
        NavigationStack {
            VStack {
                VStack {
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
                            .padding(.top, 120)
                            .padding(.bottom, 30)
                        }
                        .navigationTitle("")
                        .navigationBarHidden(true)
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)

                    
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            HStack {
                                Text("Account")
                                    .font(.custom("LexendMega-SemiBold", size : 15))
                                    .tracking(-2.0)
                                    .foregroundColor(.black)
                                
                                Spacer()
                            }
                            .padding(.bottom, 20)
                            
                            SettingsButton(iconColor : "Red", image: "heart", text: "Dating Preferences", navView : DatingPreferencesView())
                            SettingsButton(iconColor : "Purple", image: "bell", text : "Notifications", navView : NotificationsView())
                        


                            HStack {
                                Text("Help")
                                    .font(.custom("LexendMega-SemiBold", size : 15))
                                    .tracking(-2.0)
                                    .foregroundColor(.black)
                                
                                Spacer()
                            }
                            .padding(.top, 40)
                            .padding(.bottom, 20)
                            
                            SettingsButton(iconColor : "Blue", image: "airplane", text: "Email Zuma", navView : EmailZumaView())
                            SettingsButton(iconColor : "DarkGray", image: "shield", text : "Terms of Service", navView : TOSView())
                            SettingsButton(iconColor : "Green", image: "eye", text : "Privacy Policy", navView : PrivacyPolicyView())

                            Spacer().frame(height: 60)
                            
                            VStack {
                                HStack {
                                    Text("Settings")
                                        .font(.custom("LexendMega-SemiBold", size : 15))
                                        .tracking(-2.0)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                                .padding(.top, 40)
                                .padding(.bottom, 20)
                                
                                
                                Button {
                                    showLogoutAlert = true

                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 100)
                                            .fill(.black)
                                            .frame( height : 60)
                                            .offset(x : 7, y : 7)

                                        HStack {
                                            Image("gear")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 27, height: 27)
                                                .padding(.leading, 30)
                                            
                                            Text("Log Out")
                                                .font(.custom("LexendMega-Bold", size : 15))
                                                .tracking(-2.0)
                                                .foregroundColor(.black)
                                                .padding(.leading, 10)
                                            
                                            Spacer()
                                        }
                                        .frame(height : 60)
                                        .frame(maxWidth : .infinity)
                                        .background(Color(.white))
                                        .cornerRadius(100)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 100)
                                                .stroke(.black, lineWidth: 4)
                                        )
                                    }
                                }
                                .alert(isPresented: $showLogoutAlert) {
                                    Alert(title: Text("Logout"), message: Text("Are you sure you'd like to logout?"), primaryButton: .default(Text("Yes")) {
                                            currentUser.signOut()
                                    }, secondaryButton: .cancel())
                                }
                                .padding(.bottom, 20)

                                
                                DeleteAccountButton()
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)

                    }
                }
            }
            .background(Color("BabyBlue"))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct SettingsButton : View {
    
    var iconColor : String
    var image : String
    var text : String
    
    var navView : any View
    
    var body : some View {
        
        NavigationLink {
            AnyView(navView)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 100)
                    .fill(.black)
                    .frame( height : 60)
                    .offset(x : 7, y : 7)

                HStack {
                    Image(image)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 27, height: 27)
                        .padding(.leading, 30)
                        .foregroundColor(Color(iconColor))
                    
                    Text(text)
                        .font(.custom("LexendMega-Bold", size : 15))
                        .tracking(-2.0)
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                    
                    Spacer()
                }
                .frame(height : 60)
                .frame(maxWidth : .infinity)
                .background(Color(.white))
                .cornerRadius(100)
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.black, lineWidth: 4)
                )
            }
        }
        .padding(.bottom, 20)
    }
}






struct DeleteAccountButton : View {
    @State private var passwordReauth = ""
    @State var showDeleteAccountAlert = false
    @State var showUserReauthentication = false
    
    @State var userID = ""
    
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    var body: some View {
        
        
        HStack {
            Button {
                showDeleteAccountAlert = true
            } label: {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.black)
                        .frame( height : 60)
                        .offset(x : 7, y : 7)
                    

                    HStack {
                        Image(systemName: "trash.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 27, height: 27)
                            .padding(.leading, 30)
                            .foregroundColor(.black)

                        
                        Text("Delete Account")
                            .font(.custom("LexendMega-Bold", size : 15))
                            .tracking(-2.0)
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        
                        Spacer()
                    }
                    .frame(height : 60)
                    .frame(maxWidth : .infinity)
                    .background(Color(.white))
                    .cornerRadius(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(.black, lineWidth: 4)
                    )
                }
            }
            .alert(isPresented: $showDeleteAccountAlert) {
                Alert(title: Text("Delete Account"), message: Text("Are you sure you want to delete your account? This cannot be undone."), primaryButton: .default(Text("Yes")) {
                    let user = Auth.auth().currentUser
                    self.userID = user!.uid
                    let userRef = database.collection("users").document(userID)
                    
                    userRef.updateData([
                        "accountStatus": "deleted"
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Application Status : Deleted" )
                          
                            user?.delete { error in
                              if let error = error {
                                // An error happened.
                                  print(error.localizedDescription)
                                  
                                  if error.localizedDescription == "This operation is sensitive and requires recent authentication. Log in again before retrying this request." {
                                      showUserReauthentication = true
                                  }
                              } else {
                                // Account deleted.
                                  print("Account Deleted")
                              }
                            
                            }
                        }
                    }
                    
                }, secondaryButton: .cancel())
            }
            .sheet(isPresented: $showUserReauthentication) {
                

                AccountDeletionView()
                    .presentationDetents([.height(400)])
            }
            
            Spacer()
        }
    }
}




struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

