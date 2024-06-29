//
//  TextFeildStyling.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-04-16.
//

import SwiftUI

struct TextFeildStyling: ViewModifier {
    var customBgColor: Color?
    var customBgStroke: Color?
    var height: CGFloat? = 40
    var width: CGFloat? = .infinity
    
    func body(content: Content) -> some View {
        HStack {
            content
        }
        .frame(width: width, height: height)
        .padding(.leading)
        .background(customBgColor)
        .border(.black, width: 4)
        .padding(.vertical, GridPoints.custom(0.2))
        .background(customBgStroke)
        .cornerRadius(GridPoints.custom(2))
      
        .shadow(color: Color.brown.opacity(0.8), radius: 8, x: 0, y: 1)
        .overlay(
            RoundedRectangle(cornerRadius: GridPoints.custom(2))
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

