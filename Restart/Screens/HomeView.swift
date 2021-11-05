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
            Text("Home")
                .font(.largeTitle)
            
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
