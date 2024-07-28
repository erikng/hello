//
//  ContentView.swift
//  hello
//
//  Created by Erik Gomez on 6/8/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var settings: HelloHelper
    
    var body: some View {
        VStack {
            if settings.hasClickedwelcomeButtonText || disableWelcomeScreen {
                if shouldShowProvisioningView {
                    ProvisioningView(settings: settings)
                        .animation(.easeInOut, value: 1.0)
                        .transition(.opacity)
                } else {
                    ExitView(settings: settings)
                        .animation(.easeInOut, value: 1.0)
                        .transition(.opacity)
                }
            } else {
                if enableWelcomeScreenTimer {
                    WelcomeView(settings: settings)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(welcomeTimer)) {
                                settings.hasClickedwelcomeButtonText = true
                            }
                        }
                } else {
                    WelcomeView(settings: settings)
                }
            }
        }
        .frame(width: 900, height: 550)
        .textSelection(.enabled)
        .ignoresSafeArea(.all)
        .edgesIgnoringSafeArea(.all)
    }
    
    private var shouldShowProvisioningView: Bool {
        !settings.allStagesInstalled || disableExitScreen
    }
    
    private var welcomeView: some View {
        WelcomeView(settings: settings)
            .onAppear {
                if enableWelcomeScreenTimer {
                    DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(welcomeTimer)) {
                        settings.hasClickedwelcomeButtonText = true
                    }
                }
            }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(settings: HelloHelper())
    }
}
#endif

