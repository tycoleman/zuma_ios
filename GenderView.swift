//
//  GenderView.swift
//  Zuma
//
//  Created by Adrian Martushev on 5/28/23.
//

import SwiftUI


struct GenderView: View {
    @State var isSelected = ""
    @State var showMoreGenders = false
    
    @EnvironmentObject var currentUser : CurrentUserViewModel

    var body: some View {
        VStack {
            VStack() {
                HStack(spacing: 0) {
                    Rectangle()
                        .frame(width: 260, height: 5)
                    Rectangle()
                        .fill(Color("LightGray"))
                        .frame( height: 5)
                        
                }
                .padding(.top, 70)
                .navigationTitle("")
                .navigationBarHidden(true)
                .padding(.horizontal, 10)

                    
                VStack(alignment : .leading) {
                    HStack {
                        Text("What's your gender?")
                            .font(.custom("LexendMega-Bold", size : 25))
                            .tracking(-3.0)
                            .padding(.top, 40)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("Everyone is welcome on Zuma!")
                            .font(.custom("LexendMega-Regular", size : 12))
                            .tracking(-2.0)
                            .padding(.top, 15)
                            .padding(.bottom, 30)
                        
                        Spacer()
                        
                    }
                }
                .padding(.horizontal, 10)

                
                ZStack {
                    VStack {
                        ScrollView {
                            
                            VStack {
                                GenderOptionButton(selection: $isSelected, genderString: "Man")
                                GenderOptionButton(selection: $isSelected, genderString: "Woman")

                                Button {
                                    showMoreGenders.toggle()
                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("More gender options ")
                                            .font(.custom("LexendMega-Regular", size : 12))
                                            .foregroundColor(.black)
                                            .tracking(-3.0)
                                        
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                    }
                                    .padding(.top, 20)
                                }
                                
                                
                                if(showMoreGenders) {
                                    VStack(alignment : .leading) {
                                        GenderOptionButton(selection: $isSelected, genderString: "Transgender")
                                        
                                        GenderOptionButton(selection: $isSelected, genderString: "Non-Binary")
                                        GenderOptionButton(selection: $isSelected, genderString: "Intersex")
                                        GenderOptionButton(selection: $isSelected, genderString: "Non-Conforming")
                                        GenderOptionButton(selection: $isSelected, genderString: "Other")

                                    }
                                }
                                
                            }
                            .padding(.horizontal, 10)
                            
                        }
                        
                        
                        Spacer()
                    }
                    
                    
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            NavigationLink {
                                InterestedInView()
                                    .onAppear {
                                        currentUser.gender = self.isSelected
                                    }
                                
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 100)
                                        .fill(.black)
                                        .frame(width : 68, height : 68)
                                        .offset(x : 3, y : 3)
                                    
                                    RoundedRectangle(cornerRadius: 100)
                                        .fill(self.isSelected == "" ? Color("LightGray") : Color("Yellow") )
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

                }
                
                

            }
            .padding(.vertical)
            .padding(.horizontal, 20)
        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}


struct GenderOptionButton : View {
    
    @Binding var selection : String
    var genderString : String
    
    var body: some View {
        Button {
            selection = genderString
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black)
                    .frame( height : 70)
                    .offset(x : 7, y : 7)
                RoundedRectangle(cornerRadius: 10)
                    .fill(selection == genderString ? Color("Yellow") : Color("LightGray"))
                    .frame( height : 70)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 4)
                    )
                
                HStack {
                    Text(genderString)
                        .font(.custom("LexendMega-Bold", size : 15))
                        .tracking(-2.0)
                        .foregroundColor(.black)
                        .padding(.leading, 40)
                    Spacer()
                    
                    if(selection == genderString) {
                        Image("checkmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width : 25)
                            .padding(.trailing, 20)
                    }
                }
            }
        }
        .padding(.top, 5)

    }
}

struct GenderView_Previews: PreviewProvider {
    static var previews: some View {
        GenderView()
    }
}
