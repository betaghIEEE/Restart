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
                        Circle()
                            .stroke(.white.opacity(0.2), lineWidth: 80)
                            .frame(width: 260, height: 260, alignment: .center)
                       
                    } //: Inner ZStack
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                } //: CENTER
                Spacer()
                
                
                // MARK:    - FOOTER
                
                ZStack{
                    
                } //: FOOTER end
                
                
            } //: VSTACK END
        }   //: ZSTACK
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
