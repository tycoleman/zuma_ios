
import SwiftUI
import FirebaseAuth


let countryCodes = [
    "+61 Australia",
    "+1 Bahamas",
    "+1 Barbados",
    "+1 Canada",
    "+1 649 Turks and Caicos",
    "+353 Ireland",
    "+1 Jamaica",
    "+64 New Zealand",
    "+234 Nigeria",
    "+92 Pakistan",
    "+63 Philippines",
    "+27 South Africa",
    "+1 Trinidad and Tobago",
    "+44 United Kingdom",
    "+1 United States",
    "+1 340 US Virgin Islands",
    "+263 Zimbabwe"
]

struct PhoneView: View {
    @State private var countryCode: String = "US  +1"
    @State private var phoneNumber = ""
    @State private var isEditing: Bool = false

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var currentUser : CurrentUserViewModel
    @State private var navigate = false

    @State var showErrorMessage = false
    @State var errorMessage = ""
    
    @State private var selectedCountryCode = "+1"
    @State var showCountryCodeSheet = false
    
    
    func formatErrorMessage(rawError: Error?) {
        guard let error = rawError else {
            errorMessage = "An unknown error occurred."
            showErrorMessage = true
            return
        }
        
        let errorDescription = error.localizedDescription
        
        if errorDescription.contains("INVALID_PHONE_NUMBER") {
            errorMessage = "The phone number is invalid. Please ensure you have entered the correct country code and number."
        } else if errorDescription.contains("TOO_SHORT") {
            errorMessage = "The phone number is too short. Please enter a valid number."
        } else if errorDescription.contains("TOO_LONG") {
            errorMessage = "The phone number is too long. Please enter a valid number."
        } else {
            errorMessage = "An error occurred: \(errorDescription)"
        }
        
        showErrorMessage = true
    }
    
    var body: some View {
        VStack {
            VStack {
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image("backArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36)
                        Spacer()
                    }
                    .padding(.top, 70)
                }
                .navigationTitle("")
                .navigationBarHidden(true)


                
                VStack(alignment : .leading) {
                    Text("What's your number?")
                        .font(.custom("LexendMega-Bold", size : 25))
                        .tracking(-3.0)
                        .padding(.top, 40)
                    
                    Text("We protect our community by making sure everyone on Zuma is real. We never share this with anyone and it won’t be on your profile.")
                        .font(.custom("LexendMega-Regular", size : 12))
                        .tracking(-2.0)
                        .padding(.vertical, 15)
                        .padding(.bottom, 15)
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame(width : 77, height : 55)
                                .offset(x : 4, y : 3)
                            
                            
                            
                            Button {
                                showCountryCodeSheet = true
                            } label: {
                                Text("\(selectedCountryCode)  ")
                                    .multilineTextAlignment(.center)
                                    .font(.custom("LexendMega-Regular", size : 12))
                                    .tracking(-2.0)
                                    .frame(width : 77, height : 55)
                                    .background(.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.black, lineWidth: 4)
                                    )
                            }
                            .sheet(isPresented: $showCountryCodeSheet) {
                                SheetView(selectedCountryCode: $selectedCountryCode)
                                    .presentationDetents([.height(200)])
                            }
                        }
                        .padding(.trailing, 15)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame(width : 177, height : 55)
                                .offset(x : 4, y : 3)
                            
                            TextField("", text : $phoneNumber, onEditingChanged: { editing in
                                    self.isEditing = editing
                                })
                                .placeholder(when: phoneNumber.isEmpty && !isEditing) {
                                    Text("Phone number").foregroundColor(Color("Gray"))
                                }
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                                .font(.custom("LexendMega-Medium", size : 14))
                                .tracking(-2.0)
                                .padding(.leading, 15)
                                .frame(width : 177, height : 55)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                                .keyboardType(.numberPad)
                        }
                    }
                }

                
                Spacer()
                
                HStack(spacing : 0) {
                    
                    
                    VStack(alignment : .leading) {

                        Text("By entering your phone number, you agree to our ")
                            .font(.custom("LexendMega-Regular", size : 10))
                            .tracking(-1.5)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        HStack(spacing : 0) {
                            Link("Terms of Service", destination : URL(string : "https://www.clubzuma.com/terms")!)
                                .foregroundColor(.black)
                                .font(.custom("LexendMega-Bold", size : 10))
                                .tracking(-1.5)

                            Text(" and ")
                                .foregroundColor(.black)
                                .font(.custom("LexendMega-Regular", size : 10))
                                .tracking(-1.5)


                            Link("Privacy Policy", destination : URL(string : "https://www.clubzuma.com/privacy")!)
                                .underline()
                                .foregroundColor(.black)
                                .font(.custom("LexendMega-Bold", size : 10))
                                .tracking(-1.5)

                        }
                        .padding(.bottom)
                    }
                    
                    Spacer()
                    
                    Button {
                        currentUser.phoneNumber = "\(selectedCountryCode)\(self.phoneNumber)"
                        
                        print(currentUser.phoneNumber)
                        PhoneAuthProvider.provider()
                            .verifyPhoneNumber("\(selectedCountryCode)\(self.phoneNumber)", uiDelegate: nil) { verificationID, error in
                                  if let error = error {
                                      print(error.localizedDescription)
                                      print(error)
                                      formatErrorMessage(rawError: error)
                                      return
                                  }
                                  // Sign in using the verificationID and the code sent to the user
                                  // ...
                                navigate = true
                                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                          }

                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(.black)
                                .frame(width : 68, height : 68)
                                .offset(x : 3, y : 3)
                            
                            RoundedRectangle(cornerRadius: 100)
                                .fill( self.phoneNumber == "" ? Color("LightGray") : Color("Yellow"))
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
                    .alert(errorMessage, isPresented: $showErrorMessage) {
                        Button("OK", role: .cancel) { }
                    }
                    
                    NavigationLink(destination: ConfirmPhoneView(), isActive: $navigate) {
                        EmptyView()
                    }
                }
                
                Spacer().frame(height: 50)

            }
            .padding(.vertical)
            .padding(.horizontal, 20)

        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}


struct SheetView: View {
    @Binding var selectedCountryCode: String
    @State private var selectedCountryCodeIndex: Int = 0

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    func extractCountryCode(from string: String) -> String {
        if let range = string.range(of: " ") {
            return String(string[..<range.lowerBound])
        }
        return string
    }
    
    var body: some View {
        VStack {
            Picker("Select a country code", selection: $selectedCountryCodeIndex) {
                ForEach(0..<countryCodes.count) { index in
                    Text(countryCodes[index]).tag(index)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .onAppear {
                if let index = countryCodes.firstIndex(of: selectedCountryCode) {
                    selectedCountryCodeIndex = index
                }
            }
            .onChange(of: selectedCountryCodeIndex) { newIndex in
                selectedCountryCode = extractCountryCode(from: countryCodes[newIndex])
            }
            
            Spacer()

            Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}






struct PhoneView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneView()
    }
}
