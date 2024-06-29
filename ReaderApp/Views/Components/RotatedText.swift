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
    var color: Color
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<text.count, id: \.self) { index in
                let character = text[text.index(text.startIndex, offsetBy: index)]
                Text(String(character))
                    .font(font)
                    .foregroundColor(color)
                    .rotationEffect(.degrees(-90))
                    .padding(GridPoints.x1)
            }
        }
        .rotationEffect(.degrees(90))
    }
}

#Preview {
    RotatedText(text: "Apptitle", font: .caption, color: .black)
}
