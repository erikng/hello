//
//  TopIcons.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI

struct TopIcons: View {
    @ObservedObject var settings: HelloHelper
    
    var companyLogoImage: some View {
        Group {
            if companyLogoPath2.isEmpty {
                Image("HelloIcon")
                    .resizable()
            } else {
                AsyncImage(url: URL(string: companyLogoPath2)) { image in
                    image.resizable()
                } placeholder: {
                    Utils().randomPlaceholderColor().opacity(0)
                }
            }
        }
        .aspectRatio(contentMode: .fit)
        .scaledToFit()
        .frame(width: 75, height: 75)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            companyLogoImage
            Spacer()
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
