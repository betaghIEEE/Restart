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


## The Onboarding View's Swipe Right Slider Button
The basics of a slider button is that it is a gesture that is hard to do by accident.  This is why it was used as the unlock gesture for the iPhone initially.  
The Human Interfaces gurus came back to Steve (and probably Steve himself also) with many ideas.  The ideas focused on how to prevent the iPhone from turning its GUI on accidently.  Why?  They assessed how people treated their "dumb" cellular phones.  People put their phones in their pockets,  cleverly crafted holster attached to their belt, or purses.  In any case, they asked if thing jingling next to the phone could turn it on?  Could fingers reaching for and picking the phone up (and out of its stored place) wake up its GUI?  Bottom line, Steve wanted operation of the iPhone to be an intentional act.   He wanted to restrict involuntary, clumsy, and inadvertant actions to the realm of non-consequence. 
So, we build such a slider button for our app as this method has been proven.  It is proven to users and they instinctively know what it is.  They know how to use it.  They know what is likely to happen when they use it.  So, here we go.
 
The desired features on the Slider Button is as follows:
    1.  Drag gesture
        *   The user should be able to touch the slider's button on the left side of the oval container.  This initiates the slide movement.
    2.  Deformable shape
        *   During the slide to the right the one of the ovals deforms and gives the impression that a "sliding door" is moving with the button's circle.
    3.  Snappy Feature 
        *   If the button's circle makes it only half way to the right and is release, then the button snaps back to the beginning.
    4.  Screen Change
        *   If the button makes it farther than half way, then the screen change state occurs.
        
Question of note:  why wouldn't we make such a slider a reuseable component?  

We need two new properties in the onboarding view structure.

I added some pieces to the circle description in the body.  I added framewidth to the footer and offset to the ZStack containing the draggable circles.
I added a drag gesture to the end of the draggable circle's ZStack (replacing the tap action.)
The drag gesture needs more configuration to work properly.  Therefore, we further define what Drag Gesture properties we need.  For example, onchanged.  This we define with a closure with the variable/argument gesture.  This allows us to capture information from the OS on what the drag gesture is occurring.


## Add animations part 1
In this section, I established whether an animation is to occur and how it does.

I added action for the onAppear observer for the big vStack (root of the body, bottom). The observer onAppear that takes a closure as its argument, named perform. Thus, when OnBoarding' onAppear observer fires the perform closure and sets isAnimating to true.  
The next change is made at the end of the header's VStack.  I added settings for offset, opacity, and animation that depend on the isAnimating property.  If isAnimating is true then we make the header's vStack transparent, change its offset to -40, and start the easeOut animation.
Reference: SwiftUI Annimation Part 1 (Lesson 22, part of section 2)
The author makes reference to some Swift constructs in this code.  In particular, the isAnimating is used to set parameter sent to the offset and opacity properties of the onBoarding struct/ View.

Okay, the first part of the animations seem to roll down the header pieces in 1 second.  The ease out seems to be directed down.  I think that is the offset and changes from the isAnimating flag flipping. 
Here we also apply a similar set of annimations to the footer.   This should make the application start without some sweet header and without the footer's slider button.

The instructor recommends using the Dispatch Queue to make onAppear observer response start animating the Home screen view.  
The Dispatch Queue is provided by Apple, and has been since XGrid and macOS Leopard.  The Dispatch Queue is an object that manages the execution of tasks serially or concurrently on your app's main thread or on a background thread.
The instructor says that because we want the home view's animation to be slightly delayed, we have to use the main thread on the dispatch queue to ensure the right timing.
The executing task asynchronously (third message in the observer response instruction) provides instruction on when to establish the animation.  Once this setting is made, the animation tasks start.
 
 ## The next Drag Gesture to be added
 This segment of training shows how to add drag gesture capability to a character image inside one of the views.  In this case, we make a drag gesture in the onboarding view to make the heart carrying dude move a bit.
 
 The following adjustments are to be made:
    1.  Drag Gesture
    2.  Movement with Rotation
    3.  Horizontal Parallax Effect
    4.  Arrow indicator
    5.  Opacity Transition
    
These ideas is to give an illusion of view port changing by blurring parts of the graphic and its animation.  
    
 ## Final Touches
 The instructor thinks there are some final touches to make the app prettier.  For example:
 
 1. Preferred Color Scheme
 2. Playing with Sound Effects 
 3. Haptic Feedbacks.  
 
 You can use the authors contributions in the editor options to look back when each part was added and what difference it made.

### Apply AV Foundation
We can apply sound effects by making an utility module.  
The AV Foundation has been here for some time, at least in Objective C.  Swift inherits this on Apple products.  I can't speak to Linux distribution under Swift Objects.

AV Foundation is a full-featured framework for working with time-based audiovisual media on Apple platforms (iOS, macOS, watchOS, and tvOS).  
We can easily play, create, and edit movies, sound files, and build powerful media functionality into any apps using this framework. 
