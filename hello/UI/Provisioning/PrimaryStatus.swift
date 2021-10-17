//
//  PrimaryStatus.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

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
    @State var installedPkg = false
    var body: some View {
        HStack {
            // Icon
            // TODO: Figure out how to refresh AsyncImage if it fails to download the first time
            if #available(macOS 12.0, *) {
                AsyncImage(url: URL(string: installstage.iconPath)) { image in
                    image.resizable()
                } placeholder: {
                    Utils().randomPlaceholderColor()
                        .opacity(0)
                }
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(width: 40, height: 40)
            } else {
                WebImage(url: URL(string: installstage.iconPath))
                        .renderingMode(.original)
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
            if Utils().pathExists(path: installstage.installedPath) || PkgInfo(receipt: installstage.installedPath) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                Text("Installed")
                    .frame(width: 75)
                    .onAppear {
                        settings.applicationState[installstage.id] = "installed"
                    }
            } else {
                // First stage - auto trigger installing
                if settings.applicationState.isEmpty && installstage.id == 1 {
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
                // Stage has already sent its state - no need to resend
                } else if settings.applicationState[installstage.id] == "installing" {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(0.4)
                    Text("Installing")
                        .frame(width: 75)
                // Previous stage has completed - trigger installing
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
                // Catchall for pending
                } else {
                    // Handle Big Sur and Monterey. A little janky.
                    let gearSymbol: Image? = Image(systemName: "gear.circle.fill")
                    let questionSymbol: Image? = Image(systemName: "questionmark.square.fill")
                    if gearSymbol != nil {
                        gearSymbol
                        .foregroundColor(.secondary)
                    } else {
                        questionSymbol
                        .foregroundColor(.secondary)
                    }
                    Text("Pending")
                        .frame(width: 75)
                        .onAppear {
                            settings.applicationState[installstage.id] = "pending"
                        }
                }
            }
        }
    }
    
    func PkgInfo(receipt: String) -> Bool {
        DispatchQueue.main.async {
            self.installedPkg = Utils().pkgInfo(receipt: receipt)
        }
        return self.installedPkg
    }
}

#if DEBUG
struct Status_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryStatus(settings: HelloHelper())
    }
}
#endif
