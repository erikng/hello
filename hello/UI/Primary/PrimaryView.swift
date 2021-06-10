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
            Status()
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
