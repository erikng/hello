//
//  Utils.swift
//  hello
//
//  Created by Erik Gomez on 6/8/21.
//

import SwiftUI

// Define a set of placeholder colors
let placeholderColors: [Color] = [.red, .blue, .orange, .purple, .yellow, .green, .pink]

struct Utils {
    
    // Fetch and decode HelloPreferences from JSON
    func getHelloJSONPreferences() -> HelloPreferences? {
        let url = getHelloJSONURL()
        
        guard let url = URL(string: url) else { return nil }
        
        let data: Data?
        if url.scheme == "http" || url.scheme == "https" {
            data = try? Data(contentsOf: url)
        } else {
            data = FileManager.default.fileExists(atPath: url.path) ? try? Data(contentsOf: url) : nil
        }
        
        guard let jsonData = data else { return nil }
        
        do {
            return try HelloPreferences(data: jsonData)
        } catch {
            print("Failed to decode HelloPreferences: \(error)")
            return nil
        }
    }
    
    // Retrieve the JSON URL from UserDefaults
    func getHelloJSONURL() -> String {
        return helloDefaults.string(forKey: "json-url") ?? "file:///var/tmp/com.github.erikng.Hello.json"
    }

    // Open a URL in the default web browser
    func openMoreInfo(url: String) {
        guard let validURL = URL(string: url) else {
            guard let fallbackURL = URL(string: "https://apple.com") else { return }
            NSWorkspace.shared.open(fallbackURL)
            return
        }
        NSWorkspace.shared.open(validURL)
    }
    
    // Check if a file path exists
    func pathExists(_ path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }

    func isPkgInstalled(_ pkgReceipt: String) -> Bool {
        // Implement the logic to check if the package is installed
        let task = Process()
        task.launchPath = "/usr/sbin/pkgutil"
        task.arguments = ["--pkg-info", pkgReceipt]
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        let output = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
        return !output.isEmpty
    }

    func isProfileInstalled(_ profileIdentifier: String) -> Bool {
        let xmlString = getProfilesPlist()
        
        guard let data = xmlString.data(using: .utf8) else {
            print("Error converting XML string to Data")
            return false
        }
        
        do {
            let xmlDoc = try XMLDocument(data: data)
            let nodes = try xmlDoc.nodes(forXPath: "//ProfileIdentifier")
            
            for node in nodes {
                if let identifier = node.stringValue, identifier == profileIdentifier {
                    return true
                }
            }
        } catch {
            print("Error parsing XML: \(error)")
        }
        
        return false
    }

    // Check if a CFBundleVersion matches
    func isCFBundleVersionMatching(path: String, version: String) -> Bool {
        guard let bundle = Bundle(path: path) else { return false }
        let bundleVersion = bundle.infoDictionary?["CFBundleVersion"] as? String
        return bundleVersion == version
    }

    // Check if an item is installed based on its type
    func isItemInstalled(installedType: String, installedValue: String, installedVersion: String? = nil) -> Bool {
        switch installedType {
        case "path":
            return pathExists(installedValue)
        case "profile":
            return isProfileInstalled(installedValue)
        case "pkg-receipt":
            return isPkgInstalled(installedValue)
        case "CFBundleVersion":
            guard installedVersion != nil else {
                print("Version is required for CFBundleVersion type")
                return false
            }
            return isCFBundleVersionMatching(path: installedValue, version: installedVersion!)
        default:
            return false
        }
    }

    func getProfilesPlist() -> String {
        let command = "/usr/bin/profiles"
        let arguments = ["-C", "-o", "stdout-xml"]
        return executeShellCommand(command, arguments: arguments)
    }

    func executeShellCommand(_ command: String, arguments: [String]) -> String {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: command)
        process.arguments = arguments

        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe

        do {
            try process.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            print("Error executing command: \(error)")
            return ""
        }
    }
    
    // Quit or restart the application based on the restart style
    func quit() {
        if restartStyle == "None" {
            AppKit.NSApp.terminate(nil)
        } else {
            let script: String
            switch restartStyle {
            case "Notify":
                script = "tell app \"loginwindow\" to «event aevtrrst»"
            case "Immediate":
                script = "tell app \"System Events\" to restart"
            default:
                script = ""
            }
            
            let task = Process()
            task.launchPath = "/usr/bin/osascript"
            task.arguments = ["-e", script]
            
            do {
                try task.run()
            } catch {
                print("Error processing reboot: \(error)")
            }
            
            AppKit.NSApp.terminate(nil)
        }
    }
    
    // Return a random placeholder color
    func randomPlaceholderColor() -> Color {
        placeholderColors.randomElement() ?? .gray
    }
    
    // Helper function to execute a shell command and return its exit status
    private func executeTask(_ launchPath: String, _ arguments: [String]) -> Int32 {
        let task = Process()
        task.launchPath = launchPath
        task.arguments = arguments
        
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        
        task.standardOutput = outputPipe
        task.standardError = errorPipe
        
        do {
            try task.run()
        } catch {
            print("Error executing task: \(error)")
            return -1
        }
        
        task.waitUntilExit()
        return task.terminationStatus
    }
}
