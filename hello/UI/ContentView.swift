//
//  ContentView.swift
//  hello
//
//  Created by Erik Gomez on 6/8/21.
//

import SwiftUI

class HelloHelper: ObservableObject {
    // @Published var hasClickedWelcomeButton = false
    @Published var hasClickedWelcomeButton = true // test exitscreen
    @Published var hasClickedExitButton = false
    // @Published var applicationInstalling = "Initializing"
    @Published var applicationInstalling = "" // test exitscreen
    @Published var applicationInstallingIconPath = ""
}

// ContentView
struct ContentView: View {
    @StateObject var settings = HelloHelper()
    @State var refreshUI = false
    var body: some View {
        VStack {
            if settings.hasClickedWelcomeButton || disableWelcomeScreen {
                if settings.applicationInstalling.isEmpty && enableExitScreen {
                    ExitView()
                        .animation(.easeInOut(duration: 1.0))
                        .transition(.opacity)
                } else {
                    PrimaryView(settings: settings)
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
        ContentView()
    }
}
#endif
