//
//  ChatView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/2/23.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var match : MatchViewModel
    @EnvironmentObject var notifications : Notifications
    @EnvironmentObject var currentUser : CurrentUserViewModel

    @State var message = ""
    @State var showingOptions = false
    @State var navigateHome = false

    
    func getTimeUntilMidnight() -> String {
        let now = Date()
        let calendar = Calendar.current
        var returnString = ""
        
        // Get the next midnight time
        if let midnight = calendar.nextDate(after: now, matching: DateComponents(hour:0, minute:0), matchingPolicy: .nextTime) {
            
            let components = calendar.dateComponents([.hour, .minute], from: now, to: midnight)
            
            if let hour = components.hour, let minute = components.minute {
                returnString = String(format: "%d:%02d hours left to message", hour, minute)
            }
        } else {
            returnString = "Chat now!"
        }
        
        return returnString
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("backArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36)
                                .padding(.leading, 15)
                        }
                        Spacer()

                        HStack {
                            Circle()
                                .strokeBorder(Color.black,lineWidth: 1)
                                .background(match.otherUser.isOnline ? Circle().foregroundColor(Color("Green")) : Circle().foregroundColor(.clear))
                                .frame(width: 10, height: 10)
                            
                            Text(match.otherUser.firstName)
                                .font(.custom("LexendMega-SemiBold", size : 18))
                                .tracking(-2.0)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Button {
                            showingOptions = true
                        } label: {
                            Image("ellipsis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36)
                                .padding(.trailing, 15)
                        }

                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    .onAppear {
                        match.updateReadMessagesForOtherUser(otherUserID : match.otherUser.id, matchID : match.matchID)
                    }
                    .sheet(isPresented: $showingOptions) {
                        OptionsView(navigateHome : $navigateHome)
                            .presentationDetents([.height(350)])

                    }
                    
                    NavigationLink(destination: HomeView(), isActive: $navigateHome) {
                        EmptyView()
                    }

                    ScrollView (showsIndicators: false) {
                        Spacer()
                        TimerCircleView()
                        
                        HStack {
                            Circle()
                                .strokeBorder(Color.black,lineWidth: 1)
                                .background(match.otherUser.isOnline ? Circle().foregroundColor(Color("Green")) : Circle().foregroundColor(.clear))
                                .frame(width: 10, height: 10)

                            Text(match.otherUser.firstName)
                                .font(.custom("LexendMega-SemiBold", size : 27))
                                .tracking(-2.0)
                                .foregroundColor(.black)
                        }
                        
                        Text(getTimeUntilMidnight())
                            .font(.custom("LexendMega-Medium", size : 14))
                            .tracking(-2.0)
                            .foregroundColor(.black)
                    
                        Spacer()
                        
                        MessagesView()
                    }

                    ZStack {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(.black)
                            .frame(height : 60)
                            .offset(x : 4, y : 3)
                        
                        TextField("Send a message...", text : $message)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color("Gray"))
                            .font(.custom("LexendMega-Medium", size : 14))
                            .tracking(-2.0)
                            .padding(.leading, 20)
                            .frame( height : 60)
                            .background(.white)
                            .cornerRadius(100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(.black, lineWidth: 4)
                            )
                        
                        HStack {
                            Spacer()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(.black)
                                    .frame(width : 40, height : 40)
                                    .offset(x : 3, y : 3)
                                
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(Color("Yellow"))
                                    .frame(width : 40, height : 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 100)
                                            .stroke(.black, lineWidth: 4)
                                    )
                                
                                Button {
                                    match.sendMessage( messageContent: message, messageType: "text")
                                    notifications.sendMessageNotification(otherUserID: match.otherUser.id, currentUserName: currentUser.firstName)
                                    message = ""
                                } label: {
                                    
                                    Image("arrowUp")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width : 12, height : 12)
                                }
                            }
                            .offset(x: -12)
                        }
                        .frame( height : 60)

                    }
                }
                .padding()
            }
            .background(Color("BabyBlue"))
            
        }
    }
}

