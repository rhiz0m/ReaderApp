//
//  SideMenuView.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-03-20.
//

import SwiftUI

struct SideMenuView: View {
    @ObservedObject var viewAdapter: HomeViewAdapter
    
    var body: some View {
        VStack {
            Text("Reader speed")
                .font(.title)
                .foregroundStyle(.white)
                .padding(GridPoints.x6)
            Text("Change speed to:")
                .foregroundStyle(.mint)
            Slider(value: $viewAdapter.wordsPerMinute, in: viewAdapter.readerVelocity.minSpeed...viewAdapter.readerVelocity.maxSpeed)
            Text("\(viewAdapter.wpmValueConverter()) Words per minute")
                .foregroundStyle(.mint)
            Spacer()
        }
        .background(.black)
        .cornerRadius(GridPoints.x1)
    }
}


struct SideMenuView_Previews: PreviewProvider {
    
    static var previews: some View {
        SideMenuView(viewAdapter: HomeViewAdapter())
    }
}

