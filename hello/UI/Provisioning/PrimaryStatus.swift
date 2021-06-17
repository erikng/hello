//
//  PrimaryStatus.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI

// Status
struct PrimaryStatus: View {
    @ObservedObject var settings: HelloHelper
    var body: some View {
        VStack {
            List(deviceStages) { stage in
                VStack(alignment: .leading) {
                    StageRow(settings: settings, installstage: stage)
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 1)
                }
            }
            .cornerRadius(10)
            .frame(width: 876, height: 320)
        }
    }
}

// Stage Status (Dynamic Row)
struct StageRow: View {
    @ObservedObject var settings: HelloHelper
    var installstage: DeviceStage
    var body: some View {
        HStack {
            // Icon
            // TODO: Figure out how to refresh AsyncImage if it fails to download the first time
            if #available(macOS 12.0, *) {
                AsyncImage(url: URL(string: installstage.iconPath)) { image in
                    image.resizable()
                } placeholder: {
                    Utils().randomPlaceholderColor()
                        .opacity(0.2)
                }
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(width: 40, height: 40)
            } else {
                Image(nsImage: Utils().createImageData(fileImagePath: installstage.iconPath))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }

            // Stage Name
            Text(installstage.title)
                .font(.body)
                .fontWeight(.bold)
            
            Spacer()
            
            // Current Stage Status
            if Utils().pathExists(path: installstage.installedPath) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                Text("Installed")
                    .frame(width: 75)
                    .onAppear {
                        settings.applicationState[installstage.id] = "installed"
                    }
            } else {
                // First application in run - send state
                // TODO: Figure out why this logic does not work when running with welcomeScreen
                if settings.applicationState.isEmpty {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(0.4)
                    Text("Installing")
                        .frame(width: 75)
                        .onAppear {
                            settings.applicationState[installstage.id] = "installing"
                            settings.applicationInstalling = installstage.title
                            settings.applicationInstallingIconPath = installstage.iconPath
                        }
                // Application has already sent its state so we want to show this view - no need to resend state
                } else if settings.applicationState[installstage.id] == "installing" {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(0.4)
                    Text("Installing")
                        .frame(width: 75)
                // No application is currently installing - send state
                } else if settings.applicationState[installstage.id-1] == "installed" {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(0.4)
                    Text("Installing")
                        .frame(width: 75)
                        .onAppear {
                            settings.applicationState[installstage.id] = "installing"
                            settings.applicationInstalling = installstage.title
                            settings.applicationInstallingIconPath = installstage.iconPath
                        }
                } else {
                    Image(systemName: "gear.circle.fill")
                        .foregroundColor(.secondary)
                    Text("Pending")
                        .frame(width: 75)
                        .onAppear {
                            settings.applicationState[installstage.id] = "pending"
                        }
                }
            }
        }
    }
}

#if DEBUG
struct Status_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryStatus(settings: HelloHelper())
    }
}
#endif
