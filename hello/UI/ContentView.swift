//
//  ContentView.swift
//  hello
//
//  Created by Erik Gomez on 6/8/21.
//

import SwiftUI

// ContentView
struct ContentView: View {
    @ObservedObject var settings: HelloHelper
    var body: some View {
        VStack {
            if settings.hasClickedwelcomeButtonText || disableWelcomeScreen {
                if ((settings.applicationState.isEmpty && deviceStages.count > 0) || (settings.applicationState.values.contains("installing") || settings.applicationState.values.contains("pending"))) || disableExitScreen {
                    ProvisioningView(settings: settings)
                        .animation(.easeInOut(duration: 1.0))
                        .transition(.opacity)
                } else {
                    ExitView(settings: settings)
                        .animation(.easeInOut(duration: 1.0))
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
        //.textSelection(.enabled) - macOS 12.0 and higher only
        //.ignoresSafeArea(.all) - macOS 12.0 and higher only
        .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(settings: HelloHelper())
    }
}
#endif
