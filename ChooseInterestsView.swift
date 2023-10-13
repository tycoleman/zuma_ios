//
//  InterestsView.swift
//  Zuma
//
//  Created by Adrian Martushev on 5/28/23.
//

import SwiftUI


struct ChooseInterestsView: View {
    
    @State var usersBio = "150 characters max"
    @State var interestsArray = ["Music", "Travel", "Art", "Comedy", "Movies", "Foodie", "Dogs", "Surfing", "Golf", "Dancing", "Gym", "Wine", "Outdoors", "Reading", "Cats", "Writing", "Beaches", "Skiing"]
    
    @State var selectedInterestsArray = [String]()
    
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    func appendStringAndCheck(_ str: String) {
        selectedInterestsArray.append(str)
        
        if selectedInterestsArray.count >= 4 {
            selectedInterestsArray.removeFirst()
        }
    }
    
    
    var body: some View {
        VStack {
            VStack() {
                
                HStack(spacing: 0) {
                    Rectangle()
                        .frame(width: 300, height: 5)
                    Rectangle()
                        .fill(Color("LightGray"))
                        .frame(height: 5)
                        
                }
                .padding(.top, 70)
                .navigationTitle("")
                .navigationBarHidden(true)
                .padding(.horizontal)
                
                
                
                VStack(alignment : .leading, spacing : 20) {
                    Text("Choose your interests")
                        .font(.custom("LexendMega-Bold", size : 25))
                        .tracking(-3.0)
                        .padding(.top, 40)
                        .padding(.trailing, 40)
                    
                    Text("Pick three interests. You can change this later.")
                        .font(.custom("LexendMega-Regular", size : 12))
                        .tracking(-2.0)
                        .padding(.bottom, 10)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                            ForEach(interestsArray, id: \.self) { activity in
                                
                                Button(action: {
                                    
                                    if let index = selectedInterestsArray.firstIndex(of: activity) {
                                        selectedInterestsArray.remove(at: index)
                                        
                                    } else {
                                        appendStringAndCheck(activity)
                                    }
                                    
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.black)
                                            .frame(width : 100, height : 45)
                                            .offset(x : 5, y : 5)
                                        
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(selectedInterestsArray.contains(activity) ? Color("Yellow") : Color("LightGray"))
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
                .padding(.horizontal)

                
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    NavigationLink {
                        EmailView()
                            .onAppear {
                                currentUser.interests = selectedInterestsArray
                            }
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.black)
                                .frame(width : 68, height : 68)
                                .offset(x : 3, y : 3)
                            
                            RoundedRectangle(cornerRadius: 100)
                                .fill(selectedInterestsArray.count == 0 ? Color("LightGray") : Color("Yellow"))
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
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}


struct InterestButton : View {
    
    
    var body : some View {
        Button {
            print("test")
        } label: {
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
                
                Image("chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width : 16, height : 24)


            }
        }
        
    }
}


struct ChooseInterestsView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseInterestsView()
    }
}
