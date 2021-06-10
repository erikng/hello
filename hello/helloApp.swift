//
//  helloApp.swift
//  hello
//
//  Created by Erik Gomez on 6/8/21.
//

import SwiftUI

@main
struct helloApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification), perform: { _ in
                    for window in NSApplication.shared.windows {
                        window.standardWindowButton(.closeButton)?.isHidden = true // hides the red close button
                        window.standardWindowButton(.miniaturizeButton)?.isHidden = true // hides the yellow miniaturize button
                        window.standardWindowButton(.zoomButton)?.isHidden = true // this removes the green zoom button
                        window.center() // center
                        window.isMovable = false // not movable
                        #if DEBUG
                            NSApp.activate(ignoringOtherApps: false) // annoying AF when testing in Xcode
                        #else
                            NSApp.activate(ignoringOtherApps: true) // bring to forefront upon launch
                        #endif
                    }
                })
        }
        .windowStyle(.hiddenTitleBar) // 24 pixels
    }
}

// AppDelegate
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        _ = "" // temporary placeholder
    }
}
