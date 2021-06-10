//
//  ContentView.swift
//  hello
//
//  Created by Erik Gomez on 6/8/21.
//

import SwiftUI

// ContentView
struct ContentView: View {
    var body: some View {
        VStack {
            TopIcons()
            CompanyText()
            PrimaryStatus()
            HorizontalLine()
            SecondaryStatus()
        }
        .frame(width: 900, height: 550)
        //.ignoresSafeArea(.all) - macOS 12.0 and higher only
        .edgesIgnoringSafeArea(.all)
    }
}

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
        .frame(width: 890) // real width is 1014
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
            .frame(width: 495, alignment: .leading)
        }
    }
}

// Stage Status (Dynamic Row)
struct StageRow: View {
    var installstage: InstallStage
    var body: some View {
        HStack {
            // Icon
            if #available(macOS 12.0, *) {
                AsyncImage(url: URL(string: "file://\(installstage.icon_path)")) { image in
                    image.resizable()
                } placeholder: {
                    Color.secondary
                }
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(width: 40, height: 40)
            } else {
                Image(nsImage: Utils().createImageData(fileImagePath: "\(installstage.icon_path)"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            // Stage Name
            Text("\(installstage.name)")
                .font(.body)
                .fontWeight(.bold)
            
            Spacer()
            
            // Current Stage Status
            if installstage.status == "Installed" {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else if installstage.status == "Installing" {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(0.4)
            } else if installstage.status == "Pending" {
                Image(systemName: "gear.circle.fill")
                    .foregroundColor(.secondary)
            }
            Text("\(installstage.status)")
                .frame(width: 75)
        }
    }
}

// PrimaryStatus
struct PrimaryStatus: View {
    var body: some View {
        List(installStages) { stage in
            VStack(alignment: .leading) {
                StageRow(installstage: stage)
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: 1)
            }
            
        }
        //.listStyle(.sidebar)
        .cornerRadius(10)
        .frame(width: 876, height: 330)
    }
}

// SecondaryStatus
// TODO: Make this actually work
// TODO: Figure out if this object can be pushed down about 20 pixels so it matches the top part
struct SecondaryStatus: View {
    var body: some View {
        HStack {
            Button {
                Utils().openMoreInfo(url: "https://github.com/erikng/hello")
            } label: {
                Image(systemName: "questionmark.circle")
            }
            .buttonStyle(.link)
            Image(nsImage: Utils().createImageData(fileImagePath: "/Applications/Slack.app/Contents/Resources/electron.icns"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(width: 30, height: 30)
            Text("Slack")
                .fontWeight(.bold)
            Text("is installing")
                .fontWeight(.light)
                .padding(.leading, -5)
            Spacer()
        }
        .frame(width: 876)
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
