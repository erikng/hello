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
    func createImageData(fileImagePath: String) -> NSImage {
        let urlPath = NSURL(fileURLWithPath: fileImagePath)
        var imageData = NSData()
        do {
            imageData = try NSData(contentsOf: urlPath as URL)
        } catch {
            let errorImageConfig = NSImage.SymbolConfiguration(pointSize: 200, weight: .regular)
            return NSImage(systemSymbolName: "applelogo", accessibilityDescription: nil)!.withSymbolConfiguration(errorImageConfig)!
        }
        return NSImage(data: imageData as Data)!
    }
    
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
    
    func randomPlaceholderColor() -> Color {
      placeholderColors.randomElement()!
    }
}
