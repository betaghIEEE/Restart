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
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    
    @State private var buttonOffset: CGFloat = 0
    
    private var buttonSize: CGFloat = 80
    
    @State private var isAnimating: Bool = false
    
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
                .opacity(isAnimating ? 1 : 0)  // We make header transparent if an animation is going on.
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                
                // MARK:    - CENTER
                
                
                
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                } //: CENTER
                Spacer()
                
                
                // MARK:    - FOOTER
                
                ZStack{
                    // Parts of the Custom button
                    
                    // 1. Background (Static)
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // 2. Call-to-action (Static)
                    
                    Text("Get Started.")
                        .font(.system(.title3, design: .rounded ))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    
                    // 3. Capsule (Dynamic Width)
                    
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width:buttonOffset + buttonSize)
                        Spacer()
                        
                    } //: HStack end
                    
                    // 4. Circle (draggable)
                    
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
                        .frame(width: buttonSize, height: buttonSize, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - buttonSize {
                                        buttonOffset = gesture.translation.width
                                    }
                                    
                                }
                                .onEnded{ gester in
                                    
                                    //buttonOffset = 0
                                    
                                    if gester.translation.width <= (buttonWidth / 2) {
                                        buttonOffset = 0
                                    } else if  gester.translation.width > (buttonWidth / 2) {
                                        // Change screen to Home view
                                        isOnboardingViewActive = false
                                        // Oh, set button Offset to zero
                                        buttonOffset = buttonWidth - buttonSize
                                    }
                                    
                                    
                                }
                        ) //: GESTURE  
                  
                        
                        // This spacer moves the "icon circles" to the left and prepares this arrangement for a drag right like the original open iPhone slider.
                        Spacer()
                        
                    } //: HStack end  Circle collection
                    
                } //: FOOTER end
                .frame(width:buttonWidth, height: buttonSize, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)  // We make footer transparent if an animation is going on.
                .offset(y: isAnimating ? 0 : +40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
            } //: VSTACK END
        }   //: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
