//
//  PrimaryView.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI

struct PrimaryView: View {
    var body: some View {
        VStack{
            TopIcons()
            CompanyText()
            PrimaryStatus()
            HStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: 1)
            }
            .frame(width: 900)
            SecondaryStatus()
        }
    }
}

#if DEBUG
struct PrimaryView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryView()
    }
}
#endif
