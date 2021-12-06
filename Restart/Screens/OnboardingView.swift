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
    
    @State private var imageOffset : CGSize = .zero
    
    @State private var indicatorOpacity : Double = 1.0
    
    @State private var textTitle: String = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    //  MARK: - Body
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                // MARK:    - HEADER
                
                Spacer()
                VStack(spacing: 0){
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    
                    
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
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2 , y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if abs(imageOffset.width ) <= 150 {
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)){
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                }
                                .onEnded{ _ in
                                         imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25)){
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                        
                                    }
                                }
                                
                        ) //: GESTURE
                        .animation(.easeOut(duration: 1 ), value: imageOffset)
                } //: CENTER
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating )
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                
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
                                    withAnimation(Animation.easeOut(duration: 0.8) ){
                                        if gester.translation.width <= (buttonWidth / 2) {
                                            buttonOffset = 0
                                            hapticFeedback.notificationOccurred(.warning)
                                        } else if  gester.translation.width > (buttonWidth / 2) {
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            // Change screen to Home view
                                            isOnboardingViewActive = false
                                            // Oh, set button Offset to zero
                                            buttonOffset = buttonWidth - buttonSize
                                            
                                            
                                        }
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
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
