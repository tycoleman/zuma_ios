//
//  SubscriptionPlanView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/1/23.
//

import SwiftUI
import StoreKit
import Firebase
import FirebaseCore
import FirebaseAuth

struct SubscriptionPlanView: View {
    @State var productSelected = ""
    @State private var product: Product? = nil

    @StateObject private var purchaseManager = PurchaseManager()

    @State var navigateToZuma = false
    
    @State var errorMessage = ""
    @State var showErrorMessage = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

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
                    .padding(.horizontal)
                }
                .navigationTitle("")
                .navigationBarHidden(true)
                
                
                HStack {
                    Text("Choose your membership plan")
                        .font(.custom("LexendMega-Bold", size : 25))
                        .tracking(-3.0)
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 30)
                .padding(.bottom, 10)


                HStack {
                    Text("Zuma requires all members to select a subscription plan.")
                        .font(.custom("LexendMega-Regular", size : 11))
                        .tracking(-2.0)
                        .padding(.bottom, 30)
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer()
                }
                .padding(.horizontal)


                //Monthly
                
                Group {
                    Button {
                        productSelected = "zuma_monthly"
                        product = purchaseManager.products.first(where: { $0.id == "zuma_monthly" })

                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame(height : 70)
                                .offset(x : 7, y : 7)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(productSelected == "zuma_monthly" ? Color("Yellow") : Color("LightGray"))
                                .frame(height : 70)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                            
                            HStack {
                                VStack(alignment: .leading, spacing : 0 ) {
                                    HStack {
                                        Text("Monthly: $14.99/mo  ")
                                            .font(.custom("LexendMega-Medium", size : 15))
                                            .tracking(-2.0)
                                            .foregroundColor(.black)
                                            .padding(.leading, 15)
                                            .padding(.bottom, 5)
                                        
                                        Spacer()
                                    }
                                }

                                Spacer()
                                if(productSelected == "zuma_monthly") {
                                    Image("checkmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width : 25)
                                        .padding(.trailing, 20)
                                }
                            }
                            .frame( height : 70)

                        }
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal)
                    
                    
                    //Quarterly
                    Button {
                        productSelected = "zuma_quarterly"
                        product = purchaseManager.products.first(where: { $0.id == "zuma_quarterly" })

                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame(height : 70)
                                .offset(x : 7, y : 7)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(productSelected == "zuma_quarterly" ? Color("Yellow") : Color("LightGray"))
                                .frame(height : 70)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                            
                            HStack {
                                VStack(alignment: .leading, spacing : 0 ) {
                                    HStack {
                                        Text("Quarterly: $35.99 / 3 months ")
                                            .font(.custom("LexendMega-Medium", size : 15))
                                            .tracking(-2.0)
                                            .foregroundColor(.black)
                                            .padding(.leading, 15)
                                            .padding(.bottom, 5)
                                        
                                        Spacer()
                                    }

                                    
                                    HStack {
                                        Text("(3 months at $11.99/mo. Save 20%)   ")
                                            .font(.custom("LexendMega-Medium", size : 8))
                                            .tracking(-1.5)
                                            .foregroundColor(.black)
                                            .padding(.leading, 15)
                                        
                                        Spacer()
                                    }
                                }
                                
                                if(productSelected == "zuma_quarterly") {
                                    Image("checkmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width : 25)
                                        .padding(.trailing, 20)
                                }
                            }
                            .frame(height : 70)

                        }
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal)

                    
                    
                    
                    //Yearly
                    Button {
                        productSelected = "zuma_yearly"
                        product = purchaseManager.products.first(where: { $0.id == "zuma_yearly" })

                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .frame(height : 70)
                                .offset(x : 7, y : 7)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(productSelected == "zuma_yearly" ? Color("Yellow") : Color("LightGray"))
                                .frame(height : 70)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 4)
                                )
                            
                            HStack {
                                VStack(alignment: .leading, spacing : 0 ) {
                                    HStack {
                                        Text("Yearly: $119.99 / 12 months ")
                                            .font(.custom("LexendMega-Medium", size : 15))
                                            .tracking(-2.0)
                                            .foregroundColor(.black)
                                            .padding(.leading, 15)
                                            .padding(.bottom, 5)
                                        
                                        Spacer()
                                    }

                                    
                                    HStack {
                                        Text("(12 months at $9.99/mo. Save 33%)  ")
                                            .font(.custom("LexendMega-Medium", size : 8))
                                            .tracking(-1.5)
                                            .foregroundColor(.black)
                                            .padding(.leading, 15)
                                        
                                        Spacer()
                                    }
                                }
                                
                                if(productSelected == "zuma_yearly") {
                                    Image("checkmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width : 25)
                                        .padding(.trailing, 20)
                                }
                            }
                            .frame(height : 70)

                        }
                    }
                    .padding(.horizontal)
                }
                


                
                VStack {
                    VStack {
                        
                        Text("With a subscription you will gain full access to the community, including the ability to meet and chat with other members, for the length of your subscription. You can change or cancel at any time for free. By subscribing, you agree to Zuma's")
                            .font(.custom("LexendMega-Regular", size : 10))
                            .tracking(-2.0)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: 340)
                        
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

                    }
                }
                .padding(.top, 30)


                
                
                Spacer()
                
                HStack {

                    
                    Spacer()
                    
                    
                    Button {
                        
                        if let productSelected = product {
                            Task {
                                do {
                                    print(productSelected)
                                    try await purchaseManager.purchase(productSelected)
                                } catch {
                                    // Handle purchase error here
                                    print("Error purchasing product: \(error)")
                                    self.showErrorMessage = true
                                    self.errorMessage = "There was an issue with your payment. If this problem persists please contact support"
                                }
                            }
                        } else {
                            print("error")
                            self.showErrorMessage = true
                            self.errorMessage = "Please select a membership plan"
                        }

                    } label: {
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
                            
                            Image("chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width : 16, height : 24)
                        }
                    }
                    .alert("\(self.errorMessage)", isPresented: $showErrorMessage) {
                        Button("OK", role: .cancel) { }
                    }
                    
                    NavigationLink(destination: OpenZumaView(), isActive: $navigateToZuma) {
                        EmptyView()
                    }
                    
                }
                
                Spacer().frame(height: 30)

            }
            .padding()
        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
        .task {
            await purchaseManager.updatePurchasedProducts()

            do {
                try await purchaseManager.loadProducts()
            } catch {
                print(error)
            }
        }
    }

}




struct SubscriptionPlanView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionPlanView()
    }
}
