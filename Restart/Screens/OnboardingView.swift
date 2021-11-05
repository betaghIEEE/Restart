//
//  OnboardingView.swift
//  Restart
//
//  Created by Daniel Beatty on 11/4/21.
//

import SwiftUI

struct OnboardingView: View {
    //  MARK:   - Property
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    //  MARK: - Body
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                Text("Onboarding")
                    .font(.largeTitle)
                
                Button(action: {
                    isOnboardingViewActive = false
                }) {
                    Text("Start")
                }
                
            } //: VSTACK END
        }   //: ZSTACK
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
