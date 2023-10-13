//
//  CurrentUserViewModel.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/12/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import Firebase
import Combine
import CoreLocation


let database = Firestore.firestore()


class CurrentUserViewModel: ObservableObject {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    //Core user properties
    @Published var age : Int = 0
    @Published var phoneNumber: String = ""
    @Published var currentCity: String = ""
    @Published var lat = 0.0
    @Published var lng = 0.0
    @Published var firstName: String = ""
    @Published var isOnline : Bool = false
    @Published var lastName: String = ""
    @Published var instagramUsername: String = ""
    @Published var referralName: String = ""
    @Published var photo1 = ""
    @Published var photo2 = ""
    @Published var photo3 = ""
    @Published var photo4 = ""
    @Published var photo5 = ""
    @Published var photo6 = ""
    @Published var birthday: String = "00/00/0000"
    @Published var gender: String = ""
    @Published var interestedIn: String = ""

//    @Published var bio: String = ""
    @Published var interests: [String] = [""]
    @Published var email: String = ""
    @Published var dateCreated : Double = 0.0
    @Published var subscriptionTerm : String = ""
    @Published var applicationStatus = "notApproved"
    
    @Published var bio: String = "" {
        didSet {
            if bio.count > maxLength {
                bio = String(bio.prefix(maxLength))
            }
        }
    }

    let maxLength = 150
        
    //Enable and disable notifications
    @Published var pushToken : String = ""

