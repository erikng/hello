//
//  SecondaryStatus.swift
//  hello
//
//  Created by Erik Gomez on 6/16/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SecondaryStatus: View {
    @ObservedObject var settings: HelloHelper
    var body: some View {
        // Secondary Status
        if settings.applicationState.isEmpty {
            HStack {
                Image(systemName: dynamicOSPreferences.pendingApplicationState)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .foregroundColor(.primary)
                    .frame(width: 15, height: 15)
                    .padding(.leading, 15)
                Text(welcomeSubHeaderText)
                    .fontWeight(.bold)
                Text("is initializing")
                    .fontWeight(.light)
                    .padding(.leading, -5)
                Spacer()
            }
            .frame(width: 876)
        } else if settings.applicationState.values.contains("installing") || settings.applicationState.values.contains("pending") {
            HStack {
                if #available(macOS 12.0, *) {
                    AsyncImage(url: URL(string: settings.applicationInstallingIconPath)) { image in
                        image.resizable()
                    } placeholder: {
                        Utils().randomPlaceholderColor()
                            .opacity(0)
                    }
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.leading, 15)
                } else {
                    WebImage(url: URL(string: settings.applicationInstallingIconPath))
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding(.leading, 15)
                }
                Text(settings.applicationInstalling)
                    .fontWeight(.bold)
                Text("is installing")
                    .fontWeight(.light)
                    .padding(.leading, -5)
                Spacer()
            }
            .frame(width: 876)
        } else {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .foregroundColor(.green)
                    .frame(width: 30, height: 30)
                    .padding(.leading, 15)
                Text(exitText)
                    .fontWeight(.bold)
                Spacer()
                if disableExitScreen {
                    // Normal Quit button
                    Button(action: {
                        Utils().quit()
                    }) {
                        if restartStyle == "None" {
                            Text(quitButtonText)
                        } else {
                            Text(restartButtonText)
                        }
                    }
                    .keyboardShortcut(.defaultAction)
                }

            }
            .frame(width: 876)
        }
    }
}

struct SecondaryStatus_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryStatus(settings: HelloHelper())
    }
}
