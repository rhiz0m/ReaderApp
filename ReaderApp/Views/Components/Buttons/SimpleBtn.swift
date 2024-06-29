//
//  SimpleBtn.swift
//  ReaderApp
//
//  Created by Andreas Antonsson on 2024-06-29.
//

import SwiftUI

struct SimpleBtn: View {
    var width:  CGFloat?
    var height: CGFloat? = GridPoints.x1
    var label: String
    var fontStyle: Font
    var fontColor: Color
    var bgColor: Color
    var borderColor: Color
    var radius: CGFloat? = GridPoints.x2
    var shadowColor: Color = .black
    
    
    var body: some View {
        Text(label)
            .font(fontStyle)
            .foregroundColor(fontColor)
            .bold()
            .frame(width: width, height: height)
            .padding()
            .background(bgColor)
            .cornerRadius(radius ?? 0)
            .shadow(color: shadowColor.opacity(0.3), radius: 8, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: (radius ?? 0))
                    .stroke(borderColor, lineWidth: 1)
            )
            
    }
}

#Preview {
    SimpleBtn(
        label: "my button",
        fontStyle: .title,
        fontColor: .black,
        bgColor: .brown,
        borderColor: .black)
}
