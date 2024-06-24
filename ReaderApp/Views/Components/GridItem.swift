//
//  GridItem.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-03-18.
//

import SwiftUI

struct GridImage: View {
    
    var body: some View {
        Rectangle()
            .frame(width: GridPoints.custom(10), height: GridPoints.custom(10))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.black, lineWidth: 5)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [CustomColors.gridItemGradientDark, CustomColors.gridItemGradientLight]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .border(.black, width: 2)
                    .mask(RoundedRectangle(cornerRadius: 8))
            )
    }
}

struct ContentView: View {
    @State private var itemSelected = false
    
    var body: some View {
        GridImage()
    }
}
