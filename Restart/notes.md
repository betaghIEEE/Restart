#  Notes on Advanced iOS 15 App Design with SwiftUI 3 Framework
This project examines and produces an example of iOS 15 App Design.  The explicit framework in play is the SwiftUI 3 framework.   
We use the notion of a Reset Application that moves back and forth between an Onboarding View and Home View.  The connecting view is the content view.

## Launch Screen Info
This part of the project restructures the code to run correctly in the simulators.  The launch screen part of the info.plist 
1. eliminates the presense of instructions for horizontal views.
2. Ensures that only one view is found and therefore acted upon.

## Main Content View


    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
   // @AppStorage("home") var isHomeViewActive: Bool = false
    
    
    
    var body: some View {
        ZStack {
            if isOnboardingViewActive {
                OnboardingView()
            } else {
                HomeView()
            }
        }
    }
}

##  Efforts on the Onboarding Screen
First efforts produce a Vertical Stack:

We change the code of the body to meet this coded description:

        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                // MARK:    - HEADER
                
                Spacer()
                VStack(spacing: 0){
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }   //: HEADER End
                
                // MARK:    - CENTER
                
                ZStack{
                    ZStack{
                        Circle()
                            .stroke(.white.opacity(0.2), lineWidth: 40)
                            .frame(width: 260, height: 260, alignment: .center)
                        
                    } //: Inner ZStack
                    
                } //: CENTER
                Spacer()
                
                
                // MARK:    - FOOTER
                
                // We use this code to create two circles with an icon in the middle. 
                
                     HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                            
                        } // ZStack end.  Note modifiers
                        .foregroundColor(.white)
                    .frame(width: 80, height: 80, alignment: .center)
                        // This spacer moves the "icon circles" to the left and prepares this arrangement for a drag right like the original open iPhone slider.
                        Spacer()
                        
                    } //: HStack end
                    
                } //: FOOTER end
                .frame(height: 80, alignment: .center)
                .padding()
                
            } //: VSTACK END
        }   //: ZSTACK
    
    


##  Efforts on the Home Screen


            *   There is an issue addressed in the footer pertaining to the Accent Color.
            *   Apple typically manages the Accent Color as part of a release scheme, and this is part of the system.  Thereofore, Apple can change this at any time.
            *   Developers can set the Accent Color in the app's Asset Catalog, therefore assuming some measure of control for the application.
The home screen should have a nice character icon to indicate the purpose of the app and user actions that it is "assisting" with.
            
So now we have added button styles and work in the footer.  The next part is reuseable components. 
So, note this in version control so we can follow what parts go where.


