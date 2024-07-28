//
//  CompanyText.swift
//  hello
//
//  Created by Erik Gomez on 6/10/21.
//

import SwiftUI

struct CompanyText: View {
    var body: some View {
        VStack(spacing: 5) {
            header
            bodyText
        }
    }
    
    private var header: some View {
        HStack {
            Spacer()
            Text(provisioningHeaderText)
                .foregroundColor(.primary)
                .font(.title)
                .fontWeight(.medium)
            Spacer()
        }
    }
    
    private var bodyText: some View {
        HStack {
            Text(provisioningBodyText)
                .foregroundColor(.secondary)
                .lineLimit(3)
                .multilineTextAlignment(.center)
        }
        .frame(width: 495, alignment: .leading)
    }
}

#if DEBUG
struct CompanyText_Previews: PreviewProvider {
    static var previews: some View {
        CompanyText()
    }
}
#endif

