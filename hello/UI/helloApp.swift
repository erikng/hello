//
//  helloApp.swift
//  hello
//
//  Created by Erik Gomez on 6/8/21.
//

import SwiftUI

class HelloHelper: ObservableObject {
    @Published var hasClickedwelcomeButtonText = false
    @Published var hasClickedExitButton = false
    @Published var applicationInstallingIconPath = ""
    @Published var applicationInstalling = ""
    @Published var applicationState = [Int: String]()
    @Published var refreshUI = false

    var allStagesInstalled: Bool {
        deviceStages.allSatisfy { stage in
            applicationState[stage.id] == "installed"
        }
    }
}

@main
struct helloApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var settings = HelloHelper()
    
    var body: some Scene {
        WindowGroup {
            ContentView(settings: settings)
                .onReceive(helloRefreshCycleTimer) { _ in
                    settings.refreshUI.toggle()
                }
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification)) { _ in
                    configureWindows()
                }
        }
        .windowStyle(.hiddenTitleBar) // 24 pixels
    }
    
    private func configureWindows() {
        for window in NSApplication.shared.windows {
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true
            window.center()
            window.isMovable = false
            NSApp.activate(ignoringOtherApps: true)
        }
    }
}

// AppDelegate
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Add any required setup after application launch
    }
}
