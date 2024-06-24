//
//  BtnSectionModifier.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-04-11.
//

import SwiftUI

struct BtnSectionStyling: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            content
                .frame(height: GridPoints.custom(20))
                .background(
                    LinearGradient(gradient: Gradient(colors: [CustomColors.cardGradientLight, CustomColors.homeBackgroundColor]), startPoint: .top, endPoint: .bottom)
                )
        }
    }
}

