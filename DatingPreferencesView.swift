//
//  DatingPreferencesView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/1/23.
//

import SwiftUI

struct DatingPreferencesView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    @State var isSelected = ""

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
                    Text("Dating Preferences")
                        .font(.custom("LexendMega-SemiBold", size : 15))
                        .tracking(-2.0)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.bottom, 20)
                
                
                InterestedInButton(selection : "Men")
                
                InterestedInButton(selection : "Women")
        
                InterestedInButton(selection: "Everyone")
                


                Spacer()
                


            }
            .padding()
        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}


struct InterestedInButton : View {
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    var selection : String
    
    var body: some View {
        Button {
            currentUser.updateInterestedIn(selection : selection)
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 100)
                    .fill(.black)
                    .frame(height : 70)
                    .offset(x : 7, y : 7)
                RoundedRectangle(cornerRadius: 100)
                    .fill(currentUser.interestedIn == selection ? Color("Yellow") : Color("LightGray"))
                    .frame(height : 70)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(.black, lineWidth: 4)
                    )
                
                HStack {
                    Text("I'm interested in \(selection)")
                        .font(.custom("LexendMega-Bold", size : 15))
                        .tracking(-2.0)
                        .foregroundColor(.black)
                        .padding(.leading, 40)
                    Spacer()
                    
                    if(currentUser.interestedIn == selection) {
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
        
    }
}

struct DatingPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        DatingPreferencesView()
    }
}
