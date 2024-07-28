//
//  TopIcons.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI

// TopIcons
struct TopIcons: View {
    @ObservedObject var settings: HelloHelper
    var body: some View {
        HStack(alignment: .top) {
            if companyLogoPath2.isEmpty {
                Image("HelloIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 75, height: 75)
            } else {
                AsyncImage(url: URL(string: companyLogoPath2)) { image in
                    image.resizable()
                } placeholder: {
                    Utils().randomPlaceholderColor()
                        .opacity(0)
                }
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(width: 75, height: 75)
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
        TopIcons(settings: HelloHelper())
    }
}
#endif
