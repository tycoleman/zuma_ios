//
//  MatchViewModel.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/29/23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseAuth
import CoreLocation

struct User : Identifiable {
    var id : String
    var age : Int
    var bio : String
    var city : String
    var firstName : String
    var isPushOn : Bool
    var isOnline : Bool
    var interests : [String]
    var pushToken : String
    var photo1 : String
    var photo2 : String
    var photo3 : String
    var photo4 : String
    var photo5 : String
    var photo6 : String
}




struct Message : Identifiable {
    var id : Double
    var messageContent : String
    var messageType : String
    var sender : String
    var isRead : Bool
    var dateRead : Double
    var dateSent : Double
    var timeSentString : String
}


class MatchViewModel: ObservableObject {
    
    //Core user properties
    @Published var otherUser = User(id: "",
                                    age : 0,
                                    bio : "",
                                    city : "",
                                    firstName: "",
                                    isPushOn: false,
                                    isOnline : false,
                                    interests : [""],
                                    pushToken: "",
                                    photo1: "",
                                    photo2: "",
                                    photo3: "",
                                    photo4: "",
                                    photo5: "",
                                    photo6: "")
    
    
    @Published var currentUserID : String = ""
    @Published var hasMatchForToday = false
    @Published var matchID : String = ""
    
    
    func listenForMatches() {
        
        let user = Auth.auth().currentUser
        self.currentUserID = user?.uid ?? ""
        
        database.collection("matches").whereField("members", arrayContains: currentUserID).addSnapshotListener { [self] snapshot, error in
            guard (snapshot?.documents) != nil else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            for doc in snapshot!.documents {
                let isActive = doc.get("isActive") as? Bool ?? false
                
                if (isActive) {
                    self.hasMatchForToday = true
                    self.matchID = doc.documentID
                    self.getMessagesForConnectionID()
                    
                    let members = doc.get("members") as? [String] ?? ["", ""]

                    let user1ID = members[0]
                    let user2ID = members[1]
                    
                    self.otherUser.id = currentUserID == user1ID ? user2ID : user1ID
                    
                    print("Match : \(self.otherUser.id)")

                    listenForMatchUpdates()
                    
                }
            }
        }
    }
    
