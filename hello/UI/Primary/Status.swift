//
//  Status.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI

//TODO: Hook this into the JSON preferences file

let helloRefreshCycleTimer = Timer.publish(every: Double(1), on: .main, in: .common).autoconnect()

// Status
struct Status: View {
    @State var refreshUI = false
    var body: some View {
        VStack {
            List(installStages1) { stage in
                VStack(alignment: .leading) {
                    StageRow(installstage: stage)
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 1)
                }
            }
            .cornerRadius(10)
            .frame(width: 876, height: 330)
        
            // Divider
            HStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: 1)
            }
            .frame(width: 900)
            
            // TODO: Learn Swift
            // This is fucking stupid
            Text(String(self.refreshUI))
                .hidden()
                .frame(width: 0, height: 0)
                .onReceive(helloRefreshCycleTimer) { _ in
                    self.refreshUI.toggle()
                }
            
            // Secondary Status
            // TODO: Figure out if this object can be pushed down about 20 pixels so it matches the top part
            HStack {
                Image(nsImage: Utils().createImageData(fileImagePath: "/Applications/Slack.app/Contents/Resources/electron.icns"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.leading, 15)
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
}

struct InstallStage: Codable, Identifiable {
    var id = UUID()
    let title: String
    let iconPath: String
    let installedPath: String
    var deviceStage = [DeviceStage]()
}

// Stage Status (Dynamic Row)
struct StageRow: View {
    var installstage: InstallStage
    @State var refreshUI = false
    var body: some View {
        HStack {
            // Icon
            if #available(macOS 12.0, *) {
                AsyncImage(url: URL(string: "file://\(installstage.iconPath)")) { image in
                    image.resizable()
                } placeholder: {
                    Utils().randomPlaceholderColor()
                        .opacity(0.2)
                }
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(width: 40, height: 40)
            } else {
                Image(nsImage: Utils().createImageData(fileImagePath: "\(installstage.iconPath)"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            // TODO: Learn Swift
            // This is fucking stupid
            Text(String(self.refreshUI))
                .hidden()
                .frame(width: 0, height: 0)
                .onReceive(helloRefreshCycleTimer) { _ in
                    self.refreshUI.toggle()
                }

            // Stage Name
            Text("\(installstage.title)")
                .font(.body)
                .fontWeight(.bold)
            
            Spacer()
            
            // Current Stage Status
            if Utils().pathExists(path: installstage.installedPath) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                Text("Installed")
                    .frame(width: 75)
            // TODO: Figure out how to make this work
//            } else if installstage.status == "Installing" {
//                ProgressView()
//                    .progressViewStyle(.circular)
//                    .scaleEffect(0.4)
//                Text("Installing")
//                    .frame(width: 75)
            } else {
                Image(systemName: "gear.circle.fill")
                    .foregroundColor(.secondary)
                Text("Pending")
                    .frame(width: 75)
            }
        }
    }
}

let installStages = deviceStages

let installStages1 = [
    InstallStage(
        title: "Xcode Command Line Tools",
        iconPath: "/System/Applications/Utilities/Terminal.app/Contents/Resources/Terminal.icns",
        installedPath: "/Applications/Xcode.app"
    ),
    InstallStage(
        title: "Visual Studio Code",
        iconPath: "/Applications/Visual%20Studio%20Code.app/Contents/Resources/Code.icns",
        installedPath: "/Applications/Visual Studio Code.app"
    ),
    InstallStage(
        title: "Slack",
        iconPath: "/Applications/Slack.app/Contents/Resources/electron.icns",
        installedPath: "/Applications/Slack.app"
    ),
    InstallStage(
        title: "GitHub Desktop",
        iconPath: "/Applications/GitHub%20Desktop.app/Contents/Resources/electron.icns",
        installedPath: "/Applications/GitHub Desktop.app"
    )
]

#if DEBUG
struct Status_Previews: PreviewProvider {
    static var previews: some View {
        Status()
    }
}
#endif
