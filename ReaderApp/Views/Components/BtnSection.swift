//
//  BtnSection.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-04-11.
//

import SwiftUI

struct BtnSection: View {
    @ObservedObject var viewAdapter: HomeViewAdapter
    
    var body: some View {
        ZStack {
            Divider()
                .rotationEffect(.degrees(-12), anchor: .center)
            CircleBtn(viewAdapter: viewAdapter, splitValues: $viewAdapter.splitValues)
        }
        
        .modifier(BtnSectionStyling())
        .padding(.top, GridPoints.x3)
        
        
    }
}

#Preview {
    BtnSection(viewAdapter: HomeViewAdapter())
}
