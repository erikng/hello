//
//  Intro.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI

// Inspired from https://betterprogramming.pub/creating-an-apple-like-splash-screen-in-swiftui-fdeb36b47e81

struct WelcomeView: View {
    @ObservedObject var settings: HelloHelper
    
    var body: some View {
        VStack(alignment: .center) {
            WelcomeTop()
                .padding(.top, 35)
            WelcomeMiddle()
            Button(action: {
                settings.hasClickedWelcomeButton = true
            }) {
                Text(welcomeButton)
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.blue))
                    .padding(.bottom)
            }
            .buttonStyle(.link)
        }
        .frame(minWidth: 0, maxWidth: 600, alignment: .center)
    }
}

struct WelcomeTop: View {
    var body: some View {
        VStack {
            if #available(macOS 12.0, *) {
                if companyLogoPath.isEmpty {
                    Image("HelloIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 150, alignment: .center)
                } else {
                    AsyncImage(url: URL(string: companyLogoPath)) { image in
                        image.resizable()
                    } placeholder: {
                        Utils().randomPlaceholderColor()
                            .opacity(0.2)
                    }
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 150, alignment: .center)
                }
            } else {
                if companyLogoPath.isEmpty {
                    Image("HelloIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 150, alignment: .center)
                } else {
                    Image(nsImage: Utils().createImageData(fileImagePath: companyLogoPath))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 150, alignment: .center)
                }
            }

            Text(welcomeHeader)
                .font(.largeTitle)

            Text(welcomeBody)
                .font(.largeTitle)
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeMiddle: View {
    var body: some View {
        VStack(alignment: .leading) {
            WelcomeDetails(title: welcomeScreenItem1Title, description: welcomeScreenItem1Description, imageName: welcomeScreenItem1ImageName)

            WelcomeDetails(title: welcomeScreenItem2Title, description: welcomeScreenItem2Description, imageName: welcomeScreenItem2ImageName)

            WelcomeDetails(title: welcomeScreenItem3Title, description: welcomeScreenItem3Description, imageName: welcomeScreenItem3ImageName)
        }
    }
}

struct WelcomeDetails: View {
    var title: String
    var description: String
    var imageName: String

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(.primary)
                .padding()

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

#if DEBUG
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(settings: HelloHelper())
    }
}
#endif
