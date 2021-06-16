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
                if settings.applicationInstalling.isEmpty && !disableExitScreen {
                    ExitView(settings: settings)
                        .animation(.easeInOut(duration: 1.0))
                        .transition(.opacity)
                } else {
                    ProvisioningView(settings: settings)
                        .animation(.easeInOut(duration: 1.0))
                        .transition(.opacity)
                }
            } else {
                WelcomeView(settings: settings)
            }
        }
        .frame(width: 900, height: 550)
        //.textSelection(.enabled) - macOS 12.0 and higher only
        //.ignoresSafeArea(.all) - macOS 12.0 and higher only
        .edgesIgnoringSafeArea(.all)
    }
}

struct Divider: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 1)
        }
        .frame(width: 900)
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(settings: HelloHelper())
    }
}
#endif