    @Published var isPushOn: Bool = false {
        didSet {
            if isPushOn == true {
                enableNotifications()
            } else {
                disableNotifications()
            }
        }
    }
    
    
    func enableNotifications() {
        let userInfo = database.collection("users").document(self.currentUserID)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if let error = error {
                print("Failed to register with error: \(error.localizedDescription)")
            } else {
                print("Success! We authorized notifications")
                
                //Get device token to update firestore
                DispatchQueue.main.async {
                    //Update needs to be in queue
                    UIApplication.shared.registerForRemoteNotifications()
                    
                    let token = self.delegate.deviceToken
                    
                    userInfo.updateData([
                        "pushToken": token,
                        "isPushOn": self.isPushOn,
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Push Notifications updated")
                        }
                    }
                }
            }
        }
    }
    
    func disableNotifications() {
        let userInfo = database.collection("users").document(self.currentUserID)
        self.pushToken = ""
        userInfo.updateData([ "isPushOn": self.isPushOn,
                              "pushToken" : self.pushToken
                            ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Push Notifications updated: disabled")
            }
        }
    }
    
    @Published var interestsList: [String] = ["Reading", "Blogging", "Dancing","Singing", "Music", "Playing an Instrument", "Learning new languages", "Shopping", "Traveling", "Hiking", "Cycling", "Exercising", "Drawing", "Painting", "Collecting Things", "Gaming", "Cooking", "Baking", "Gardening", "Crafts", "Embroidering", "Sewing", "Knitting", "Board Games", "Walking", "Writing", "Fishing", "Photography", "Skydiving", "Skating", "Skiing", "Roller skating", "Longboarding", "Surfing"
    ]
    
    
    var didChange = PassthroughSubject<CurrentUserViewModel, Never>()

    @Published var currentUserID: String = "" {
        didSet {
            
            didChange.send(self)
            
        }
    }
    
    var handle: AuthStateDidChangeListenerHandle?

    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { [self] (auth, user) in
            
            if let user = user {
                print("User is available, uid: \(user.uid)")
                self.currentUserID = user.uid

                
                //Check if user has account record
                let userRef = database.collection("users").document(user.uid)
                userRef.getDocument { [self] (document, error) in
                    if let document = document, document.exists {
                        let dateCreated = document.get("dateCreated") as? Double ?? 0.0
                        
                        if dateCreated != 0.0 {
                            getUserInfo()
                        }
                        
                    } else {
                        self.applicationStatus = ""
                    }
                }
                
            } else {
                // if we don't have a user, set our session to nil
                self.currentUserID = ""
            }
        }
    }
    
    func getUserInfo() {
        database.collection("users").document(self.currentUserID).addSnapshotListener { snapshot, error in
            guard let document = snapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            //Initialize core properties
            self.age = self.calculateAge(birthday: document.get("birthday") as? String ?? "") ?? 0
            self.applicationStatus = document.get("applicationStatus") as? String ?? ""
            self.phoneNumber = document.get("phoneNumber") as! String
            self.lat = document.get("lat") as! Double
            self.lng = document.get("lng") as! Double
//            self.currentCity = document.get("currentCity") as! String
            self.getCityFromLatLon(latitude: self.lat, longitude: self.lng)
            
            self.pushToken = document.get("pushToken") as? String ?? ""
            self.isPushOn = document.get("isPushOn") as? Bool ?? false

            self.firstName = document.get("firstName") as! String
            self.isOnline = document.get("isOnline") as?  Bool ?? false
            self.lastName = document.get("lastName") as! String
            self.instagramUsername = document.get("instagramUsername") as! String
            self.referralName = document.get("referralName") as! String
            self.photo1 = document.get("photo1") as! String
            self.photo2 = document.get("photo2") as! String
            self.photo3 = document.get("photo3") as! String
            self.photo4 = document.get("photo4") as! String
            self.photo5 = document.get("photo5") as! String
            self.photo6 = document.get("photo6") as! String
            self.birthday = document.get("birthday") as! String
            self.gender = document.get("gender") as! String
            self.interestedIn = document.get("interestedIn") as! String
            self.bio = document.get("bio") as! String
            self.interests = document.get("interests") as! [String]
            self.email = document.get("email") as! String
            self.dateCreated = document.get("dateCreated") as? Double ?? 0.0
            self.subscriptionTerm = document.get("subscriptionTerm") as! String
            self.applicationStatus  = document.get("applicationStatus") as! String
        }
    }
    
    
    func createUser() {
        
        var userData = [
            "phoneNumber" : self.phoneNumber,
            "currentCity": self.currentCity,
            "lat" : self.lat,
            "lng" : self.lng,
            "pushToken": self.delegate.deviceToken,
            "isPushOn": self.isPushOn,
            "firstName": self.firstName,
            "lastName": self.lastName,
            "instagramUsername": self.instagramUsername,
            "referralName": self.referralName,
            "photo1" : self.photo1,
            "photo2" : self.photo2,
            "photo3" : self.photo3,
            "photo4" : self.photo4,
            "photo5" : self.photo5,
            "photo6" : self.photo6,
            "birthday": self.birthday,
            "gender": self.gender,
            "interestedIn": self.interestedIn,
            "bio": self.bio,
            "interests": self.interests,
            "email": self.email,
            "dateCreated" : NSDate().timeIntervalSince1970,
            "subscriptionTerm" : self.subscriptionTerm,
            "applicationStatus" : "pending"
            
        ] as [String : Any]
        
        print(userData)
        
        let userRef = database.collection("users").document(currentUserID)
        
        userRef.setData(userData) { error in
            if let error = error {
                print(error)
            } else {
                print("successfully created user")
            }
        }
    }
    
    
    
    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }
    
    
    func getRandomID(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
    func verifyReferralCode(code : String, completion : @escaping(Bool) -> ()) {
        
        let referralRef = database.collection("referralCodes").document(code)
        
        referralRef.getDocument { (document, error) in
            if let document = document, document.exists {

                let isActive = document.get("isActive") as? Bool ?? false
                
                if(isActive) {
                    completion(true)
                } else {
                    completion(false)
                }
                
            } else {
                print("Something doesn't exist")
                completion(false)
            }
        }
    }
    
    
    
    
    
    
    func updateInterestedIn(selection : String) {
        
        var userRef = database.collection("users").document(currentUserID)
        
        userRef.updateData([
            "interestedIn": selection
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    
    func updateEmail(newEmail : String) {
        let userRef = database.collection("users").document(self.currentUserID)

        userRef.updateData([
            "email": newEmail
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                self.email = newEmail
                print("Document successfully updated")
            }
        }
    }
    
    func updateMembership(status : String) {
        let userRef = database.collection("users").document(self.currentUserID)

        userRef.updateData([
            "applicationStatus": status
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func updateInterests() {
        var userRef = database.collection("users").document(currentUserID)

        userRef.updateData([
            "interests": self.interests
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    
    func updateBio() {
        var userRef = database.collection("users").document(currentUserID)

        userRef.updateData([
            "bio": self.bio
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    
    
    
    
    
    //Helper Funcitons
    
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
    
    
    
    
    func getCityFromLatLon(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: nil) { (placemarks, error) in
            if let city = placemarks?.first?.locality {
                self.currentCity = city
            } else {
                self.currentCity = "N/A"
            }
        }
    }
}
