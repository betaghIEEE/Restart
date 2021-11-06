//
//  HomeView.swift
//  Restart
//
//  Created by Daniel Beatty on 11/4/21.
//

import SwiftUI

struct HomeView: View {
    
    
    //  MARK:   - Property
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    
    //  MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            //  MARK:   -  HEADER
            
            Spacer()
            
            Image("character-2")
                .resizable()
                .scaledToFit()
                .padding()
            
            // MARK:    -   CENTER
            
            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            
            // MARK:    -   FOOTER
            
            Button(action: {
                isOnboardingViewActive = true
            }) {
                Text("Restart")
            }
            
        } //: VSTACK END
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
