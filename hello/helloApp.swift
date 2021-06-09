//
//  helloApp.swift
//  hello
//
//  Created by Erik Gomez on 6/8/21.
//

import SwiftUI

@main
struct helloApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 1000.0, height: 550.0)
                .ignoresSafeArea(.all)
        }
        .windowStyle(.hiddenTitleBar)
    }
}
