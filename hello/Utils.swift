//
//  Utils.swift
//  hello
//
//  Created by Erik Gomez on 6/8/21.
//

import AppKit
import Foundation
import SystemConfiguration
import SwiftUI

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

    func openMoreInfo(url: String) {
        NSWorkspace.shared.open(URL(string: url) ?? URL(string: "https://apple.com")!)
    }
}
