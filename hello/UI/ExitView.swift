//
//  ExitView.swift
//  hello
//
//  Created by Erik Gomez on 6/11/21.
//

import SwiftUI

struct ExitView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            // Icons
            TopIcons()
            ExitTop()
            HStack(spacing: 20) {
                if !exitScreenItem1Title.isEmpty {
                    ExitMiddleDetails(buttonText: exitScreenItem1ButtonText, description: exitScreenItem1Description, imagePath: exitScreenItem1ImagePath, launchURL: exitScreenItem1LaunchURL, title: exitScreenItem1Title)
                }
                if !exitScreenItem2Title.isEmpty {
                    ExitMiddleDetails(buttonText: exitScreenItem2ButtonText, description: exitScreenItem2Description, imagePath: exitScreenItem2ImagePath, launchURL: exitScreenItem2LaunchURL, title: exitScreenItem2Title)
                }
                if !exitScreenItem3Title.isEmpty {
                    ExitMiddleDetails(buttonText: exitScreenItem3ButtonText, description: exitScreenItem3Description, imagePath: exitScreenItem3ImagePath, launchURL: exitScreenItem3LaunchURL, title: exitScreenItem3Title)
                }
            }
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

struct ExitMiddleDetails: View {
    var buttonText: String
    var description: String
    var imagePath: String
    var launchURL: String
    var title: String
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(spacing: 7.5) {
                if #available(macOS 12.0, *) {
                    AsyncImage(url: URL(string: imagePath)) { image in
                        image.resizable()
                    } placeholder: {
                        Utils().randomPlaceholderColor()
                            .opacity(0)
                    }
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 40, alignment: .center)
                } else {
                    Image(nsImage: Utils().createImageData(fileImagePath: imagePath))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 40, alignment: .center)
                }
                Text(title)
                    .font(.body)
                    .fontWeight(.bold)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(width: 150, alignment: .center)
                Button(action: {
                    Utils().openMoreInfo(url:  launchURL)
                }) {
                    Text(buttonText)
                        .foregroundColor(.accentColor)
                        .font(.headline)
                        .padding()
                        .frame(width: 100, height: 25, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color(NSColor.windowBackgroundColor)))
                        .padding(.bottom)
                }
                .buttonStyle(.link)
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 175, height: 175)
                    .foregroundColor(Color(NSColor.textBackgroundColor)
                ))
            .frame(width: 175, height: 175)
        }
    }
}

struct ExitBottom: View {
    var body: some View {
        HStack {
            Button(action: {
                AppKit.NSApp.terminate(nil)
            }) {
                Text("Quit")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(minWidth: 0, maxWidth: 500, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.blue))
                    .padding(.bottom)
            }
            .buttonStyle(.link)
            .keyboardShortcut(.defaultAction)
            
        }
    }
}

struct ExitView_Previews: PreviewProvider {
    static var previews: some View {
        ExitView()
    }
}
