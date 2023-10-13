//
//  AllowNotificationsView.swift
//  Zuma
//
//  Created by Adrian Martushev on 5/28/23.
//

import SwiftUI
import UserNotifications

struct AllowNotificationsView: View {
    
    @EnvironmentObject var currentUser : CurrentUserViewModel
    @State private var navigate = false

    func askForNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
           
           if granted {
               print("Permission granted")
               currentUser.isPushOn = true
               
               DispatchQueue.main.async {
                   UIApplication.shared.registerForRemoteNotifications()
               }
               
           } else if let error = error {
               print("Error occurred: \(error)")
           }
            
            self.navigate = true

        }
    }
    
    var body: some View {
        VStack {
            VStack {
                Spacer().frame(height: 100)
                    .navigationTitle("")
                    .navigationBarHidden(true)
                
                HStack {

                    VStack(alignment: .leading) {
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
                            
                            Image("bell")
                                .resizable()
                                .scaledToFit()
                                .frame(width : 35, height : 35)
                        }
                        .padding(.bottom)
                        
                        Text("Allow Notifications")
                            .font(.custom("LexendMega-SemiBold", size : 25))
                            .tracking(-2.0)
                            .foregroundColor(.black)
  
                        Text("Never miss a new match or message")
                            .font(.custom("LexendMega-Regular", size : 11))
                            .tracking(-2.0)
                            .foregroundColor(.black)
                            .padding(.top, 10)
                    }
                    .padding(.leading)
                    
                    Spacer()
                }


                
                Spacer()

                Button {
                    self.askForNotificationPermission()

                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(.black)
                            .frame(width : 300, height : 70)
                            .offset(x : 7, y : 7)

                        Text("Allow Notifications")
                            .font(.custom("LexendMega-Bold", size : 15))
                            .tracking(-2.0)
                            .frame(width : 300, height : 70)
                            .foregroundColor(.black)
                            .background(Color("Yellow"))
                            .cornerRadius(100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(.black, lineWidth: 4)
                            )
                    }
                }
                NavigationLink(destination: NameView(), isActive: $navigate) {
                    EmptyView()
                }
                
                NavigationLink {
                    NameView()
                } label: {
                    Text("Not now")
                        .font(.custom("LexendMega-Regular", size : 15))
                        .tracking(-2.0)
                        .foregroundColor(.black)
                        .padding(.top, 30)
                }

                
                Spacer().frame(height: 50)

            }
            .padding()
        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct AllowNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        AllowNotificationsView()
    }
}
