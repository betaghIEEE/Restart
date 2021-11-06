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
            
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
            }   //: ZStack end for the Character image
            
            // MARK:    -   CENTER
            
            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            
            // MARK:    -   FOOTER
            
            // This spacer adds some distance between the center quote and the button.
            Spacer()
            
            // There is an issue addressed in the footer pertaining to the Accent Color.
            // Apple typically manages the Accent Color as part of a release scheme, and this is part of the system.  Thereofore, Apple can change this at any time.
            // Developers can set the Accent Color in the app's Asset Catalog, therefore assuming some measure of control for the application.
            
            
            Button(action: {
                isOnboardingViewActive = true
            }) {
                // We need some system images to give this button just the right "touch"
                // The real question is, how do we find out what System images are there?   It there method to this madness to allow even a mediocre artist and half way decent software engineer apply these things so we come out all right by the customers.
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                // Note: No horizontal stack wrapper needed in this case.  There are only two elements.
                // This is because of the button.  It acts like the HStack container with 2 or more items in its container.
                
                
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                
                
                
            }  // End of Button.  Note: iOS 15 now has button sytles.
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            
        } //: VSTACK END
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
