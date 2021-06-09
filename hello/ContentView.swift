//
//  ContentView.swift
//  hello
//
//  Created by Erik Gomez on 6/8/21.
//

import SwiftUI

// BackgroundView
struct BackgroundView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 15.0) {
            HStack(alignment: .center) {
                Image(nsImage: Utils().createImageData(fileImagePath: "/Applications/Playgrounds.app/Contents/Resources/PlaygroundsAppIcon.icns"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 75.0, height: 75.0)
                Spacer()
                Image(nsImage: Utils().createImageData(fileImagePath: "/Users/Shared/github.png"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 100.0, height: 25.0)
            }
            .frame(width: 975.0)
            .padding(.top, 25.0)
            VStack(spacing: 5.0) {
                // Header
                HStack {
                    Spacer()
                    Text("Setting up your Mac...")
                        .foregroundColor(.primary)
                        .font(.title)
                        .fontWeight(.medium)
                    Spacer()
                }
                // SubHeader
                HStack {
                    Text("Your Mac is being automatically configured by your organization. This process may take some time to complete. Please don't attempt to restart or shut down the computer unless you are prompted to do so.")
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 500.0, alignment: .leading)
            }
            HStack {
                List(0..<20) { i in
                    VStack {
                        HStack(spacing: 20.0) {
                            Text("\(i+1)")
                                .font(.body)
                            if i == 0 {
                                Image(nsImage: Utils().createImageData(fileImagePath: "/Applications/GitHub Desktop.app/Contents/Resources/electron.icns"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .scaledToFit()
                                    .frame(width: 40.0, height: 40.0)
                                Text("Github Desktop")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .frame(width: 700.0, alignment: .leading)
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("Completed")
                            }
                            if i == 1 {
                                Image(nsImage: Utils().createImageData(fileImagePath: "/Applications/Slack.app/Contents/Resources/electron.icns"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .scaledToFit()
                                    .frame(width: 40.0, height: 40.0)
                                Text("Slack")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .frame(width: 700.0, alignment: .leading)
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("Completed")
                            }
                            if i == 2 {
                                Image(nsImage: Utils().createImageData(fileImagePath: "/Applications/Visual Studio Code.app/Contents/Resources/Code.icns"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .scaledToFit()
                                    .frame(width: 40.0, height: 40.0)
                                Text("Visual Studio Code")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .frame(width: 700.0, alignment: .leading)
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .scaleEffect(0.4, anchor: .leading)
                                Text("Installing")
                                    .padding(.leading, -17.5)
                            }
                            Spacer()
                        }
                        Rectangle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(height: 1.0)
                    }
                }
                .frame(width: 975.0)
            }
            .background(Color.secondary.opacity(0.5))
            .cornerRadius(10.0)
            .frame(width: 975.0, height: 325.0)
            
            // Horizontal line
            HStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: 1.0)
            }
            .frame(width: 1000.0)
            
            HStack {
                Button {
                    print("This is a test")
                } label: {
                    Image(systemName: "questionmark.circle")
                }
                .buttonStyle(.link)
                Image(nsImage: Utils().createImageData(fileImagePath: "/Applications/Visual Studio Code.app/Contents/Resources/Code.icns"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 30.0, height: 30.0)
                    .padding(.leading, 25.0)
                Text("Visual Studio Code")
                    .fontWeight(.bold)
                Text("is installing")
                    .fontWeight(.light)
                    .padding(.leading, -5.0)
                Spacer()
            }
            .padding(.top, -5.0)
            .frame(width: 975.0)
        }
        .frame(width: 1000.0, height: 600.0)
    }
}

struct ContentView: View {
    var body: some View {
        BackgroundView().background(
            HostingWindowFinder { window in
                window?.standardWindowButton(.closeButton)?.isHidden = true //hides the red close button
                window?.standardWindowButton(.miniaturizeButton)?.isHidden = true //hides the yellow miniaturize button
                window?.standardWindowButton(.zoomButton)?.isHidden = true //this removes the green zoom button
                window?.center() // center
                //window?.styleMask.remove(.titled)
                #if DEBUG
                    NSApp.activate(ignoringOtherApps: false) // bring to forefront upon launch
                #else
                    NSApp.activate(ignoringOtherApps: true) // bring to forefront upon launch
                #endif
            }
        )
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: ContentView().preferredColorScheme)
    }
}
#endif

struct HostingWindowFinder: NSViewRepresentable {
    var callback: (NSWindow?) -> ()

    func makeNSView(context: Self.Context) -> NSView {
        let view = NSView()
        
        DispatchQueue.main.async { [weak view] in
            self.callback(view?.window)
        }
        return view
    }
    func updateNSView(_ nsView: NSView, context: Context) {}
}

// Stuff if we ever implement fullscreen
//        let presentationOptions: NSApplication.PresentationOptions = [
//            .hideDock, // Dock is entirely unavailable. Spotlight menu is disabled.
//            // .autoHideMenuBar,           // Menu Bar appears when moused to.
//            // .disableAppleMenu,          // All Apple menu items are disabled.
//            .disableProcessSwitching      // Cmd+Tab UI is disabled. All Exposé functionality is also disabled.
//            // .disableForceQuit,             // Cmd+Opt+Esc panel is disabled.
//            // .disableSessionTermination,    // PowerKey panel and Restart/Shut Down/Log Out are disabled.
//            // .disableHideApplication,       // Application "Hide" menu item is disabled.
//            // .autoHideToolbar,
//            // .fullScreen
//        ]
//        let optionsDictionary = [NSView.FullScreenModeOptionKey.fullScreenModeApplicationPresentationOptions: presentationOptions]
//        if let screen = NSScreen.main {
//            view.enterFullScreenMode(screen, withOptions: [NSView.FullScreenModeOptionKey.fullScreenModeApplicationPresentationOptions:presentationOptions.rawValue])
//        }
//        //view.enterFullScreenMode(NSScreen.main!, withOptions: optionsDictionary)

