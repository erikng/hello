//
//  PrimaryStatus.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI

struct PrimaryStatus: View {
    @ObservedObject var settings: HelloHelper
    
    var body: some View {
        VStack {
            List(deviceStages) { stage in
                VStack(alignment: .leading) {
                    StageRow(settings: settings, installStage: stage)
                    Divider()
                }
            }
            .cornerRadius(10)
            .frame(width: 876, height: 320)
        }
    }
}

struct StageRow: View {
    @ObservedObject var settings: HelloHelper
    var installStage: DeviceStage
    @State private var installedPkg = false
    @State private var installedProfile = false
    
    var body: some View {
        HStack {
            asyncImage
            Text(installStage.title)
                .font(.body)
                .fontWeight(.bold)
            Spacer()
            currentStageStatus
        }
        .onAppear {
            checkInstallationStatus()
        }
    }
    
    private var asyncImage: some View {
        AsyncImage(url: URL(string: installStage.iconPath)) { image in
            image.resizable()
        } placeholder: {
            Utils().randomPlaceholderColor().opacity(0)
        }
        .aspectRatio(contentMode: .fit)
        .scaledToFit()
        .frame(width: 40, height: 40)
    }
    
    private var currentStageStatus: some View {
        Group {
            if Utils().isItemInstalled(installedType: installStage.installedType, installedValue: installStage.installedValue, installedVersion: installStage.installedVersion) {
                statusView(image: "checkmark.circle.fill", text: "Installed", color: .green)
                    .onAppear {
                        settings.applicationState[installStage.id] = "installed"
                    }
            } else {
                stageStatus
            }
        }
        .frame(width: 75)
    }
    
    private var stageStatus: some View {
        Group {
            if settings.applicationState.isEmpty && installStage.id == 1 {
                progressView(text: "Installing")
                    .onAppear {
                        updateState(for: installStage.id, state: "installing")
                    }
            } else if settings.applicationState[installStage.id] == "installing" {
                progressView(text: "Installing")
            } else if settings.applicationState[installStage.id - 1] == "installed" {
                progressView(text: "Installing")
                    .onAppear {
                        updateState(for: installStage.id, state: "installing")
                    }
            } else {
                statusView(image: "gear.circle.fill", text: "Pending", color: .secondary)
                    .onAppear {
                        settings.applicationState[installStage.id] = "pending"
                    }
            }
        }
    }
    
    private func progressView(text: String) -> some View {
        VStack {
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(0.4)
            Text(text)
        }
    }
    
    private func statusView(image: String, text: String, color: Color) -> some View {
        VStack {
            Image(systemName: image)
                .foregroundColor(color)
            Text(text)
        }
    }
    
    private func updateState(for id: Int, state: String) {
        settings.applicationState[id] = state
        settings.applicationInstalling = installStage.title
        settings.applicationInstallingIconPath = installStage.iconPath
    }
    
    private func checkInstallationStatus() {
        DispatchQueue.main.async {
            _ = Utils().isItemInstalled(installedType: installStage.installedType, installedValue: installStage.installedValue, installedVersion: installStage.installedVersion)
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
