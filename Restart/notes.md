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
                
            } //: VSTACK END
        }   //: ZSTACK
    
    


##  Efforts on the Home Screen


