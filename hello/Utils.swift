//
//  Utils.swift
//  hello
//
//  Created by Erik Gomez on 6/8/21.
//

import SwiftUI

var placeholderColors: [Color] = [
    .red, .blue, .orange, .purple, .yellow, .green, .pink
]

struct Utils {
    func getHelloJSONPreferences() -> HelloPreferences? {
        let url = Utils().getHelloJSONURL()
        
        if url.contains("https://") || url.contains("http://") {
            if let json_url = URL(string: url) {
                if let data = try? Data(contentsOf: json_url) {
                    do {
                        let decodedData = try HelloPreferences(data: data)
                        return decodedData
                    } catch {
                        return nil
                    }
                }
            }
        }
        
        guard let fileURL = URL(string: url) else {
            return nil
        }
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let content = try Data(contentsOf: fileURL)
                let decodedData = try HelloPreferences(data: content)
                return decodedData
                
            } catch _ {
                return nil
            }
        }

        return nil
        
    }
    
    func getHelloJSONURL() -> String {
        return helloDefaults.string(forKey: "json-url") ?? "file:///var/tmp/com.github.erikng.Hello.json"
    }

    func openMoreInfo(url: String) {
        NSWorkspace.shared.open(URL(string: url) ?? URL(string: "https://apple.com")!)
    }
    
    func pathExists(path: String) -> Bool {
        FileManager.default.fileExists(atPath: path)
    }

    func pkgInfo(receipt: String) -> Bool {
        let task = Process()
        task.launchPath = "/usr/sbin/pkgutil"
        task.arguments = ["--pkg-info", receipt]
        
        let outputPipe = Pipe()
        let errorPipe = Pipe()

        task.standardOutput = outputPipe
        task.standardError = errorPipe

        do {
            try task.run()
        } catch {
            let msg = "Error processing pkgutil"
            print(msg)
            return false
        }
        
        task.waitUntilExit()

        if task.terminationStatus != 0 {
            return false
        } else {
            return true
        }

    }
    
    func quit() {
        if restartStyle == "None" {
            AppKit.NSApp.terminate(nil)
        } else {
            let task = Process()
            task.launchPath = "/usr/bin/osascript"
            if restartStyle == "Notify" {
                task.arguments = ["-e", "tell app \"loginwindow\" to «event aevtrrst»"]
            } else if restartStyle == "Immediate" {
                task.arguments = ["-e", "tell app \"System Events\" to restart"]
            }

            do {
                try task.run()
            } catch {
                let msg = "Error processing reboot"
                print(msg)
            }
            AppKit.NSApp.terminate(nil)
        }
    }
    
    func randomPlaceholderColor() -> Color {
      placeholderColors.randomElement()!
    }
}
