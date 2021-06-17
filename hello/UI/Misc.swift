//
//  Misc.swift
//  hello
//
//  Created by Erik Gomez on 6/16/21.
//

import SwiftUI

struct Divider: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 1)
        }
        .frame(width: 900)
    }
}


struct Misc_Previews: PreviewProvider {
    static var previews: some View {
        Divider()
    }
}