struct OptionsView : View {
    @State var showingDeleteAlert = false
    @State var showingReportAlert = false
    @Binding var navigateHome : Bool

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var match : MatchViewModel
    
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
            }
            .padding(.bottom, 30)
            
            Button {
                showingDeleteAlert = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.black)
                        .frame(width : 300, height : 70)
                        .offset(x : 7, y : 7)

                    Text("Delete Match")
                        .font(.custom("LexendMega-Bold", size : 13))
                        .tracking(-2.0)
                        .frame(width : 300, height : 70)
                        .foregroundColor(.black)
                        .background(Color("Red"))
                        .cornerRadius(100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(.black, lineWidth: 4)
                        )
                }
            }
            .alert(isPresented: $showingDeleteAlert) {
                Alert(title: Text("Delete Match"), message: Text("Are you sure you want to delete this match?"), primaryButton: .default(Text("Yes")) {
                    match.deleteMatch()
                    navigateHome = true
                    presentationMode.wrappedValue.dismiss()

                }, secondaryButton: .cancel())
            }
            .padding(.bottom, 20)
            
            Button {
                showingReportAlert = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.black)
                        .frame(width : 300, height : 70)
                        .offset(x : 7, y : 7)

                    Text("Report Match")
                        .font(.custom("LexendMega-Bold", size : 13))
                        .tracking(-2.0)
                        .frame(width : 300, height : 70)
                        .foregroundColor(.black)
                        .background(Color("LightGray"))
                        .cornerRadius(100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(.black, lineWidth: 4)
                        )
                }
            }
            .alert(isPresented: $showingReportAlert) {
                Alert(title: Text("Report User"), message: Text("Are you sure you want to report this user? The match will be deleted and we will be notified."), primaryButton: .default(Text("Yes")) {
                    match.reportUser()
                    navigateHome = true
                    presentationMode.wrappedValue.dismiss()

                }, secondaryButton: .cancel())
            }
            .padding(.bottom, 20)

            
            Button {
                showingReportAlert = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.black)
                        .frame(width : 300, height : 70)
                        .offset(x : 7, y : 7)

                    Text("Block User")
                        .font(.custom("LexendMega-Bold", size : 13))
                        .tracking(-2.0)
                        .frame(width : 300, height : 70)
                        .foregroundColor(.black)
                        .background(Color("LightGray"))
                        .cornerRadius(100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(.black, lineWidth: 4)
                        )
                }
            }
            .alert(isPresented: $showingReportAlert) {
                Alert(title: Text("Report User"), message: Text("Are you sure you want to block this user? You won't see them again."), primaryButton: .default(Text("Yes")) {
                    match.reportUser()
                    navigateHome = true
                    presentationMode.wrappedValue.dismiss()

                }, secondaryButton: .cancel())
            }
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
                    .font(.custom("LexendMega-Bold", size : 13))
                    .tracking(-2.0)
                    .frame(width : 300, height : 70)
                    .foregroundColor(.black)

            }
                        
            Spacer()

        }
        .background(Color("BabyBlue"))
    }
}




struct CircularProgressView: View {
    
    @State var progress: Double = 6.0
    let timeLeft: Double = 12.0
    
    @State private var timePassed = 6.0
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.gray.opacity(0.5),
                    lineWidth: 20
                )
            Circle()
                .trim(from: 1.0, to: 0.0) // 1
                .stroke(
                    Color("Yellow"),
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }
    }
}


struct TimerCircleView: View {
    @EnvironmentObject var match : MatchViewModel
    
    @State private var progress: Double = 0
    @State private var timer: Timer? = nil

    var body: some View {
        ZStack {
            // Outer black border
            Circle()
                .stroke(Color.black, lineWidth: 5)
                .frame(width:245, height: 245)

            
            // Yellow progress circle with inner black border
            Circle()
                .trim(from: CGFloat(progress), to: 1.0)
                .stroke(Color("Yellow"), style: StrokeStyle(lineWidth: 30, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width:210, height: 210)
                .padding(22)
            
            // Inner black border
            Circle()
                .stroke(Color.black, lineWidth: 5)
                .frame(width:180, height: 180)
                .padding(44)
            
            
            GeometryReader { geometry in
                AsyncImage(url: URL(string : match.otherUser.photo1)) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(y: (geometry.size.height * 0.3)) // Adjust this value based on how much you want to offset
                .clipShape(Circle())
            }
            .frame(width: 175, height: 175)


        }
        .onAppear {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.updateTime()
            }
        }
        .onDisappear {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    func updateTime() {
        let now = Date()
        let calendar = Calendar.current
        let noon = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: now)!
        let midnight = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: now))!

        if now >= noon {
            let totalInterval = midnight.timeIntervalSince(noon)
            let passedInterval = now.timeIntervalSince(noon)
            self.progress = passedInterval / totalInterval
        } else {
            self.progress = 0
        }
    }
}



struct TopClipShape: Shape {
    var heightPercent: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * heightPercent))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY * heightPercent))
        path.addLine(to: .zero)

        return path
    }
}






struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
