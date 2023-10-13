//
//  TOSView.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/1/23.
//

import SwiftUI

struct TOSView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            VStack {
                HStack {
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
                        .padding(.leading, 15)
                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    
                    Spacer()
                    
                }
                
                ScrollView(.vertical) {
                    TOSSection(title: "Terms of Use", text: """
                                Welcome to Zuma, operated by Zuma Group, LLC (“us,” “we,” the “Company” or “Zuma”). Together you and Zuma may be referred to as the “Parties” or separately as “Party.”
                                
                                ​
                                
                                Notice to California subscribers: You may cancel your subscription, without penalty or obligation, at any time prior to midnight of the third business day following the date you subscribed. If you subscribed using your Apple ID, refunds are handled by Apple, not Zuma. If you wish to request a refund, please visit https://getsupport.apple.com. If you subscribed using your Google Play Store account or through Zuma Online, contact customer support
                                """)
                    
                    
                    TOSSection(title: "1. Acceptance of Terms of Use Agreement", text: """
                                By creating a Zuma account or by using any Zuma service, whether through a mobile device, mobile application or computer (collectively, the “Service”) you agree to be bound by (i) these Terms of Use, (ii) our Privacy Policy, Cookie Policy, Safety Tips, and Community Guidelines, each of which is incorporated by reference into this Agreement, and (iii) any terms disclosed to you if you purchase or have purchased additional features, products or services we offer on the Service (collectively, this “Agreement”). If you do not accept and agree to be bound by all of the terms of this Agreement, you should not access or use the Service.

                                 

                                PLEASE CAREFULLY REVIEW THE DISPUTE RESOLUTION PROVISIONS IN SECTION 15 BELOW. THESE GOVERN THE MANNER IN WHICH CLAIMS WILL BE ADDRESSED BETWEEN YOU AND ZUMA. THESE PROVISIONS INCLUDE A MANDATORY PRE-ARBITRATION INFORMAL DISPUTE RESOLUTION PROCESS, AN ARBITRATION AGREEMENT, SMALL CLAIMS COURT ELECTION, CLASS ACTION WAIVER, ADDITIONAL PROCEDURES FOR MASS ARBITRATION FILINGS, AND JURY TRIAL WAIVER THAT AFFECT YOUR RIGHTS. IN ARBITRATION, THERE IS TYPICALLY LESS DISCOVERY AND APPELLATE REVIEW THAN IN COURT.

                                 

                                We may make changes to this Agreement and to the Service from time to time. We may do this for a variety of reasons including to reflect changes in or requirements of the law, new features, or changes in business practices. The most recent version of this Agreement will be posted on the Service under Settings and also on clubzuma.com, and you should regularly check for the most recent version. The most recent version is the version that applies. If the changes include material changes to your rights or obligations, we will notify you in advance of the changes (unless we’re unable to do so under applicable law) by reasonable means, which could include notification through the Service or via email. If you continue to use the Service after the changes become effective, then you agree to the revised Agreement. You agree that this Agreement shall supersede any prior agreements (except as specifically stated herein), and shall govern your entire relationship with Zuma, including but not limited to events, agreements, and conduct preceding your acceptance of this Agreement.
                                """)
                    
                        TOSSection(title: "2. Eligibility", text: """
                                    You must be at least 18 years of age to create an account on Zuma and use the Service. By creating an account and using the Service, you represent and warrant that:

                                     

                                    • you can form a binding contract with Zuma,

                                    • you are not a person who is barred from using the Service under the laws of the United States or any other applicable jurisdiction (for example, you do not appear on the U.S. Treasury Department’s list of Specially Designated Nationals or face any other similar prohibition),

                                    • you will comply with this Agreement and all applicable local, state, national and international laws, rules and regulations, including without limitation, privacy laws, intellectual property laws, anti-spam laws, and regulatory requirements,

                                    • you have not committed, been convicted of, or pled no contest to a felony, a sex crime, or any crime involving violence or a threat of violence, unless you have received clemency for a non-violent crime and we have determined that you are not likely to pose a threat to other users of our Service, and that you are not required to register as a sex offender with any state, federal or local sex offender registry,

                                    • you will use the latest version of the Service (via app or website),

                                    • you do not have more than one account on the Service, and

                                    • you have not previously been removed from the Service by us, unless you have our express written permission to create a new account.

                                    ​

                                    If at any time you cease to meet these requirements, all authorization to access our Service or systems is automatically revoked, and you must immediately delete your account.
                                    """)
                        
                        TOSSection(title: "3. Your Account", text: """
                                    In order to use Zuma, you may sign in by telephone number only. For more information regarding the information we collect from you and how we use it, please consult our Privacy Policy.

                                     

                                    You are responsible for maintaining the confidentiality of your login credentials you use to sign up for Zuma, and you are solely responsible for all activities that occur under those credentials. If you think someone has gained access to your account, please immediately contact us.
                                    """)
                    
                        TOSSection(title: "4. Modifying the Service and Termination.", text: """
                                    Zuma is always striving to improve the Service and bring you additional functionality that you will find engaging and useful. This means we may add new product features or enhancements from time to time as well as remove some features, and if these actions do not materially affect your rights or obligations, we may not provide you with notice before taking them. We may even suspend the Service entirely, in which event we will notify you in advance unless extenuating circumstances, such as safety or security concerns, prevent us from doing so.

                                    ​

                                    You may terminate your account at any time, for any reason, by following the instructions in “Settings” in the Service. However, if you use a third party payment account such as Apple’s App Store or iTunes Store, as applicable or the Google Play Store, you will need to manage in app purchases through such an account to avoid additional billing.

                                    ​

                                    Zuma may terminate your account at any time without notice if it believes that you have violated this Agreement. Upon such termination, you will not be entitled to any refund for purchases. After your account is terminated, this Agreement will terminate, except that the following provisions will still apply to you and Zuma: Section 4, Section 5, and Sections 12 through 19.
                                    """)
                    
                    TOSSection(title: "5. Safety; Your Interactions with Other Members", text: """
                                You agree to treat other users in a courteous and respectful manner, both on and off our Services and to be respectful when communicating with any of our customer care representatives or other employees. Though Zuma strives to encourage a respectful member experience through features like the double opt-in that allows members to communicate only after they have both indicated interest in one another, Zuma is not responsible for the conduct of any member on or off of the Service. You agree to use caution in all interactions with other members, particularly if you decide to communicate off the Service or meet in person. In addition, you agree to review and follow Zuma’s Safety Tips prior to using the Service. You agree that you will not provide your financial information (for example, your credit card or bank account information), or wire or otherwise send money to other members.

                                 

                                YOU ARE SOLELY RESPONSIBLE FOR YOUR INTERACTIONS WITH OTHER MEMBERS. YOU UNDERSTAND THAT ZUMA DOES NOT CONDUCT CRIMINAL BACKGROUND CHECKS ON ITS MEMBERS OR OTHERWISE INQUIRE INTO THE BACKGROUND OF ITS MEMBERS. ZUMA MAKES NO REPRESENTATIONS OR WARRANTIES AS TO THE CONDUCT OR COMPATIBILITY OF MEMBERS. ZUMA RESERVES THE RIGHT TO CONDUCT – AND YOU AUTHORIZE ZUMA TO CONDUCT – ANY CRIMINAL BACKGROUND CHECK OR OTHER SCREENINGS (SUCH AS SEX OFFENDER REGISTER SEARCHES) AT ANY TIME USING AVAILABLE PUBLIC RECORDS OBTAINED BY IT OR WITH THE ASSISTANCE OF A CONSUMER REPORTING AGENCY, AND YOU AGREE THAT ANY INFORMATION YOU PROVIDE MAY BE USED FOR THAT PURPOSE.
                                """)
                    
                    TOSSection(title: "6. Rights Zuma Grants You.", text: """
                                Zuma grants you a personal, worldwide, royalty-free, non-assignable, non-exclusive, revocable, and non-sublicensable license to access and use the Service. This license is for the sole purpose of letting you use and enjoy the Service’s benefits as intended by Zuma and permitted by this Agreement. This license and any authorization to access the Service are automatically revoked in the event that you do any of the following:

                                 

                                • use the Service or any content contained in the Service for any commercial purposes without our written consent.

                                • copy, modify, transmit, create any derivative works from, make use of, or reproduce in any way any copyrighted material, images, trademarks, trade names, service marks, or other intellectual property, content or proprietary information accessible through the Service without Zuma’s prior written consent.

                                • express or imply that any statements you make are endorsed by Zuma.

                                • use any robot, bot, spider, crawler, scraper, site search/retrieval application, proxy or other manual or automatic device, method or process to access, retrieve, index, “data mine,” or in any way reproduce or circumvent the navigational structure or presentation of the Service or its contents.

                                • use the Service in any way that could interfere with, disrupt or negatively affect the Service or the servers or networks connected to the Service.

                                • upload viruses or other malicious code or otherwise compromise the security of the Service.

                                • forge headers or otherwise manipulate identifiers in order to disguise the origin of any information transmitted to or through the Service.

                                • “frame” or “mirror” any part of the Service without Zuma’s prior written authorization.

                                • use meta tags or code or other devices containing any reference to Zuma or the Service (or any trademark, trade name, service mark, logo or slogan of Zuma) to direct any person to any other website for any purpose.

                                • modify, adapt, sublicense, translate, sell, reverse engineer, decipher, decompile or otherwise disassemble any portion of the Service, or cause others to do so.

                                • use or develop any third-party applications that interact with the Service or other members’ Content or information without our written consent.

                                • use, access, or publish the Zuma application programming interface without our written consent.

                                • probe, scan or test the vulnerability of our Service or any system or network.

                                • encourage, promote, or agree to engage in any activity that violates this Agreement.

                                 

                                Zuma may investigate and take any available legal action in response to illegal and / or unauthorized uses of the Service, including termination of your account.

                                 

                                Any software that we provide you may automatically download and install upgrades, updates, or other new features. You may be able to adjust these automatic downloads through your device’s settings.
                                """)
                    
                    TOSSection(title: "7. Rights You Grant Zuma", text: """
                                By creating an account, you grant to Zuma a worldwide, transferable, sub-licensable, royalty-free, right and license to host, store, use, copy, display, reproduce, adapt, edit, publish, modify, reformat, incorporate into other works, advertise, distribute, and otherwise make available to the general public information you authorize us to access from third parties such as Facebook, Google, or Apple, as well as any information you post, upload, display or otherwise make available (collectively, “post”) on the Service or transmit to other members (collectively, “Content”). Zuma’s license to your Content shall be non-exclusive, except that Zuma’s license shall be exclusive with respect to derivative works created through use of the Service. For example, Zuma would have an exclusive license to screenshots of the Service that include your Content. In addition, so that Zuma can prevent the use of your Content outside of the Service, you authorize Zuma to act on your behalf with respect to infringing uses of your Content taken from the Service by other members or third parties. This expressly includes the authority, but not the obligation, to send notices pursuant to 17 U.S.C. § 512(c)(3) (i.e., DMCA Takedown Notices) on your behalf if your Content is taken and used by third parties outside of the Service. Our license to your Content is subject to your rights under applicable law (for example laws regarding personal data protection to the extent any Content contains personal information as defined by those laws) and is for the limited purpose of operating, developing, providing, and improving the Service and researching and developing new ones. You agree that any Content you place or that you authorize us to place on the Service may be viewed by other members and may be viewed by any person visiting or participating in the Service (such as individuals who may receive shared Content from other Zuma members).

                                ​

                                You agree that all information that you submit upon creation of your account, including information submitted from your Facebook account, is accurate and truthful and you have the right to post the Content on the Service and grant the license to Zuma above.

                                 

                                You understand and agree that we may monitor or review any Content you post as part of the Service. We may delete any Content, in whole or in part, that in our sole judgment violates this Agreement or may harm the reputation of the Service.

                                 

                                When communicating with our customer care representatives, you agree to be respectful and kind. If we feel that your behavior towards any of our customer care representatives or other employees is at any time threatening, harassing, or offensive, we reserve the right to immediately terminate your account.

                                ​

                                In consideration for Zuma allowing you to use the Service, you agree that we, our affiliates, and our third-party partners may place advertising on the Service. By submitting suggestions or feedback to Zuma regarding our Service, you agree that Zuma may use and share such feedback for any purpose without compensating you.

                                 

                                You agree that Zuma may access, store, and disclose your account information and Content if required to do so by law, by performing its agreement with you, or in a good faith belief that such access, storage or disclosure satisfies a legitimate interest, including to: (i) comply with legal process; (ii) enforce the Agreement; (iii) respond to claims that any Content violates the rights of third parties; (iv) respond to your requests for customer service; or (v) protect the rights, property or personal safety of the Company or any other person.
                                """)
                    
                    TOSSection(title: "8. Community Rules", text: """
                                By using the Service, you agree that you will not:

                                 

                                • use the Service for any purpose that is illegal or prohibited by this Agreement.

                                • use the Service for any harmful or nefarious purpose.

                                • use the Service in order to damage Zuma.

                                • violate our Community Guidelines, as updated from time to time.

                                • spam or solicit money or other items of value from another member, whether as a gift, loan, or other form of compensation, or otherwise defraud any members.

                                • impersonate any person or entity or post any images of another person without his or her permission.

                                • bully, “stalk,” intimidate, assault, harass, mistreat or defame, or otherwise mistreat any person.

                                • post any Content that violates or infringes anyone’s rights, including rights of publicity, privacy, copyright, trademark or other intellectual property or contract right.

                                • post any Content that is hate speech, threatening, sexually explicit or pornographic; incites violence; or contains nudity or graphic or gratuitous violence.

                                • post any Content that promotes racism, bigotry, hatred or physical harm of any kind against any group or individual.

                                • solicit passwords for any purpose, or personal identifying information for commercial or unlawful purposes from other users or disseminate another person’s personal information without his or her permission.

                                • use another user’s account, share an account with another user, or maintain more than one account.

                                • misrepresent your identity, age, current or previous positions, qualifications, or affiliations with a person or entity.

                                • create another account if we have already terminated your account, unless you have our permission.

                                ​

                                Zuma reserves the right to investigate and/or terminate your account without a refund of any purchases if you have violated this Agreement, misused the Service or behaved in a way that Zuma regards as inappropriate or unlawful, including actions or communications that occur on or off the Service. In addition, in certain instances, we may terminate your account for violating the applicable terms of Zuma. In the event that you violate these rules or our Community Guidelines, your authorization to use the Service will be automatically revoked.
                                """)
                    
                    TOSSection(title: "9. Other Member's Content", text: """
                                Although Zuma reserves the right to review and remove Content that violates this Agreement, such Content is the sole responsibility of the member who posts it, and Zuma cannot guarantee that all Content will comply with this Agreement. If you see Content on the Service that violates this Agreement, please report it within the Service or via our contact form.
                                """)
                    
                    TOSSection(title: "10. Purchases", text: """
                                Generally. From time to time, Zuma may offer products and services for purchase (“in app purchases”) through the App Store, Google Play Store, carrier billing, Zuma direct billing or other payment platforms authorized by Zuma. If you choose to make an in app purchase, you will be prompted to confirm your purchase with the applicable payment provider, and your method of payment (be it your card or a third party account such as Google Play Store or the App Store) (your “Payment Method”) will be charged for the in app purchase at the prices displayed to you for the service(s) you’ve selected as well as any sales or similar taxes that may be imposed on your payments, and you authorize Zuma or the third party account, as applicable, to charge you.

                                ​

                                Auto-Renewal. If you purchase an auto-recurring periodic subscription through an in app purchase, your Payment Method will continue to be billed for the subscription until you cancel. After your initial subscription commitment period, and again after any subsequent subscription period, your subscription will automatically continue for an additional equivalent period, at the price you agreed to when subscribing. Your card payment information will be stored and subsequently used for the automatic card payments in accordance with the Agreement.

                                ​

                                If you do not wish your subscription to renew automatically, or if you want to change or terminate your subscription, you will need to log in to your third party account (or Settings on Zuma, if applicable) and follow the instructions to terminate or cancel your subscription, even if you have otherwise deleted your account with us or if you have deleted the Zuma application from your device. Deleting your account on Zuma or deleting the Zuma application from your device does not terminate or cancel your subscription; Zuma will retain all funds charged to your Payment Method until you terminate or cancel your subscription on Zuma or the third party account, as applicable. If you terminate or cancel your subscription, you may use your subscription until the end of your then-current subscription term, and your subscription will not be renewed after your then-current term expires.

                                ​

                                Additional Terms that apply if you pay Zuma directly with your Payment Method. If you pay Zuma directly, Zuma may correct any billing errors or mistakes that it makes even if it has already requested or received payment. If you initiate a chargeback or otherwise reverse a payment made with your Payment Method, Zuma may terminate your account immediately in its sole discretion.

                                ​

                                You may edit your Payment Method information by visiting Zuma and going to Settings. If a payment is not successfully settled, due to expiration, insufficient funds, or otherwise, and you do not edit your Payment Method information, terminate or cancel your subscription, you remain responsible for any uncollected amounts and authorize us to continue billing the Payment Method, as it may be updated. This may result in a change to your payment billing dates. In addition, you authorize us to obtain updated or replacement expiration dates and card numbers for your credit or debit card as provided by your credit or debit card issuer. The terms of your payment will be based on your Payment Method and may be determined by agreements between you and the financial institution, credit card issuer or other provider of your chosen Payment Method. If you reside outside of the Americas, you agree that your payment to Zuma will be through MTCH Technology Services Limited.

                                ​

                                Virtual Items. From time to time, you may be able to purchase, earn, or be granted a limited, personal, non-transferable, non-sublicensable, revocable license to use “virtual items,” which could include virtual products or virtual “coins” or other units that are exchangeable within the Service for virtual products (collectively, “Virtual Items”). Any Virtual Item balance shown in your account does not constitute a real-world balance or reflect any stored value, but instead constitutes a measurement of the extent of your license. Virtual Items do not incur fees for non-use, however, the license granted to you in Virtual Items will terminate in accordance with the terms of this Agreement, when Zuma ceases providing the Service, or your account is otherwise closed or terminated. Zuma, in its sole discretion, reserves the right to charge fees for the right to access or use Virtual Items and may distribute Virtual Items with or without charge. Zuma may manage, regulate, control, modify or eliminate Virtual Items at any time. Zuma shall have no liability to you or any third party in the event that Zuma exercises any such rights. Virtual Items may only be redeemed through the Service. ALL PURCHASES AND REDEMPTIONS OF VIRTUAL ITEMS MADE THROUGH THE SERVICE ARE FINAL AND NON-REFUNDABLE. The provision of Virtual Items for use in the Service is a service that commences immediately upon the acceptance of your purchase of such Virtual Items. YOU ACKNOWLEDGE THAT ZUMA IS NOT REQUIRED TO PROVIDE A REFUND IN RESPECT OF VIRTUAL ITEMS FOR ANY REASON, AND THAT YOU WILL NOT RECEIVE MONEY OR OTHER COMPENSATION FOR UNUSED VIRTUAL ITEMS WHEN AN ACCOUNT IS CLOSED, WHETHER SUCH CLOSURE WAS VOLUNTARY OR INVOLUNTARY.

                                ​

                                Refunds. Generally, all charges for purchases are nonrefundable, and there are no refunds or credits for partially used periods. We may make an exception if a refund for a subscription offering is requested within fourteen days of the transaction date, or if the laws applicable in your jurisdiction provide for refunds.

                                ​

                                For subscribers residing in Arizona, California, Colorado, Connecticut, Illinois, Iowa, Minnesota, New York, North Carolina, Ohio and Wisconsin, the terms below apply:

                                 

                                You may cancel your subscription, without penalty or obligation, at any time prior to midnight of the third business day following the date you subscribed. In the event that you die before the end of your subscription period, your estate shall be entitled to a refund of that portion of any payment you had made for your subscription, which is allocable to the period after your death. In the event that you become disabled (such that you are unable to use the services of Zuma) before the end of your subscription period, you shall be entitled to a refund of that portion of any payment you had made for your subscription, which is allocable to the period after your disability by providing the company notice in the same manner as you request a refund as described below. Purchases of Virtual Items are FINAL AND NON-REFUNDABLE.

                                 

                                To request a refund:

                                If you made a purchase using your Apple ID, refunds are handled by Apple, not Zuma. To request a refund, go to the App Store, click on your Apple ID, select “Purchase history,” find the transaction and hit “Report Problem”. You can also submit a request at https://getsupport.apple.com.
                                 

                                If you subscribed using your Google Play Store account or through Zuma directly: please contact customer support with your order number for the Google Play Store (you can find the order number in the order confirmation email or by logging in to Google Wallet) or Zuma (you can find this on your confirmation email). You may also mail or deliver a signed and dated notice which states that you, the buyer, are canceling this Agreement, or words of similar effect. Please also include the email address or mobile number associated with your account along with your order number. This notice shall be sent to: Zuma, Attn: Cancellations, P.O. Box 25472, Dallas, Texas 75225, USA (in addition, Ohio members may send a facsimile to 214-853-4309).

                                 

                                Pricing. Zuma operates a global business, and our pricing varies by a number of factors. We frequently offer promotional rates - which can vary based on region, length of subscription, bundle size and more. We also regularly test new features and payment options.
                                """)
                    
                    TOSSection(title: "11. Notice of Procedure for Making Claims of Copyright Infringement", text: """
                                If you believe that your work has been copied and posted on the Service in a way that constitutes copyright infringement, please submit a takedown request using the form here.

                                 

                                If you contact us regarding alleged copyright infringement, please be sure to include the following information:

                                 

                                • an electronic or physical signature of the person authorized to act on behalf of the owner of the copyright interest;

                                • a description of the copyrighted work that you claim has been infringed;

                                • a description of where the material that you claim is infringing is located on the Service (and such description must be reasonably sufficient to enable us to find the alleged infringing material);

                                • your contact information, including address, telephone number and email address, and the copyright owner’s identity;

                                • a written statement by you that you have a good faith belief that the disputed use is not authorized by the copyright owner, its agent, or the law; and

                                • a statement by you, made under penalty of perjury, that the above information in your notice is accurate and that you are the copyright owner or authorized to act on the copyright owner’s behalf.

                                 

                                Zuma will terminate the accounts of repeat infringers.
                                """)
                    
                    TOSSection(title: "12. Disclaimers", text: """
                                ZUMA PROVIDES THE SERVICE ON AN “AS IS” AND “AS AVAILABLE” BASIS AND TO THE EXTENT PERMITTED BY APPLICABLE LAW, GRANTS NO WARRANTIES OF ANY KIND, WHETHER EXPRESS, IMPLIED, STATUTORY OR OTHERWISE WITH RESPECT TO THE SERVICE (INCLUDING ALL CONTENT CONTAINED THEREIN), INCLUDING, WITHOUT LIMITATION, ANY IMPLIED WARRANTIES OF SATISFACTORY QUALITY, MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT. ZUMA DOES NOT REPRESENT OR WARRANT THAT (A) THE SERVICE WILL BE UNINTERRUPTED, SECURE OR ERROR FREE, (B) ANY DEFECTS OR ERRORS IN THE SERVICE WILL BE DISCOVERED OR CORRECTED, OR (C) THAT ANY CONTENT OR INFORMATION YOU OBTAIN ON OR THROUGH THE SERVICE WILL BE ACCURATE, OR APPROPRIATE FOR YOUR PURPOSES.

                                 

                                ZUMA ASSUMES NO RESPONSIBILITY FOR ANY CONTENT THAT YOU OR ANOTHER MEMBER OR THIRD PARTY POSTS, SENDS OR RECEIVES THROUGH THE SERVICE. ANY MATERIAL DOWNLOADED OR OTHERWISE OBTAINED THROUGH THE USE OF THE SERVICE IS ACCESSED AT YOUR OWN DISCRETION AND RISK.

                                 

                                ZUMA DISCLAIMS AND ASSUMES NO RESPONSIBILITY FOR ANY CONDUCT OF YOU OR ANY OTHER MEMBER, ON OR OFF THE SERVICE.
                                """)
                    
                    TOSSection(title: "13. Third Party Services", text: """
                                The Service may contain advertisements and promotions offered by third parties and links to other web sites or resources. Zuma is not responsible for the availability (or lack of availability) of such external websites or resources. If you choose to interact with the third parties made available through our Service, such party’s terms will govern their relationship with you. Zuma is not responsible or liable for such third parties’ terms or actions.
                                """)
                    
                    TOSSection(title: "14. Limitation of Liability", text: """
                                TO THE FULLEST EXTENT PERMITTED BY APPLICABLE LAW, IN NO EVENT SHALL ZUMA, ITS AFFILIATES, EMPLOYEES, LICENSORS OR SERVICE PROVIDERS BE LIABLE FOR ANY INDIRECT, CONSEQUENTIAL, EXEMPLARY, INCIDENTAL, SPECIAL, PUNITIVE, FIXED, OR ENHANCED DAMAGES, INCLUDING, WITHOUT LIMITATION, LOSS OF PROFITS, WHETHER INCURRED DIRECTLY OR INDIRECTLY, OR ANY LOSS OF DATA, USE, GOODWILL, OR OTHER INTANGIBLE LOSSES, RESULTING FROM: (I) YOUR ACCESS TO OR USE OF OR INABILITY TO ACCESS OR USE THE SERVICE; (II) THE CONDUCT OR CONTENT OF ANY MEMBERS OR THIRD PARTIES ON OR THROUGH ANY OF OUR WEBSITES OR IN CONNECTION WITH THE SERVICE; OR (III) ANY UNAUTHORIZED ACCESS, USE OR ALTERATION OF YOUR CONTENT, EVEN IF ZUMA HAS BEEN ADVISED AT ANY TIME OF THE POSSIBILITY OF SUCH DAMAGES. TO THE FULLEST EXTENT PERMITTED BY APPLICABLE LAW, IN NO EVENT SHALL ZUMA’S AGGREGATE LIABILITY TO YOU FOR ANY AND ALL CLAIMS ARISING OUT OF OR RELATING TO THE SERVICE OR THIS AGREEMENT EXCEED THE AMOUNT PAID, IF ANY, BY YOU TO ZUMA DURING THE TWENTY-FOUR (24) MONTH PERIOD IMMEDIATELY PRECEDING THE DATE THAT YOU FIRST FILE A LAWSUIT, ARBITRATION OR ANY OTHER LEGAL PROCEEDING AGAINST ZUMA, WHETHER IN LAW OR IN EQUITY, IN ANY TRIBUNAL. THE DAMAGES LIMITATION SET FORTH IN THE IMMEDIATELY PRECEDING SENTENCE APPLIES (i) REGARDLESS OF THE GROUND UPON WHICH LIABILITY IS BASED (WHETHER DEFAULT, CONTRACT, TORT, STATUTE, OR OTHERWISE), (ii) IRRESPECTIVE OF THE TYPE OF BREACH OF OBLIGATIONS, AND (iii) WITH RESPECT TO ALL EVENTS, THE SERVICE, AND THIS AGREEMENT.

                                 

                                THE LIMITATION OF LIABILITY PROVISIONS SET FORTH IN THIS SECTION 14 SHALL APPLY EVEN IF YOUR REMEDIES UNDER THIS AGREEMENT FAIL WITH RESPECT TO THEIR ESSENTIAL PURPOSE.

                                 

                                SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OR LIMITATION OF CERTAIN DAMAGES, SO SOME OR ALL OF THE EXCLUSIONS AND LIMITATIONS IN THIS SECTION MAY NOT APPLY TO YOU.
                                """)
                    
                    TOSSection(title: "15. Dispute Resolution Section", text: """
                                In the unlikely event that we have a legal dispute, here is how the Parties agree to proceed, except where prohibited by applicable law.

                                 

                                Any Subsection in this Dispute Resolution Section that is prohibited by law shall not apply to the users residing in that jurisdiction.

                                 

                                15a. INFORMAL DISPUTE RESOLUTION PROCESS

                                 

                                If you are dissatisfied with our Service for any reason, please contact Zuma Customer Service first so we can try to resolve your concerns without the need of outside assistance. If you choose to pursue a dispute, claim or controversy against Zuma, these terms will apply. For purposes of this Dispute Resolution Process and Arbitration Procedures set forth in Section 15, “Zuma” shall include our affiliates, employees, licensors, and service providers.

                                 

                                Zuma values its relationship with you and appreciates the mutual benefit realized from informally resolving Disputes (as defined below). Before formally pursuing a Dispute in arbitration or small claims court, you agree to first send a detailed notice (“Notice”) to Zuma Group Legal, P.O. Box 25458, Dallas, Texas 75225, USA. If Zuma has a Dispute with you, Zuma agrees to first send a Notice to you at your most recent email address on file with us, or, if no email address is on file, other contact information associated with your account. Your Notice must contain all of the following information: (1) your full name; (2) information that enables Zuma to identify your account, including a picture or screenshot of your profile, your address, mobile phone number, email address, and date of birth you used to register your account if any; and (3) a detailed description of your Dispute, including the nature and factual basis of your claim(s) and the relief you are seeking with a corresponding calculation of your alleged damages (if any). You must personally sign this Notice for it to be effective. Zuma’s Notice must likewise set forth a detailed description of its Dispute, which shall include the nature and factual basis of its claim(s) and the relief it is seeking, with a corresponding calculation of our damages (if any). You and Zuma agree to then negotiate in good faith in an effort to resolve the Dispute. As part of these good faith negotiations, if Zuma requests a telephone conference with you to discuss your Dispute, you agree to personally participate, with your attorney if you’re represented by counsel. Likewise, if you request a telephone conference to discuss Zuma’s Dispute with you, Zuma agrees to have one representative participate. This informal process should lead to a resolution of the Dispute. However, if the Dispute is not resolved within 60 days after receipt of a fully completed Notice and the Parties have not otherwise mutually agreed to an extension of this informal dispute resolution time period, you or Zuma may initiate an arbitration (subject to a Party’s right to elect small claims court as provided below).

                                Completion of this informal dispute resolution is a condition precedent to filing any demand for arbitration or small claims court action. Failure to do so is a breach of this Agreement. The statute of limitations and any filing fee deadlines will be tolled while you and Zuma engage in this informal dispute resolution process. Unless prohibited by applicable law, the arbitration provider, National Arbitration and Mediation (“NAM”), shall not accept or administer any demand for arbitration and shall administratively close any arbitration unless the Party bringing such demand for arbitration can certify in writing that the terms and conditions of this informal dispute resolution process were fully satisfied. A court of competent jurisdiction shall have authority to enforce this provision and to enjoin any arbitration proceeding or small claims court action.

                                 

                                15b. INDIVIDUAL RELIEF: CLASS ACTION AND JURY TRIAL WAIVER

                                 

                                TO THE FULLEST EXTENT ALLOWABLE BY LAW, YOU AND ZUMA EACH WAIVE THE RIGHT TO A JURY TRIAL AND THE RIGHT TO LITIGATE DISPUTES IN COURT IN FAVOR OF INDIVIDUAL ARBITRATION (EXCEPT FOR SMALL CLAIMS COURT AS PROVIDED ABOVE). YOU AND ZUMA EACH WAIVE THE RIGHT TO FILE OR PARTICIPATE IN A CLASS ACTION AGAINST THE OTHER OR OTHERWISE TO SEEK RELIEF ON A CLASS BASIS, INCLUDING ANY CURRENTLY PENDING ACTIONS AGAINST ZUMA. TO THE FULLEST EXTENT ALLOWABLE BY LAW, THERE SHALL BE NO RIGHT OR AUTHORITY FOR ANY CLAIMS TO BE ARBITRATED OR LITIGATED ON A CLASS, COLLECTIVE, REPRESENTATIVE, CONSOLIDATED, OR PRIVATE ATTORNEY GENERAL BASIS. THE ARBITRATOR CAN AWARD THE SAME RELIEF AVAILABLE IN COURT PROVIDED THAT THE ARBITRATOR MAY ONLY AWARD FINAL RELIEF (INCLUDING INJUNCTIVE OR DECLARATORY RELIEF) IN FAVOR OF THE INDIVIDUAL PARTY SEEKING RELIEF AND ONLY TO THE EXTENT NECESSARY TO PROVIDE FINAL RELIEF WARRANTED BY THAT INDIVIDUAL PARTY’S CLAIM. THE ARBITRATOR MAY NOT AWARD FINAL RELIEF FOR, AGAINST, OR ON BEHALF OF ANYONE WHO IS NOT A PARTY TO THE ARBITRATION ON A CLASS, COLLECTIVE, REPRESENTATIVE, OR PRIVATE ATTORNEY GENERAL BASIS. IF A COURT DETERMINES THAT ANY OF THESE PROHIBITIONS IN THIS PARAGRAPH ARE UNENFORCEABLE AS TO A PARTICULAR CLAIM OR REQUEST FOR RELIEF (SUCH AS A REQUEST FOR PUBLIC INJUNCTIVE RELIEF), AND ALL APPEALS OF THAT DECISION ARE EXHAUSTED OR THE DECISION IS OTHERWISE FINAL, THEN YOU AND ZUMA AGREE THAT THAT PARTICULAR CLAIM OR REQUEST FOR RELIEF SHALL PROCEED IN COURT BUT SHALL BE STAYED PENDING INDIVIDUAL ARBITRATION OF THE REMAINING CLAIMS FOR RELIEF THAT YOU HAVE BROUGHT. IF THIS SPECIFIC PARAGRAPH IS FOUND TO BE UNENFORCEABLE, THEN THE ENTIRETY OF THIS ARBITRATION PROVISION (EXCEPT FOR THE JURY TRIAL WAIVER AND THE INFORMAL DISPUTE RESOLUTION PROCESS) SHALL BE NULL AND VOID. THIS PARAGRAPH IS AN ESSENTIAL PART OF THIS ARBITRATION AGREEMENT.

                                 

                                15c. DISPUTE RESOLUTION THROUGH ARBITRATION OR SMALL CLAIMS COURT

                                 

                                Any dispute, claim, or controversy between you and Zuma (that is not resolved informally by Zuma Customer Service or as provided under subsection 15a above) that arises from or relates in any way to this Agreement (including any alleged breach of this Agreement), the Service, or our relationship with you (collectively, “Dispute”), shall be exclusively resolved through BINDING INDIVIDUAL ARBITRATION except as specifically provided otherwise in this Dispute Resolution Section. “Dispute” as used in this Agreement shall have the broadest possible meaning and include claims that arose before the existence of this or any prior Agreement and claims that arise during the term of this Agreement or after the termination of this Agreement. Notwithstanding the foregoing, either you or Zuma may elect to have an individual claim heard in small claims court. If the request to proceed in small claims court is made after an arbitration has been initiated but before an arbitrator has been appointed, such arbitration shall be administratively closed. Any controversy over the small claims court’s jurisdiction shall be determined by the small claims court. All other issues (except as otherwise provided herein) are exclusively for the Arbitrator to decide, including but not limited to scope and enforceability of this Dispute Resolution Section, as well as any request to proceed in small claims court that is made after an arbitrator has been appointed. If you or Zuma challenges the small claims court election in your Dispute, and a court of competent jurisdiction determines that the small claims court election is unenforceable, then such election shall be severed from this Agreement as to your Dispute. However, such court determination shall not be considered or deemed binding with respect to Zuma’s other contracting parties.

                                ​

                                Any court proceeding to enforce this Dispute Resolution Section 15, including any proceeding to confirm, modify, or vacate an arbitration award, must be commenced in accordance with Section 17. In the event Dispute Resolution Section 15 is for any reason held to be unenforceable, any litigation against Zuma (except for small claims court actions) may be commenced only in the federal or state courts located in Dallas County, Texas. You hereby irrevocably consent to those courts’ exercise of personal jurisdiction over you for such purposes and waive any claim that such courts constitute an inconvenient forum.

                                 

                                15d. INDIVIDUAL ARBITRATION AND MASS ARBITRATION PROTOCOLS

                                 

                                This subsection 15d applies to Disputes that are submitted to NAM after fully completing the informal Notice and Dispute resolution process described in subsection 15a above and when no small claims court election is made by either Party. Any arbitration between you and Zuma shall be administered by NAM in accordance with NAM’s operative Comprehensive Dispute Resolution Rules and Procedures (the “NAM Rules”) in effect at the time any demand for arbitration is filed with NAM, as modified by this Dispute Resolution Section 15. For a copy of the NAM Rules, please visit https://www.namadr.com/resources/rules-fees-forms or contact NAM’s National Processing Center at 990 Stewart Avenue, 1st Floor, Garden City, NY 11530 and email address commercial@namadr.com. If NAM is unable or unwilling to perform its duties under this Agreement, the Parties shall mutually agree on an alternative administrator that will replace NAM and assume NAM’s role consistent with this Agreement. If the Parties are unable to agree, they will petition a court of competent jurisdiction to appoint an administrator that will assume NAM’s duties under this Agreement.

                                The Parties agree that the following procedures will apply to any Arbitrations initiated under this Dispute Resolution Section:

                                Commencing an Arbitration – To initiate an arbitration, you or Zuma shall send to NAM a demand for arbitration (“Demand for Arbitration”) that describes the claim(s) and request for relief in detail, consistent with the requirements in this Agreement and NAM Rules. If you send a Demand for Arbitration, you shall also send it to Zuma at Zuma Group Legal, P.O. Box 25458, Dallas, Texas 75225, USA, within 10 days of delivery of the Demand for Arbitration to NAM. If Zuma sends a Demand for Arbitration, we will also send it to your mailing address on file with us within the same 10-day period. If your mailing address is unavailable, we will send it to your email address on file, or if no email address is on file, other contact information associated with your account. The arbitration provider shall not accept or administer any demand for arbitration and shall administratively close any such demand for arbitration that fails to certify in writing that the Party meets the requirements of Dispute Resolution Section 15 or if either Party elects small claims court as set forth above.

                                Fees – The payment of all fees shall be governed by the NAM Rules, except to the extent that the case is a part of a Mass Filing (as defined below) or the NAM fees and costs (including Arbitrator fees) paid by either Party are reallocated upon order of the Arbitrator following a determination that (a) either Party breached Section 15 of this Agreement, (b) such reallocation is called for under this Agreement, or (c) reallocation is otherwise permitted under applicable law. Upon a showing to Zuma of your financial hardship we will consider a good faith request made by you to pay your portion of the applicable consumer portion of the filing fee. Zuma is committed to ensuring that arbitration costs to consumers do not serve as a barrier to the adjudication of disputes. If Zuma initiates an arbitration against you, we shall pay all fees.

                                The Arbitrator – The arbitration shall be conducted by a single, neutral arbitrator (the “Claim Arbitrator”), as assisted by any Process Arbitrator appointed under NAM Rules. (The term “Arbitrator” applies to both the Claim Arbitrator and the Process Arbitrator). If a hearing is elected by either Party, the Arbitrator shall be in or close to the location in which you reside. The Arbitrator is bound by and shall adhere to this Agreement. In the event NAM Rules conflict with this Agreement, the terms of this Agreement shall control. If the Arbitrator determines that strict application of any term of Section 15 of this Agreement (except for the small claims election, which shall be determined by the small claims court) would result in a fundamentally unfair arbitration (the “Unfair Term”), then the Arbitrator shall have authority to modify the Unfair Term to the extent necessary to ensure a fundamentally fair arbitration that is consistent with the Agreement (the “Modified Term”). In determining the substance of a Modified Term, the Arbitrator shall select a term that comes closest to expressing the intention of the Unfair Term.

                                Dispositive Motions – The Parties agree that the Claim Arbitrator shall have the authority to consider dispositive motions without an oral evidentiary hearing. Dispositive motions may be requested under the following circumstances: (a) within 30 days after the Claim Arbitrator’s appointment, a Party may request to file a dispositive motion based upon the pleadings; and (b) no later than 30 days prior to the evidentiary hearing, a Party may request to file a dispositive motion for summary judgment based upon the Parties’ pleadings and the evidence submitted.

                                Discovery – Each Party may (a) serve up to five requests for relevant, non-privileged documents from the other Party; and (b) request that the other Party provide verified responses to no more than 5 relevant interrogatories (including subparts). Unless both Parties agree otherwise, no other forms of discovery (including depositions) may be utilized. Any such discovery requests must be served on the other Party within 21 days after the Claim Arbitrator’s appointment. The responding Party shall provide the requesting Party with all responsive, non-privileged documents, responses signed by the Party themselves to the requested interrogatories, and/or any objections to the requests within 30 days after receipt of the requests, or, in the event of an objection to any discovery request, 30 days after the Claim Arbitrator resolves the dispute. In the event either Party requests that the Claim Arbitrator consider a dispositive motion on the pleadings, such written discovery response deadlines shall be extended until 30 days following the Claim Arbitrator’s final decision on such dispositive motion. Any disputes about discovery or requests for extensions shall be submitted promptly to the Claim Arbitrator for resolution. In ruling on any discovery dispute or extension request, the Claim Arbitrator shall take into consideration the nature, amount, and scope of the underlying arbitration claim, the cost and other effort that would be involved in providing the requested discovery, the case schedule, and whether the requested discovery is necessary for the adequate preparation of a claim or defense.

                                Confidentiality – Upon either Party’s request, the Arbitrator will issue an order requiring that confidential information of either Party disclosed during the arbitration (whether in documents or orally) may not be used or disclosed except in connection with the arbitration or a proceeding to enforce the arbitration award and that any permitted court filing of confidential information must be done under seal.

                                Arbitration Hearing – You and Zuma are entitled to a fair evidentiary hearing (i.e. trial) before the Claim Arbitrator. Arbitration proceedings are usually simpler, less costly, and more streamlined than trials and other judicial proceedings. The Parties agree to waive all oral hearings and instead submit all disputes to the Claim Arbitrator for an award based on written submissions and other evidence as the Parties may agree, unless a Party requests an oral hearing within 10 days after the Respondent files a response. If an oral evidentiary hearing is requested, both Parties must be personally present at the hearing, regardless of whether either Party has retained counsel. Both Parties must personally attend the hearing. Either Party’s failure to personally attend the hearing, without a continuance ordered by the Claim Arbitrator for good cause, will result in a default judgment taken against that Party.

                                Arbitration Award – Regardless of the format of the arbitration, the Claim Arbitrator shall provide a reasoned decision, in writing within 30 days after the hearing or, if no hearing is held, within 30 days after any rebuttal or supplemental statements are due. The decision must clearly specify the relief, if any, awarded and contain a brief statement of the reasons for the award. The arbitration award is binding only between you and Zuma and will not have any preclusive effect in another arbitration or proceeding that involves a different Party. The Claim Arbitrator may, however, choose to consider rulings from other arbitrations involving a different Party. The Arbitrator may award fees and costs as provided by the NAM Rules or to the extent such fees and costs could be awarded in court. This includes but is not limited to the ability of the Arbitrator to award fees and costs if the Arbitrator determines that a claim or defense is frivolous or was brought for an improper purpose, for the purpose of harassment, or in bad faith.

                                Offer of Settlement – The Respondent may, but is not obligated to, make a written settlement offer to the opposing Party any time before the evidentiary hearing or, if a dispositive motion is permitted, prior to the dispositive motion being granted. The amount or terms of any settlement offer may not be disclosed to the Claim Arbitrator until after the Claim Arbitrator issues an award on the claim. If the award is issued in the opposing Party’s favor and is less than the Respondent’s settlement offer or if the award is in the Respondent’s favor, the opposing Party must pay the Respondent’s costs incurred after the offer was made, including any attorney’s fees. If any applicable statute or caselaw prohibits the flipping of costs incurred in the arbitration, then the offer in this provision shall serve to cease the accumulation of any costs that claimant may be entitled to for the cause of action under which it is suing.

                                Mass Filing – If, at any time, 25 or more similar demands for arbitration are asserted against Zuma or related parties by the same or coordinated counsel or entities (“Mass Filing”), consistent with the definition and criteria of Mass Filings set forth in the NAM’s Mass Filing Supplemental Dispute Resolution Rules and Procedures (“NAM’s Mass Filing Rules”, available at https://www.namadr.com/resources/rules-fees-forms/), the additional protocols set forth below shall apply.

                                i. If you or your counsel file a Demand for Arbitration that fits within the definition of Mass Filing referred to above, then you agree that your Demand for Arbitration shall be subject to the additional protocols set forth in this Mass Filing subsection. You also acknowledge that the adjudication of your Dispute might be delayed and that any applicable statute of limitations shall be tolled from the time at which the first cases are chosen to proceed until your case is chosen for a bellwether proceeding.

                                ii. NAM’s Mass Filing Rules shall apply if your Dispute is deemed by NAM, in its sole discretion pursuant to its Rules and this Dispute Resolution Section, to be part of a Mass Filing. Such election for NAM’s Mass Filing Rules and related fee schedule must be made by either you or Zuma in writing and submitted to NAM and all Parties.

                                iii. Bellwether Proceedings. Bellwether proceedings are encouraged by courts and arbitration administrators when there are multiple disputes involving similar claims against the same or related parties. Counsel for the Mass Filings claimants (including you) and counsel for Zuma shall each select 15 Demands for Arbitration (30 total), and no more than 30 arbitrations shall be filed, processed, adjudicated, or pending at the same time, with each of the 30 individual arbitrations presided over by a different Claim Arbitrator, in a first set of bellwether proceedings. During this time, no other Demands for arbitration that are part of the Mass Filings may be filed, processed, adjudicated, or pending. If the Parties are unable to resolve the remaining Demands for Arbitration after the first set of bellwether proceedings are arbitrated or otherwise resolved, then counsel for the Claimants and counsel for Zuma shall each select an additional 15 Demands for Arbitration (30) total to be filed, processed, and adjudicated as individual arbitrations, with each of the 30 arbitrations presided over by a different Claim Arbitrator, in a second set of bellwether proceedings. During this time, no other Demands for Arbitration that are part of the Mass Filings may be filed, processed, or adjudicated. This staged process of bellwether proceedings, with each set including 30 Demands for Arbitration adjudicated on an individual basis, shall continue until each Demand included in the Mass Filings (including your Demand for Arbitration) is adjudicated or otherwise resolved. Fees associated with a Demand for Arbitration included in the Mass Filings, including fees owed by Zuma and the claimants (including you), shall only be due after your Demand for Arbitration is chosen as part of a set of bellwether proceedings and therefore properly designated for filing, processing, and adjudication. Any applicable statute of limitations shall be tolled beginning when you initiate the informal dispute resolution process set forth in subsection 15a of the Agreement, and if the first Mass Filings’ Demands for Arbitration are chosen for the initial set of bellwether proceedings have been filed, your claims will remain tolled until your Demand for Arbitration is decided, withdrawn, or is settled. A court of competent jurisdiction located in a venue allowed under Section 17 of the Agreement shall have the power to enforce this subsection.

                                iv. You and Zuma agree that we each value the integrity and efficiency of the arbitration and small claims court process and wish to employ the process for the fair resolution of genuine and sincere disputes between us. You and Zuma acknowledge and agree to act in good faith to ensure the fair resolution of genuine and sincere Disputes. The Parties further agree that application of these Mass Filings procedures have been reasonably designed to result in an efficient and fair adjudication of such cases.

                                ​

                                15e. FUTURE CHANGES AND RETROACTIVE APPLICATION

                                ​

                                This Dispute Resolution Section 15 applies to all Disputes between the Parties, including for any claims that accrued against you or Zuma prior to the time of your consent to this Agreement and to any claims that accrue against you or Zuma after your consent to this Agreement. Notwithstanding any provision in this Agreement to the contrary, you may elect to opt out of the retroactive application of this Dispute Resolution Section 15 as to claims that have accrued against you or against Zuma prior to the time of your consent to this Agreement. You may opt out by sending us written notice, within 30 days of the time you consent to this Agreement, to the following email address: support@clubzuma.com. Please do not direct any customer support inquiries to support@clubzuma.com, as they will not be addressed; such inquiries should be directed to customer support. You must include information sufficient to identify your account(s), such as the email address or phone number associated with your account(s), and should include a statement that you are opting out of the retroactive application of this Dispute Resolution Section 15. Please note: if you opt out of the retroactive application of this Dispute Resolution Section 15, you will still be subject to and bound by any Dispute Resolution Sections and Arbitration Procedures you previously agreed to, including any arbitration provisions, class action waivers, and retroactive application sections. Also, regardless of whether you opt out of the retroactive application of these changes, the Parties will resolve any claims that accrue against you or Zuma after your consent to this Agreement in accordance with this Dispute Resolution Section.
                                """)
                    
                    TOSSection(title: "16. Governing Law", text: """
                                Texas law and the Federal Arbitration Act will apply to any Dispute (except where prohibited by law).
                                ​

                                To the fullest extent allowable by law, the laws of Texas, U.S.A., without regard to its conflict of laws rules, shall apply to any Dispute arising out of or relating to this Agreement, the Service, or your relationship with Zuma. Notwithstanding the foregoing, the Dispute Resolution Process set forth in Section 15 above shall be governed by the Federal Arbitration Act.
                                """)
                    
                    TOSSection(title: "17. Venue/Forum Selection", text: """
                                To the fullest extent allowable by law, any claims that are not arbitrated for any reason must be litigated in Dallas County, Texas (except for claims filed in small claims court).

                                ​

                                Except where prohibited by law and except for claims that are heard in a small claims court as set forth in Section 15, any claims arising out of or relating to this Agreement, to the Service, or to your relationship with Zuma that for whatever reason are not required to be arbitrated or filed in small claims court, will be litigated exclusively in the federal or state courts located in Dallas County, Texas, U.S.A. You and Zuma consent to the exercise of personal jurisdiction of courts in the State of Texas and waive any claim that such courts constitute an inconvenient forum.
                                """)
                    
                    TOSSection(title: "18. Indemnity By You", text: """
                                You agree, to the extent permitted under applicable law, to indemnify, defend and hold harmless Zuma, our affiliates, and their and our respective officers, directors, agents, and employees from and against any and all complaints, demands, claims, damages, losses, costs, liabilities and expenses, including attorney’s fees, due to, arising out of, or relating in any way to your access to or use of the Service, your Content, or your breach of this Agreement.You agree, to the extent permitted under applicable law, to indemnify, defend and hold harmless Zuma, our affiliates, and their and our respective officers, directors, agents, and employees from and against any and all complaints, demands, claims, damages, losses, costs, liabilities and expenses, including attorney’s fees, due to, arising out of, or relating in any way to your access to or use of the Service, your Content, or your breach of this Agreement.You agree, to the extent permitted under applicable law, to indemnify, defend and hold harmless Zuma, our affiliates, and their and our respective officers, directors, agents, and employees from and against any and all complaints, demands, claims, damages, losses, costs, liabilities and expenses, including attorney’s fees, due to, arising out of, or relating in any way to your access to or use of the Service, your Content, or your breach of this Agreement.
                                """)
                    
                    TOSSection(title: "19. Entire Agreement; Other", text: """
                                This Agreement, which includes the Privacy Policy, Cookie Policy, Community Guidelines, and any terms disclosed to you if you purchase or have purchased additional features, products or services we offer on the Service, contains the entire agreement between you and Zuma regarding your relationship with Zuma and the use of the Service, with the following exception: anyone who opted out of the retroactive application of Section 15 is still subject to and bound by any prior agreements to arbitrate with Zuma as well as this agreement to arbitrate on a going forward basis. If any provision of this Agreement is held invalid, the remainder of this Agreement shall continue in full force and effect. The failure of Zuma to exercise or enforce any right or provision of this Agreement shall not constitute a waiver of such right or provision. You agree that your Zuma account is non-transferable and all of your rights to your account and its Content terminate upon your death. No agency, partnership, joint venture, fiduciary or other special relationship or employment is created as a result of this Agreement and you may not make any representations on behalf of or bind Zuma in any manner.
                                """)
                    
                }
            
                
                Spacer()

            }
            .padding()
        }
        .background(Color("BabyBlue"))
        .edgesIgnoringSafeArea(.all)
    }
}


struct TOSSection : View {
    var title : String
    var text : String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.custom("LexendMega-SemiBold", size : 15))
                    .tracking(-2.0)
                    .foregroundColor(.black)
                
            
                
                
                Spacer()
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            
            
            Text(text)
                .font(.custom("LexendMega-Regular", size : 10))
                .tracking(-2.0)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
        }
    }
}

struct TOSView_Previews: PreviewProvider {
    static var previews: some View {
        TOSView()
    }
}
