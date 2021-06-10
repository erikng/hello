//
//  PrimaryStatus.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI

//TODO: Hook this into the JSON preferences file

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
        .cornerRadius(10)
        .frame(width: 876, height: 330)
    }
}

struct InstallStage: Identifiable {
    let id = UUID()
    let name: String
    let icon_path: String
    let status: String
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
                    Utils().randomPlaceholderColor()
                        .opacity(0.2)
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

let installStages = [
    InstallStage(
        name: "Xcode Command Line Tools",
        icon_path: "/System/Applications/Utilities/Terminal.app/Contents/Resources/Terminal.icns",
        status: "Installed"
    ),
    InstallStage(
        name: "Visual Studio Code",
        icon_path: "/Applications/Visual%20Studio%20Code.app/Contents/Resources/Code.icns",
        status: "Installed"
    ),
    InstallStage(
        name: "Slack",
        icon_path: "/Applications/Slack.app/Contents/Resources/electron.icns",
        status: "Installing"
    ),
    InstallStage(
        name: "GitHub Desktop",
        icon_path: "/Applications/GitHub%20Desktop.app/Contents/Resources/electron.icns",
        status: "Pending"
    )
]

#if DEBUG
struct PrimaryStatus_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryStatus()
    }
}
#endif
