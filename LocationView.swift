//
//  LocationView.swift
//  Zuma
//
//  Created by Adrian Martushev on 5/28/23.
//

import SwiftUI
import CoreLocation
import FirebaseAuth

struct LocationView: View {
    
    @EnvironmentObject var currentUser : CurrentUserViewModel
    
    @State private var currentLocation: CLLocationCoordinate2D?
    @State private var navigate = false
    
    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }
    
    
    func loadLocation() {
        let service = LocationService.shared
        service.authorizationCallback = { status in
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                // We don't navigate yet, we wait for a location update.
                print("Location authorized.")
            case .notDetermined:
                // We don't navigate yet, we wait for the user's response.
                print("Waiting for user authorization response.")
            default:
                // If authorization failed, we navigate anyway.
                DispatchQueue.main.async {
                    self.navigate = true
                }
            }
        }
        service.locationUpdateCallback = { location in
            currentUser.lat = location.latitude
            currentUser.lng = location.longitude

            DispatchQueue.main.async {
                self.navigate = true
            }
        }
        service.start()
    }

    
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Spacer().frame(height: 100)
                        .navigationTitle("")
                        .navigationBarHidden(true)
                    
                    HStack {

                        VStack(alignment: .leading) {
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
                                
                                Image("mapPin")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width : 35, height : 35)
                            }
                            .padding(.bottom)
                            
                            Text("Enable Location Services")
                                .font(.custom("LexendMega-SemiBold", size : 25))
                                .tracking(-2.0)
                                .foregroundColor(.black)
      
                            Text("We use your location to match you with local members.")
                                .font(.custom("LexendMega-Regular", size : 11))
                                .tracking(-2.0)
                                .foregroundColor(.black)
                                .padding(.top, 10)
                        }
                        .padding(.leading)
                        
                        Spacer()
                    }

                    
                    Spacer()

                    Button {
                        self.loadLocation()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.black)
                                .frame(width : 300, height : 70)
                                .offset(x : 7, y : 7)

                            Text("Enable Location Services")
                                .font(.custom("LexendMega-Bold", size : 15))
                                .tracking(-2.0)
                                .frame(width : 300, height : 70)
                                .foregroundColor(.black)
                                .background(Color("Yellow"))
                                .cornerRadius(100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                        .stroke(.black, lineWidth: 4)
                                )
                        }
                    }

                    NavigationLink(destination: AllowNotificationsView(), isActive: $navigate) {
                        EmptyView()
                    }
                    
                    


                    
                    Spacer().frame(height: 50)

                }
                .padding()
            }
            .background(Color("BabyBlue"))
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
