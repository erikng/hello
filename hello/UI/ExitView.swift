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
            // Hero exit logo
            ZStack {
                ExitTopDetails(font: .title2, imageHeight: 35, imageWidth: 35, xOffset: -65, yOffSet: 0, symbolName: "person.crop.circle.badge.checkmark", zIndex: -2)
                ExitTopDetails(font: .title, imageHeight: 40, imageWidth: 40, xOffset: -35, yOffSet: -20, symbolName: "tray.full.fill", zIndex: -1)
                ExitTopDetails(font: .largeTitle, imageHeight: 45, imageWidth: 45, xOffset: 0, yOffSet: 0, symbolName: "checkmark.seal.fill", zIndex: 0)
                ExitTopDetails(font: .largeTitle, imageHeight: 45, imageWidth: 45, xOffset: 35, yOffSet: -20, symbolName: "link.circle.fill", zIndex: -1)
                ExitTopDetails(font: .title, imageHeight: 40, imageWidth: 40, xOffset: 65, yOffSet: 0, symbolName: "arrow.down.doc.fill", zIndex: -2)
                ExitTopDetails(font: .title2, imageHeight: 35, imageWidth: 35, xOffset: 95, yOffSet: -20, symbolName: "folder.fill", zIndex: -3)
            }
            
            Text(exitText)
                .font(.largeTitle)
            // Body
            HStack {
                Text(exitScreenBodyText)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 495, alignment: .leading)
        }
    }
}

struct ExitTopDetails: View {
    var font: Font
    var imageHeight, imageWidth, xOffset, yOffSet: CGFloat
    var symbolName: String
    var zIndex: Double
    
    var body: some View {
        Image(systemName: symbolName)
            .font(font)
            .foregroundColor(.accentColor)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: imageWidth, height: imageHeight)
                    .foregroundColor(Color(NSColor.textBackgroundColor))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 3)
                    .opacity(0.4)
                    .frame(width: imageWidth, height: imageHeight)
            )
            .offset(x: xOffset, y: yOffSet)
            .zIndex(zIndex)
    }
}

struct ExitMiddle: View {
    var body: some View {
        HStack(spacing: 20) {
            if !exitScreenItem1Title.isEmpty {
                ExitMiddleDetails(buttonText: exitScreenItem1ButtonText, description: exitScreenItem1DescriptionText, imagePath: exitScreenItem1ImagePath, launchURL: exitScreenItem1LaunchURL, title: exitScreenItem1Title)
            }
            if !exitScreenItem2Title.isEmpty {
                ExitMiddleDetails(buttonText: exitScreenItem2ButtonText, description: exitScreenItem2DescriptionText, imagePath: exitScreenItem2ImagePath, launchURL: exitScreenItem2LaunchURL, title: exitScreenItem2Title)
            }
            if !exitScreenItem3Title.isEmpty {
                ExitMiddleDetails(buttonText: exitScreenItem3ButtonText, description: exitScreenItem3DescriptionText, imagePath: exitScreenItem3ImagePath, launchURL: exitScreenItem3LaunchURL, title: exitScreenItem3Title)
            }
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
                Text(quitButtonText)
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(minWidth: 0, maxWidth: 500, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color(NSColor.underPageBackgroundColor)))
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
