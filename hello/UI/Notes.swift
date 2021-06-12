//
//  Notes.swift
//  hello
//
//  Created by Erik Gomez on 6/12/21.
//

import SwiftUI

struct Notes: View {
    var text = "These are some notes from links that helped this project come to life."
    var body: some View {
        Text(text)
        // https://stackoverflow.com/questions/67304592/how-to-reliably-retrieve-a-windows-background-color-on-macos-with-swiftui
    }
}

struct Notes_Previews: PreviewProvider {
    static var previews: some View {
        Notes()
    }
}
