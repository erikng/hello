//
//  Status.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI

// Status
struct Status: View {
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
        
            Divider()
            
            // Secondary Status
            if settings.applicationInstalling == "Initializing" {
                HStack {
                    Image(systemName: "circle.dashed.inset.filled")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .foregroundColor(.primary)
                        .frame(width: 30, height: 30)
                        .padding(.leading, 15)
                    Text(welcomeSubHeaderText)
                        .fontWeight(.bold)
                    Text("is initializing")
                        .fontWeight(.light)
                        .padding(.leading, -5)
                    Spacer()
                }
                .frame(width: 876)
            } else if settings.applicationInstalling.isEmpty {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .foregroundColor(.green)
                        .frame(width: 30, height: 30)
                        .padding(.leading, 15)
                    Text(exitText)
                        .fontWeight(.bold)
                    Spacer()
                    if disableExitScreen {
                        // Normal Quit button
                        Button(action: {
                            AppKit.NSApp.terminate(nil)
                        }) {
                            Text(quitButtonText)
                        }
                        .keyboardShortcut(.defaultAction)
                    }

                }
                .frame(width: 876)
            } else {
                HStack {
                    if #available(macOS 12.0, *) {
                        AsyncImage(url: URL(string: settings.applicationInstallingIconPath)) { image in
                            image.resizable()
                        } placeholder: {
                            Utils().randomPlaceholderColor()
                                .opacity(0.2)
                        }
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(.leading, 15)
                    } else {
                        Image(nsImage: Utils().createImageData(fileImagePath: settings.applicationInstallingIconPath))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding(.leading, 15)
                    }
                    Text(settings.applicationInstalling)
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
}

// Stage Status (Dynamic Row)
struct StageRow: View {
    @ObservedObject var settings: HelloHelper
    var installstage: DeviceStage
    @State var refreshUI = false
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
                if settings.applicationInstalling == installstage.title {
                    // TODO: Learn Swift - This is fucking stupid
                    Text("")
                        .hidden()
                        .frame(width: 0, height: 0)
                        .onAppear {
                            settings.applicationInstalling = ""
                        }
                }
            } else {
                if settings.applicationInstalling == installstage.title || settings.applicationInstalling == "Initializing" || settings.applicationInstalling.isEmpty {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(0.4)
                    Text("Installing")
                        .frame(width: 75)
                        .onAppear {
                            settings.applicationInstalling = installstage.title
                            settings.applicationInstallingIconPath = installstage.iconPath
                        }
                } else {
                    Image(systemName: "gear.circle.fill")
                        .foregroundColor(.secondary)
                    Text("Pending")
                        .frame(width: 75)
                }
            }
        }
    }
}

#if DEBUG
struct Status_Previews: PreviewProvider {
    static var previews: some View {
        Status(settings: HelloHelper())
    }
}
#endif
