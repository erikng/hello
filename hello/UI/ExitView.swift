//
//  ExitView.swift
//  hello
//
//  Created by Erik Gomez on 6/11/21.
//

import SwiftUI

struct ExitView: View {
    var body: some View {
        VStack(alignment: .center) {
            // Icons
            TopIcons()
                .padding(.top, 35)
            ExitTop()
            ExitMiddle()
            Divider()
            ExitBottom()
            
        }
        .frame(minWidth: 0, maxWidth: 600, alignment: .center)
    }
}

struct ExitTop: View {
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "person.crop.circle.badge.checkmark")
                    .font(.title2)
                    .foregroundColor(.accentColor)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 35, height: 35)
                            .foregroundColor(Color(NSColor.textBackgroundColor))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 3)
                            .opacity(0.4)
                            .frame(width: 35, height: 35)
                    )
                    .zIndex(3)
                    .offset(x: -65, y: 0)
                Image(systemName: "tray.full.fill")
                    .font(.title)
                    .foregroundColor(.accentColor)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color(NSColor.textBackgroundColor))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 3)
                            .opacity(0.4)
                            .frame(width: 40, height: 40)
                    )
                    .zIndex(4)
                    .offset(x: -35, y: -20)
                Image(systemName: "checkmark.seal.fill")
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 45, height: 45)
                            .foregroundColor(Color(NSColor.textBackgroundColor))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 3)
                            .opacity(0.4)
                            .frame(width: 45, height: 45)
                    )
                    .zIndex(5)
                
                Image(systemName: "link.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 45, height: 45)
                            .foregroundColor(Color(NSColor.textBackgroundColor))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 3)
                            .opacity(0.4)
                            .frame(width: 45, height: 45)
                    )
                    .zIndex(4)
                    .offset(x: 35, y: -20)
                Image(systemName: "arrow.down.doc.fill")
                    .font(.title)
                    .foregroundColor(.accentColor)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color(NSColor.textBackgroundColor))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 3)
                            .opacity(0.4)
                            .frame(width: 40, height: 40)
                    )
                    .zIndex(3)
                    .offset(x: 65, y: 0)
                Image(systemName: "folder.fill")
                    .font(.title2)
                    .foregroundColor(.accentColor)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 35, height: 35)
                            .foregroundColor(Color(NSColor.textBackgroundColor))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 3)
                            .opacity(0.4)
                            .frame(width: 35, height: 35)
                    )
                    .zIndex(0)
                    .offset(x: 95, y: -20)
            }
            
            Text("Setup complete")
                .font(.largeTitle)
            // Body
            HStack {
                Text("Your Mac has been successfully configured. Below are a few resources to help you get started.")
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 495, alignment: .leading)
        }
    }
}

struct ExitMiddle: View {
    var body: some View {
        VStack(alignment: .leading) {
            WelcomeDetails(title: welcomeScreenItem1Title, description: welcomeScreenItem1Description, imageName: welcomeScreenItem1ImageName)

            WelcomeDetails(title: welcomeScreenItem2Title, description: welcomeScreenItem2Description, imageName: welcomeScreenItem2ImageName)

            WelcomeDetails(title: welcomeScreenItem3Title, description: welcomeScreenItem3Description, imageName: welcomeScreenItem3ImageName)
        }
    }
}

struct ExitBottom: View {
    var body: some View {
        HStack {
            Spacer()
            // Normal Quit button
            Button(action: {
                AppKit.NSApp.terminate(nil)
            }) {
                Text("Quit")
            }
            .keyboardShortcut(.defaultAction)
        }
    }
}

struct ExitView_Previews: PreviewProvider {
    static var previews: some View {
        ExitView()
    }
}
