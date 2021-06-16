//
//  ProvisioningView.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI

struct ProvisioningView: View {
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
struct ProvisioningView_Previews: PreviewProvider {
    static var previews: some View {
        ProvisioningView(settings: HelloHelper())
    }
}
#endif
