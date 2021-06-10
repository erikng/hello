//
//  Stages.swift
//  hello
//
//  Created by Erik Gomez on 6/9/21.
//

import Foundation

struct InstallStage: Identifiable {
    let id = UUID()
    let name: String
    let icon_path: String
    let status: String
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
