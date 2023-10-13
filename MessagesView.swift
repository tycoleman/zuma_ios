//
//  MessagesView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/2/23.
//

import SwiftUI


struct MessagesView : View {
    @EnvironmentObject var match : MatchViewModel
    
    var body : some View {
        VStack {
            VStack {
                
                ForEach(match.messages) { message in
                    if(message.sender == match.currentUserID) {
                        UserMessage(content : message.messageContent, timeSentString : message.timeSentString, dateRead : message.dateRead)
                            .padding(.bottom, 5)

                    } else {
                        ConnectionMessage(content : message.messageContent, timeSentString : message.timeSentString)
                            .padding(.bottom, 5)

                    }
                }

            }
            .padding(.horizontal)

        }
        .padding(.bottom, 50)
    }
}

struct UserMessage : View {
    
    var content : String
    var timeSentString : String
    var dateRead : Double

    func formatDateFromTimestamp(timestamp: Double) -> String {
        // Convert the timestamp to Date
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        // Check if the date is from today
        if Calendar.current.isDateInToday(date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            return "Read \(formatter.string(from: date))"
        } else {
            // Add additional formatting options for other days if needed
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, h:mm a"
            return "Read \(formatter.string(from: date))"
        }
    }
    
    var body : some View {
        
        HStack {
            Spacer()
            
            VStack(alignment : .leading) {
                Text("\(timeSentString)")
                    .font(.custom("LexendMega-Regular", size : 8))
                    .tracking(-1.0)
                    .padding(.leading, 40)
                
                ZStack {
                    Rectangle()
                        .background(.black)
                        .frame(width : 250, height : 80)
                        .cornerRadius(100, corners: [.topLeft, .topRight, .bottomLeft])
                        .offset(x : 3, y : 3)


                    Rectangle()
                        .background(.black)
                        .frame(width : 250, height : 80)
                        .cornerRadius(100, corners: [.topLeft, .topRight, .bottomLeft])
                    Rectangle()
                        .fill(Color("Yellow"))
                        .cornerRadius(100, corners: [.topLeft, .topRight, .bottomLeft])
                        .frame(width : 245, height : 75)
                    
                    HStack {
                        Text(content)
                            .font(.custom("LexendMega-Medium", size : 14))
                            .multilineTextAlignment(.leading)
                            .tracking(-2.0)
                            .padding()
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .cornerRadius(100, corners: [.topLeft, .topRight, .bottomLeft])
                    .frame(width : 250, height : 80)
                }
            }
        }
        HStack {
            Spacer()
            
            if(dateRead != 0.0) {
                Text("\(formatDateFromTimestamp(timestamp: dateRead))")
                    .font(.custom("LexendMega-Regular", size : 8))
                    .tracking(-1.0)
                    .padding(.leading, 40)
            }
        }
    }
}

struct ConnectionMessage : View {
    @EnvironmentObject var match : MatchViewModel
    
    var content : String
    var timeSentString : String

    var body : some View {
        HStack(alignment: .bottom) {

            NavigationLink {
                ConnectionProfileView(showChatButton: false )
            } label: {
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
                .frame(width: 35, height: 35)
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.black, lineWidth : 2)
                )
            }
            
            VStack(alignment : .leading) {
                Text("\(timeSentString)")
                    .font(.custom("LexendMega-Regular", size : 8))
                    .tracking(-1.0)
                    .padding(.leading, 40)
                
                ZStack {
                    Rectangle()
                        .background(.black)
                        .frame(width : 250, height : 80)
                        .cornerRadius(100, corners: [.topLeft, .topRight, .bottomRight])
                        .offset(x : 3, y : 3)


                    Rectangle()
                        .background(.black)
                        .frame(width : 250, height : 80)
                        .cornerRadius(100, corners: [.topLeft, .topRight, .bottomRight])
                    Rectangle()
                        .fill(Color("LightGray"))
                        .cornerRadius(100, corners: [.topLeft, .topRight, .bottomRight])
                        .frame(width : 245, height : 75)
                    
                    Text(content)
                        .font(.custom("LexendMega-Medium", size : 14))
                        .tracking(-2.0)
                        .padding()
                        .foregroundColor(.black)
                        .cornerRadius(100, corners: [.topLeft, .topRight, .bottomRight])
                        .frame(width : 250, height : 80)
                }
            }
            Spacer()

        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
