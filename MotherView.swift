//
//  MotherView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/12/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct MotherView: View {
    @EnvironmentObject var currentUser : CurrentUserViewModel
    @EnvironmentObject var match : MatchViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
                        
            if (currentUser.currentUserID == "") {
                WelcomeView()

            } else if currentUser.applicationStatus == "accepted" {
                ZStack {
                    HomeView()
                        .onAppear {
                            match.listenForMatches()
                        }
                }
                .navigationTitle("")
                .navigationBarHidden(true)

            } else if currentUser.applicationStatus == "pending"  {
                UnderReviewView()
            } else if currentUser.applicationStatus == "recentlyAccepted"  {
                if (currentUser.subscriptionTerm == "" ) {
                    AcceptedView()
                } else {
                    OpenZumaView()
                }
            } else {
                LocationView()
            }
        }
        .onAppear {
            currentUser.listen()
        }
        .onTapGesture { self.hideKeyboard() }

    }
}


struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView()
    }
}

