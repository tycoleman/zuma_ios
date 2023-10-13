//
//  BirthdayView.swift
//  Zuma
//
//  Created by Adrian Martushev on 5/28/23.
//

import SwiftUI

struct BirthdayView: View {
    @State private var day: String = ""
    @State private var month: String = ""
    @State private var year: String = ""

    @EnvironmentObject var currentUser : CurrentUserViewModel

    @State var showBirthdayAlert = false
    @State var showBirthdayError = false

    @State var age : Int = 0
    @State var navigate : Bool = false

    var body: some View {
        VStack {
            VStack {
                
                HStack(spacing: 0) {
                    Rectangle()
                        .frame(width: 240, height: 5)
                    Rectangle()
                        .fill(Color("LightGray"))
                        .frame( height: 5)
                        
                }
                .padding(.top, 70)
                .navigationTitle("")
                .navigationBarHidden(true)
                
                HStack {
                    Text("When's your birthday?")
                        .font(.custom("LexendMega-Bold", size : 25))
                        .tracking(-3.0)
                        .padding(.top, 40)
                    
                    Spacer()
                }

                
                HStack {
                    VStack(alignment : .leading) {
                        
                        Text("Month")
                            .font(.custom("LexendMega-Regular", size : 11))
                            .tracking(-1.0)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame(width : 55, height : 55)
                                .offset(x : 4, y : 3)
                            
                            TextField("", text : $month)
                                .placeholder(when: month.isEmpty) {
                                    Text("MM").foregroundColor(Color("Gray"))
                                        .multilineTextAlignment(.center)
                                        .frame(width : 55, height : 55)

                                }
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .font(.custom("LexendMega-Medium", size : 14))
                                .tracking(-2.0)
                                .frame(width : 55, height : 55)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                                .keyboardType(.numberPad)
                        }
                        .padding(.trailing, 6)
                    }
                    
                    VStack(alignment : .leading) {
                        
                        Text("Day")
                            .font(.custom("LexendMega-Regular", size : 11))
                            .tracking(-1.0)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame(width : 55, height : 55)
                                .offset(x : 4, y : 3)
                            
                            TextField("", text : $day)
                                .placeholder(when: day.isEmpty) {
                                    Text("DD").foregroundColor(Color("Gray"))
                                        .multilineTextAlignment(.center)
                                        .frame(width : 55, height : 55)


                                }
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .font(.custom("LexendMega-Medium", size : 14))
                                .tracking(-2.0)
                                .frame(width : 55, height : 55)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                                .keyboardType(.numberPad)

                        }
                        .padding(.trailing, 6)
                    }
                    

                    VStack(alignment : .leading) {
                        
                        Text("Year")
                            .font(.custom("LexendMega-Regular", size : 11))
                            .tracking(-1.0)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame(width : 60, height : 55)
                                .offset(x : 4, y : 3)
                            
                            TextField("", text : $year)
                                .placeholder(when: year.isEmpty) {
                                    Text("YYYY").foregroundColor(Color("Gray"))
                                        .multilineTextAlignment(.center)
                                        .frame(width : 60, height : 55)

                                }
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .font(.custom("LexendMega-Medium", size : 14))
                                .tracking(-2.0)
                                .frame(width : 60, height : 55)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                                .keyboardType(.numberPad)

                        }
                    }
                    
                    Spacer()
                }
                .padding(.top)
                
                
                Spacer()
                
                HStack {
                    HStack(spacing : 0) {
                        Image("eye")
                            .resizable()
                            .scaledToFit()
                            .frame(width : 15)
                            .padding(.trailing, 5)
                        
                        Text("This will not be shown on your profile.")
                            .font(.custom("LexendMega-Regular", size : 10))
                            .tracking(-2.0)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()

                    }
                    .frame(width: 240)
                    
                    Spacer()
                    
                    Button {
                        let ageInt = currentUser.calculateAge(birthday: "\(self.day)/\(self.month)/\(self.year)")
                        
                        if ageInt != nil {
                            showBirthdayAlert = true

                            self.age = ageInt!
                        } else {
                            showBirthdayError = true
                        }
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.black)
                                .frame(width : 68, height : 68)
                                .offset(x : 3, y : 3)
                            
                            RoundedRectangle(cornerRadius: 100)
                                .fill(self.year == "" ? Color("LightGray") : Color("Yellow"))
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
                    .alert(isPresented: $showBirthdayAlert) {
                            Alert(title: Text("You're \(self.age)"),
                                 message: Text("Make sure this is your age as you can't change this later."),
                                 primaryButton: .default(
                                     Text("Confirm"),
                                     action: {
                                         currentUser.birthday = "\(self.day)/\(self.month)/\(self.year)"
                                         self.navigate = true
                                     }
                                 ),
                                 secondaryButton: .destructive(
                                     Text("Cancel"),
                                     action: {
                                         showBirthdayAlert = false
                                     }
                                 ))
                    }
                    
                    NavigationLink(destination: GenderView(), isActive: $navigate) {
                        EmptyView()
                    }
                    .alert(isPresented: $showBirthdayError) {
                        Alert(title: Text("Incorrect Format"), message: Text("Please verify your birthday and try again") )
                    }

                }
                
                Spacer().frame(height: 50)

            }
            .padding(.vertical)
            .padding(.horizontal, 30)
        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct BirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayView()
    }
}
