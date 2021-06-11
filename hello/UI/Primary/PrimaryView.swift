//
//  PrimaryView.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI

struct PrimaryView: View {
    @ObservedObject var settings: HelloHelper
    var body: some View {
        VStack{
            TopIcons()
            CompanyText()
            Status(settings: settings)
        }
    }
}

#if DEBUG
struct PrimaryView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryView(settings: HelloHelper())
    }
}
#endif
