//
//  HeightImage.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-03-28.
//

import SwiftUI

struct ProcentageStack: View {
    var body: some View {

        RoundedRectangle(cornerRadius: 8)
            .stroke(.black, lineWidth: 3)
            .background(
                LinearGradient(gradient: Gradient(colors: [CustomColors.procentageStackDark, CustomColors.procentageStackLight]), startPoint: .center, endPoint: .top)
            ).cornerRadius(3)
    }
}

#Preview {
    ProcentageStack()
}
