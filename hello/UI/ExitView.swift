//
//  ExitView.swift
//  hello
//
//  Created by Erik Gomez on 6/11/21.
//

import SwiftUI

struct ExitView: View {
    @ObservedObject var settings: HelloHelper
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            TopIcons(settings: settings)
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
            HeroExitLogo()
            Text(exitText)
                .font(.largeTitle)
            Text(exitScreenBodyText)
                .foregroundColor(.secondary)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .frame(width: 495, alignment: .leading)
        }
    }
}

struct HeroExitLogo: View {
    let details = [
        (font: Font.title2, size: 35, offset: CGPoint(x: -65, y: 0), symbol: "person.crop.circle.badge.checkmark", zIndex: -2),
        (font: Font.title, size: 40, offset: CGPoint(x: -35, y: -20), symbol: "tray.full.fill", zIndex: -1),
        (font: Font.largeTitle, size: 45, offset: CGPoint(x: 0, y: 0), symbol: "checkmark.seal.fill", zIndex: 0),
        (font: Font.largeTitle, size: 45, offset: CGPoint(x: 35, y: -20), symbol: "link.circle.fill", zIndex: -1),
        (font: Font.title, size: 40, offset: CGPoint(x: 65, y: 0), symbol: "arrow.down.doc.fill", zIndex: -2),
        (font: Font.title2, size: 35, offset: CGPoint(x: 95, y: -20), symbol: "folder.fill", zIndex: -3)
    ]
    
    var body: some View {
        ZStack {
            ForEach(details, id: \.symbol) { detail in
                ExitTopDetails(
                    font: detail.font,
                    size: CGFloat(detail.size),
                    offset: detail.offset,
                    symbolName: detail.symbol,
                    zIndex: Double(detail.zIndex)
                )
            }
        }
    }
}

struct ExitTopDetails: View {
    var font: Font
    var size: CGFloat
    var offset: CGPoint
    var symbolName: String
    var zIndex: Double
    
    var body: some View {
        Image(systemName: symbolName)
            .font(font)
            .foregroundColor(.accentColor)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: size, height: size)
                    .foregroundColor(Color(NSColor.textBackgroundColor))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 3)
                    .opacity(0.4)
                    .frame(width: size, height: size)
            )
            .offset(x: offset.x, y: offset.y)
            .zIndex(zIndex)
    }
}

struct ExitMiddle: View {
    var body: some View {
        HStack(spacing: 20) {
            ForEach(exitScreenItems, id: \.title) { item in
                ExitMiddleDetails(item: item)
            }
        }
    }
}

struct ExitMiddleDetails: View {
    var item: ExitScreenItem2
    
    var body: some View {
        VStack(spacing: 7.5) {
            AsyncImage(url: URL(string: item.imagePath)) { image in
                image.resizable()
            } placeholder: {
                Utils().randomPlaceholderColor()
                    .opacity(0)
            }
            .aspectRatio(contentMode: .fit)
            .scaledToFit()
            .frame(width: 40, alignment: .center)
            
            Text(item.title)
                .font(.body)
                .fontWeight(.bold)
            
            Text(item.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(width: 150, alignment: .center)
            
            Button(action: {
                Utils().openMoreInfo(url: item.launchURL)
            }) {
                Text(item.buttonText)
                    .foregroundColor(.accentColor)
                    .font(.headline)
                    .padding()
                    .frame(width: 100, height: 25, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 15)
                        .fill(Color(NSColor.windowBackgroundColor)))
                    .padding(.bottom)
            }
            .buttonStyle(.link)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 175, height: 175)
                .foregroundColor(Color(NSColor.textBackgroundColor))
        )
        .frame(width: 175, height: 175)
    }
}

struct ExitBottom: View {
    var body: some View {
        HStack {
            Button(action: {
                Utils().quit()
            }) {
                Text(restartStyle == "None" ? quitButtonText : restartButtonText)
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 15)
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
        ExitView(settings: HelloHelper())
    }
}

struct ExitScreenItem2 {
    var buttonText: String
    var description: String
    var imagePath: String
    var launchURL: String
    var title: String
}

// Computed property for exit screen items
var exitScreenItems: [ExitScreenItem2] {
    [
        ExitScreenItem2(buttonText: exitScreenItem1ButtonText, description: exitScreenItem1DescriptionText, imagePath: exitScreenItem1ImagePath, launchURL: exitScreenItem1LaunchURL, title: exitScreenItem1Title),
        ExitScreenItem2(buttonText: exitScreenItem2ButtonText, description: exitScreenItem2DescriptionText, imagePath: exitScreenItem2ImagePath, launchURL: exitScreenItem2LaunchURL, title: exitScreenItem2Title),
        ExitScreenItem2(buttonText: exitScreenItem3ButtonText, description: exitScreenItem3DescriptionText, imagePath: exitScreenItem3ImagePath, launchURL: exitScreenItem3LaunchURL, title: exitScreenItem3Title)
    ].filter { !$0.title.isEmpty }
}
