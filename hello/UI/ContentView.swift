//
//  ContentView.swift
//  hello
//
//  Created by Erik Gomez on 6/8/21.
//

import SwiftUI

class HelloHelper: ObservableObject {
    @Published var hasClickedWelcomeButton = false
    @Published var applicationInstalling = "Initializing"
    @Published var applicationInstallingIconPath = ""
}

// ContentView
struct ContentView: View {
    @StateObject var settings = HelloHelper()

    var body: some View {
        VStack {
            if settings.hasClickedWelcomeButton || disableWelcomeScreen {
                PrimaryView()
                    .animation(.easeInOut(duration: 1.0))
                    .transition(.opacity)
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

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
