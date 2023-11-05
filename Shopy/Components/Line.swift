//
//  Line.swift
//  Shopy
//
//  Created by Mohamed Adel on 05/11/2023.
//

import SwiftUI

struct Line: View {
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 2)
            .foregroundStyle(Color.turquoise)
    }
}

#Preview {
    Line()
}
