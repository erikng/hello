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
    func pathExists(path: String) -> Bool {
        FileManager.default.fileExists(atPath: path)
    }

    // Check if a package receipt exists
    func pkgInfo(receipt: String) -> Bool {
        return executeTask("/usr/sbin/pkgutil", ["--pkg-info", receipt]) == 0
    }
    
    // Check if a profile exists
    func profiles(receipt: String) -> Bool {
        return executeTask("/usr/bin/profiles", ["-C", "|", "/usr/bin/grep", receipt]) == 0
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
