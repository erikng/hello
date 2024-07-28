//
//  WelcomeView.swift
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
            welcomeButton
        }
        .frame(minWidth: 0, maxWidth: 600, alignment: .center)
    }
    
    private var welcomeButton: some View {
        Button(action: {
            settings.hasClickedwelcomeButtonText = true
        }) {
            Text(welcomeButtonText)
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Color.blue))
                .padding(.bottom)
        }
        .buttonStyle(.link)
    }
}

struct WelcomeTop: View {
    var body: some View {
        VStack {
            companyLogo
                .frame(width: 150, alignment: .center)
            Text(welcomeHeaderText)
                .font(.largeTitle)
            Text(welcomeSubHeaderText)
                .font(.largeTitle)
                .foregroundColor(.secondary)
        }
    }
    
    private var companyLogo: some View {
        Group {
            if companyLogoPath.isEmpty {
                Image("HelloIcon")
                    .resizable()
            } else {
                AsyncImage(url: URL(string: companyLogoPath)) { image in
                    image.resizable()
                } placeholder: {
                    Utils().randomPlaceholderColor().opacity(0)
                }
            }
        }
        .aspectRatio(contentMode: .fit)
        .scaledToFit()
    }
}

struct WelcomeMiddle: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(welcomeScreenItems, id: \.title) { item in
                WelcomeDetails(item: item)
            }
        }
    }
}

struct WelcomeDetails: View {
    var item: WelcomeScreenItem2
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: item.symbolName)
                .font(.largeTitle)
                .foregroundColor(.primary)
                .padding()
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(item.description)
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

struct WelcomeScreenItem2 {
    var title: String
    var description: String
    var symbolName: String
}

// Dummy data (you can replace this with actual data fetching)
let welcomeScreenItems = [
    WelcomeScreenItem2(title: welcomeScreenItem1Title, description: welcomeScreenItem1DescriptionText, symbolName: welcomeScreenItem1SymbolName),
    WelcomeScreenItem2(title: welcomeScreenItem2Title, description: welcomeScreenItem2DescriptionText, symbolName: welcomeScreenItem2SymbolName),
    WelcomeScreenItem2(title: welcomeScreenItem3Title, description: welcomeScreenItem3DescriptionText, symbolName: welcomeScreenItem3SymbolName)
]
