//
//  Card.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-03-18.
//

import SwiftUI

struct CardStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: GridPoints.custom(30))
            .padding(GridPoints.x1)
            .background(
                LinearGradient(gradient: Gradient(colors: [CustomColors.cardGradientDark, CustomColors.cardGradientLight]), startPoint: .top, endPoint: .bottom)
            )
            .border(CustomColors.cardBorder, width: 1)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.8), radius: 1, x: 0, y: 2)
    }
}