    func listenForMatchUpdates() {
        database.collection("users").document(self.otherUser.id).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            self.otherUser.age = self.calculateAge(birthday : document.get("birthday") as? String ?? "") ?? 0
            self.otherUser.bio = document.get("bio") as? String ?? ""
            
            let lat = document.get("lat") as? Double ?? 0.0
            let lng = document.get("lng") as? Double ?? 0.0
            self.getCityFromLatLon(latitude: lat, longitude: lng)
            
            self.otherUser.firstName = document.get("firstName") as? String ?? ""
            self.otherUser.isPushOn = document.get("isPushOn") as? Bool ?? false
            self.otherUser.isOnline = document.get("isOnline") as? Bool ?? false
            self.otherUser.interests = document.get("interests") as? [String] ?? [""]
            self.otherUser.pushToken = document.get("pushToken") as? String ?? ""
            self.otherUser.photo1 = document.get("photo1") as? String ?? ""
            self.otherUser.photo2 = document.get("photo2") as? String ?? ""
            self.otherUser.photo3 = document.get("photo3") as? String ?? ""
            self.otherUser.photo4 = document.get("photo4") as? String ?? ""
            self.otherUser.photo5 = document.get("photo5") as? String ?? ""
            self.otherUser.photo6 = document.get("photo6") as? String ?? ""
            
        }
    }
    
    func updateReadMessagesForOtherUser(otherUserID: String, matchID : String) {
        // Reference to the Firestore database
        let db = Firestore.firestore()
        
        print("Match ID: ", matchID)
        // Access the "messages" collection
        let messagesCollection = db.collection("matches").document(matchID).collection("messages")
        
        // Create a query to filter for unread messages sent by the current user
        let query = messagesCollection.whereField("isRead", isEqualTo: false)
                                       .whereField("sender", isEqualTo: otherUserID)
        
        // Get all the documents that match the query
        query.getDocuments { (snapshot, error) in
            // Error handling
            guard let documents = snapshot?.documents, error == nil else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            print("document: ", documents)
            
            // Get the current UNIX epoch time in seconds
            let currentTimeInSeconds = Date().timeIntervalSince1970
            
            // Loop through each document and update it
            for document in documents {
                document.reference.updateData([
                    "dateRead": currentTimeInSeconds,
                    "isRead" : true
                ])
            }
        }
    }






    
    
    func calculateAge(birthday: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let birthDate = dateFormatter.date(from: birthday) else {
            print("Error: could not convert birthday string to a date.")
            return nil
        }
        
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date())
        guard let age = ageComponents.year else {
            print("Error: could not compute age.")
            return nil
        }
        
        return age
    }
    
    func formatDateFromTimestamp(timestamp: Double) -> String {
        // Convert the timestamp to Date
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        // Check if the date is from today
        if Calendar.current.isDateInToday(date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            return "Today at \(formatter.string(from: date))"
        } else {
            // Add additional formatting options for other days if needed
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, h:mm a"
            return formatter.string(from: date)
        }
    }
    
    
    func deleteMatch() {
        var userRef = database.collection("matches").document(self.matchID)

        userRef.updateData([
            "isActive": false
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func reportUser() {
        let connectionRef = database.collection("matches").document(matchID)
        
        connectionRef.updateData([
            "isActive" : false
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        let reportRef = database.collection("reportedUsers").document("\(NSDate().timeIntervalSince1970)")
    
        
        reportRef.setData([
            "reportedUserID" : matchID,
            "reportedBy" : self.currentUserID,
            "dateReported" : NSDate().timeIntervalSince1970
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    
    
    //Messaging
    @Published var messages = [Message]()

    
    func getMessagesForConnectionID() {

        database.collection("matches").document(matchID).collection("messages").addSnapshotListener { [self] snapshot, error in
            guard (snapshot?.documents) != nil else {
                print("Error fetching documents: \(error!)")
                return
            }

            messages = [Message]()

            for doc in snapshot!.documents {
                let messageID = Double(doc.documentID)
                let sender = doc.get("sender") as? String ?? ""
                let messageContent = doc.get("messageContent") as? String ?? ""
                let isRead = doc.get("isRead") as? Bool ?? false
                let dateRead = doc.get("dateRead") as? Double ?? 0.0
                var messageType = doc.get("messageType") as? String ?? ""
                let dateSent = Double(doc.documentID) ?? 0.0
                let timeSentString = formatDateFromTimestamp(timestamp: dateSent)
                
                
                if sender == self.currentUserID {
                    messageType = "currentUser"
                } else {
                    messageType = "otherUser"
                }
                
                let message = Message( id: messageID!,
                                       messageContent: messageContent,
                                       messageType: messageType,
                                       sender: sender,
                                       isRead : isRead,
                                       dateRead: dateRead,
                                       dateSent: dateSent,
                                       timeSentString : timeSentString)

                messages.append(message)
            }

            messages.sort { $0.id < $1.id}
        }
    }
    
    func sendMessage(messageContent: String, messageType: String) {
        let currentTime = String(describing: Date().timeIntervalSince1970)

        let chatRef = database.collection("matches").document(matchID).collection("messages").document(currentTime)
        
        let data = [
            "sender": self.currentUserID,
            "messageContent" : messageContent,
            "messageType" : messageType,
            "dateSent" : NSDate().timeIntervalSince1970,
            "isRead" : false
        ] as [String : Any]
        
        chatRef.setData(data) { error in
            if let error = error {
                print(error)
            } else {
                
            }
        }
    }
    
    
    
    func getCityFromLatLon(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: nil) { (placemarks, error) in
            if let city = placemarks?.first?.locality {
                self.otherUser.city = city
                print(city)
            } else {
                self.otherUser.city = "N/A"
            }
        }
    }
}

