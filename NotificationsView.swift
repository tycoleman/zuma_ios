//
//  NotificationsView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/1/23.
//

import SwiftUI

struct NotificationsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    
    var body: some View {
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
                        .padding(.top, 70)
                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    
                    Spacer()
                    
                }
                
                HStack {
                    Text("Notifications")
                        .font(.custom("LexendMega-SemiBold", size : 15))
                        .tracking(-2.0)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.bottom, 20)
                
                
                Button {
                    //Only submit request if it's disabled
                    if(!currentUser.isPushOn) {
                        currentUser.isPushOn = true
                    }
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(.black)
                            .frame( height : 70)
                            .offset(x : 7, y : 7)
                        RoundedRectangle(cornerRadius: 100)
                            .fill(currentUser.isPushOn ? Color("Yellow") : Color("LightGray"))
                            .frame(height : 70)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(.black, lineWidth: 4)
                            )
                        
                        HStack {
                            Text("Enable all notifications")
                                .font(.custom("LexendMega-Bold", size : 15))
                                .tracking(-2.0)
                                .foregroundColor(.black)
                                .padding(.leading, 40)
                            Spacer()
                            if(currentUser.isPushOn) {
                                Image("checkmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width : 25)
                                    .padding(.trailing, 20)
                            }
                        }

                    }
                }
                .padding(.bottom, 15)
                
                Button {
                    currentUser.isPushOn = false
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(.black)
                            .frame(height : 70)
                            .offset(x : 7, y : 7)
                        RoundedRectangle(cornerRadius: 100)
                            .fill(currentUser.isPushOn ?  Color("LightGray") : Color("Yellow"))
                            .frame(height : 70)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(.black, lineWidth: 4)
                            )
                        
                        HStack {
                            Text("Disable all notifications")
                                .font(.custom("LexendMega-Bold", size : 15))
                                .tracking(-2.0)
                                .foregroundColor(.black)
                                .padding(.leading, 40)
                            Spacer()
                            
                            if(!currentUser.isPushOn) {
                                Image("checkmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width : 25)
                                    .padding(.trailing, 20)
                            }
                        }
                    }
                }
                .padding(.bottom, 15)

                Spacer()

            }
            .padding()
        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}


struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
