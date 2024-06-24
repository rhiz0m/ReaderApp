//
//  DeSelectBtn.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-04-12.
//

import SwiftUI

struct UnSelectBtn: View {
    var body: some View {
        HStack() {

            Text("Unselect")
                .lineLimit(1)
                .font(.caption)
                .bold()
            Image(systemName: "rectangle.dashed")
        }
    }
}

#Preview {
    UnSelectBtn()
}
