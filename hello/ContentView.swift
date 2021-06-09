//
//  ContentView.swift
//  hello
//
//  Created by Erik Gomez on 6/8/21.
//

import SwiftUI

// TopIcons
struct TopIcons: View {
    var body: some View {
        HStack(alignment: .center) {
            if #available(macOS 12.0, *) {
                AsyncImage(url: URL(string: "file:///Applications/Playgrounds.app/Contents/Resources/PlaygroundsAppIcon.icns")) { image in
                    image.resizable()
                } placeholder: {
                    Color.secondary
                }
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(width: 75, height: 75)
            } else {
                Image(nsImage: Utils().createImageData(fileImagePath: "/Applications/Playgrounds.app/Contents/Resources/PlaygroundsAppIcon.icns"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 75, height: 75)
            }
            Spacer()
            if #available(macOS 12.0, *) {
                AsyncImage(url: URL(string: "file:///Users/Shared/github.png")) { image in
                    image.resizable()
                } placeholder: {
                    Color.secondary
                }
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(width: 100, height: 25)
            } else {
                Image(nsImage: Utils().createImageData(fileImagePath: "/Users/Shared/github.png"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 100, height: 25)
            }
        }
        .frame(width: 975)
        .padding(.top, 24)
    }
}

// Company Text
struct CompanyText: View {
    var body: some View {
        VStack(spacing: 5) {
            // Title
            HStack {
                Spacer()
                Text("Setting up your Mac...")
                    .foregroundColor(.primary)
                    .font(.title)
                    .fontWeight(.medium)
                Spacer()
            }
            // Body
            HStack {
                Text("Your Mac is being automatically configured by your organization. This process may take some time to complete. Please don't attempt to restart or shut down the computer unless you are prompted to do so.")
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 500, alignment: .leading)
        }
    }
}

// CoreStatus
struct CoreStatus: View {
    var body: some View {
        HStack {
            List(0..<10) { i in
                VStack {
                    HStack(spacing: 20) {
                        Text("\(i+1)")
                            .font(.body)
                        if i == 0 {
                            Image(nsImage: Utils().createImageData(fileImagePath: "/Applications/GitHub Desktop.app/Contents/Resources/electron.icns"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text("Github Desktop")
                                .font(.body)
                                .fontWeight(.bold)
                                .frame(width: 700, alignment: .leading)
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("Completed")
                        }
                        if i == 1 {
                            Image(nsImage: Utils().createImageData(fileImagePath: "/Applications/Slack.app/Contents/Resources/electron.icns"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text("Slack")
                                .font(.body)
                                .fontWeight(.bold)
                                .frame(width: 700, alignment: .leading)
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("Completed")
                        }
                        if i == 2 {
                            Image(nsImage: Utils().createImageData(fileImagePath: "/Applications/Visual Studio Code.app/Contents/Resources/Code.icns"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text("Visual Studio Code")
                                .font(.body)
                                .fontWeight(.bold)
                                .frame(width: 700, alignment: .leading)
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
                        .frame(height: 1)
                }
            }
            .frame(width: 975)
        }
        .background(Color.secondary.opacity(0.5))
        .cornerRadius(10)
        .frame(width: 975, height: 325)
    }
}

// SecondaryStatus
struct SecondaryStatus: View {
    var body: some View {
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
                .frame(width: 30, height: 30)
                .padding(.leading, 25)
            Text("Visual Studio Code")
                .fontWeight(.bold)
            Text("is installing")
                .fontWeight(.light)
                .padding(.leading, -5)
            Spacer()
        }
        .padding(.top, -5)
        .frame(width: 975)
    }
}

// Horizontal Line
struct HorizontalLine: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 1)
        }
        .frame(width: 1000)
    }
}

struct ContentView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            TopIcons()
            CompanyText()
            CoreStatus()
            HorizontalLine()
            SecondaryStatus()
        }
        .frame(width: 1000, height: 620) // + 24 pixels for the hidden titlebar
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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

