//
//  TopIcons.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI

// TopIcons
struct TopIcons: View {
    var body: some View {
        HStack(alignment: .top) {
            if #available(macOS 12.0, *) {
                if companyLogoPath.isEmpty {
                    Image("HelloIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                } else {
                    AsyncImage(url: URL(string: companyLogoPath)) { image in
                        image.resizable()
                    } placeholder: {
                        Utils().randomPlaceholderColor()
                            .opacity(0.2)
                    }
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                }
            } else {
                if companyLogoPath.isEmpty {
                    Image("HelloIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                } else {
                    Image(nsImage: Utils().createImageData(fileImagePath: companyLogoPath))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                }
            }
            
            Spacer()
            
            // More Info
            Button {
                Utils().openMoreInfo(url: aboutURL)
            } label: {
                Image(systemName: "questionmark.circle")
            }
            .padding(.top, 4)
            .buttonStyle(.link)
        }
        .frame(width: 890) // real width is 1014
    }
}

#if DEBUG
struct TopIcons_Previews: PreviewProvider {
    static var previews: some View {
        TopIcons()
    }
}
#endif
