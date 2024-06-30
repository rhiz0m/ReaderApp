//
//  RotatedText.swift
//  ReaderApp
//
//  Created by Andreas Antonsson on 2024-06-29.
//

import SwiftUI

struct RotatedText: View {
    var text: String
    var font: Font
    var fontWeight: Font.Weight? = .regular
    var color: Color
    var textRotation: Double?
    var charRotation: Double?
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<text.count, id: \.self) { index in
                let character = text[text.index(text.startIndex, offsetBy: index)]
                Text(String(character))
                    .font(font)
                    .fontWeight(fontWeight)
                    .foregroundColor(color)
                    .rotationEffect(.degrees(charRotation ?? 0.0))
                    .padding(GridPoints.x1)
            }
        }
        .rotationEffect(.degrees(textRotation ?? 0.0))
    }
}

#Preview {
    RotatedText(text: "Apptitle", font: .caption, fontWeight: .bold, color: .black)
}
