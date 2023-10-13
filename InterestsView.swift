//
//  InterestsView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/2/23.
//

import SwiftUI

struct InterestsView: View {
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    @State var interestsArray = ["Music", "Travel", "Art", "Comedy", "Movies", "Foodie", "Dogs", "Surfing", "Golf", "Dancing", "Gym", "Wine", "Outdoors", "Reading", "Cats", "Writing", "Beaches", "Skiing"]
    
    
    func appendStringAndCheck(activity: String) {
        
        if let index = currentUser.interests.firstIndex(of: activity) {
            currentUser.interests.remove(at: index)
            
        } else {
            currentUser.interests.append(activity)
            
            if currentUser.interests.count >= 4 {
                currentUser.interests.removeFirst()
            }
        }
        
        currentUser.updateInterests()
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
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
                        .padding(.leading, 15)
                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    
                    Spacer()
                    
                }
                VStack(alignment : .leading, spacing : 20) {
                    
                    Text("Choose your interests")
                        .font(.custom("LexendMega-Bold", size : 25))
                        .tracking(-3.0)
                        .padding(.top, 40)
                        .navigationTitle("")
                        .navigationBarHidden(true)
                        .padding(.leading, 15)
                    
                    
                    Text("Pick three interests.")
                        .font(.custom("LexendMega-Regular", size : 12))
                        .tracking(-2.0)
                        .padding(.bottom, 10)
                        .padding(.leading, 15)

                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                            ForEach(interestsArray, id: \.self) { activity in
                                
                                Button(action: {
                                    appendStringAndCheck(activity: activity)
                                    
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.black)
                                            .frame(width : 100, height : 45)
                                            .offset(x : 5, y : 5)
                                        
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(currentUser.interests.contains(activity) ? Color("Yellow") : Color("LightGray"))
                                            .frame(width : 100, height : 45)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.black, lineWidth: 4)
                                            )
                                        
                                        HStack (spacing: 0) {
                                            Image(activity)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 15, height : 15)
                                                .padding(.trailing, 5)
                                            
                                            Text("\(activity)   ")
                                                .font(.custom("LexendMega-Medium", size : 12))
                                                .tracking(-3.0)
                                                .foregroundColor(.black)
                                            
                                        }
                                    }
                                })
                            }
                        }
                        .padding(.top)
                    }
                }
                
                Spacer()

            }
            .padding()
        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}


struct InterestsView_Previews: PreviewProvider {
    static var previews: some View {
        InterestsView()
    }
}
