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

    var body: some View {
        VStack(spacing: 20) {
            Text("Onboarding")
                .font(.largeTitle)
            
            Button(action: {
                isOnboardingViewActive = false 
            }) {
                Text("Start")
            }
            
        } //: VSTACK END
    }
    
    


##  Efforts on the Home Screen


