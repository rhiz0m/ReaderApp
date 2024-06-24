//
//  FlipBackBtn.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-04-12.
//

import SwiftUI

struct FlipBackBtn: View {
    @ObservedObject var viewAdapter: HomeViewAdapter
    
    var body: some View {
        HStack(spacing: 2) {
            
            Text("Flip back")
                .lineLimit(1)
                .font(.caption)
                .bold()
                .foregroundStyle(.white)
                .padding(.horizontal, GridPoints.half)
            
            Image(systemName: viewAdapter.viewModel?.flipIcon ?? "")
                .imageScale(.small)
                .foregroundStyle(CustomColors.defaultGreen)
            Spacer()
            
        }
        .padding(.horizontal)
        .padding(.vertical, GridPoints.half)
        .background(.black)
        .cornerRadius(4)
    }
}

#Preview {
    FlipBackBtn(viewAdapter: HomeViewAdapter())
}
