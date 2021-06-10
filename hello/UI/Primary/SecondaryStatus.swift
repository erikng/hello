//
//  SecondaryStatus.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI

// SecondaryStatus
// TODO: Make this actually work
// TODO: Figure out if this object can be pushed down about 20 pixels so it matches the top part
struct SecondaryStatus: View {
    var body: some View {
        HStack {
            Image(nsImage: Utils().createImageData(fileImagePath: "/Applications/Slack.app/Contents/Resources/electron.icns"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(.leading, 15)
            Text("Slack")
                .fontWeight(.bold)
            Text("is installing")
                .fontWeight(.light)
                .padding(.leading, -5)
            Spacer()
        }
        .frame(width: 876)
    }
}

#if DEBUG
struct SecondaryStatus_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryStatus()
    }
}
#endif
