//
//  Notifications.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/29/23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseAuth



class Notifications : ObservableObject {
    
    // sendEmailTo/<email>/<subject>/<message>
    func sendSupportEmail(title: String, message: String, email: String) {
        let titleFixed = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "Empty Title"
        let messageFixed = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "Empty Message"
        let urlString = "https://zuma-b909e6770227.herokuapp.com/sendSupportEmail/\(email)/\(titleFixed)/\(messageFixed)"
        
        print("EMAIL URLSTRING",urlString)
        
        guard let url = URL(string: urlString) else { return }
        var req = URLRequest(url: url)

        req.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: req) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            print(data)
            let httpResponse = response as? HTTPURLResponse
            let statusCode = httpResponse?.statusCode

            if statusCode == 200 {
                print("200 status! Email sent")
            } else {
                print("Email error not 200 status")
            }
        }
        task.resume()
    }

    
    
    
    
    //Send notification when message sent
    func sendMessageNotification(otherUserID : String, currentUserName : String) {
        guard let url = URL(string: "https://zuma-b909e6770227.herokuapp.com/sendNotification/") else { return }
        
        
        //Get notification settings once, to avoid cycling
        let userRef = database.collection("users").document(otherUserID)
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let isPushOn = document.get("isPushOn") as? Bool ?? false
                let token = document.get("pushToken") as? String ?? ""

                if isPushOn {
                    print("Sending notification to \(otherUserID)")
                    let json: [String: Any] = [
                        "token": token,
                        "alert": "New Message From \(currentUserName)",
                        "badge": "1"
                    ]
                    
                    let jsonData = try? JSONSerialization.data(withJSONObject: json)
                    
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.httpBody = jsonData
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        guard let data = data, error == nil else {
                            print(error?.localizedDescription ?? "No data")
                            return
                        }
                        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                        if let responseJSON = responseJSON as? [String: Any] {
                            print(responseJSON)
                        }
                    }
                    
                    task.resume()

                } else {
                    print("user has not enabled account notifications")
                }
                
            } else {
                print("Error fetching document")
            }
        }
    }
}
