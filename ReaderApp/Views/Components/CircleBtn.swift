//
//  CircleBtn.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-01-10.
//

import SwiftUI

struct CircleBtn: View {
    @ObservedObject var viewAdapter: HomeViewAdapter
    @Binding var splitValues: SplitValues
    @State private var isLongPressing = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 60)
                .frame(width: GridPoints.custom(14), height: GridPoints.custom(14))
                .shadow(color: Color.brown.opacity(isLongPressing ? 0 : 0.7), radius: 8, x: 0, y: 1)
                .foregroundColor(isLongPressing ? CustomColors.buttonTextPause : CustomColors.buttonTextPlay)
            RoundedRectangle(cornerRadius: 50)
                .frame(width: isLongPressing ? GridPoints.custom(9) : GridPoints.custom(12), height: isLongPressing ? GridPoints.custom(9) : GridPoints.custom(12))
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(.black, lineWidth: isLongPressing ? 2 : 3)
                )
            
            
            Text(viewAdapter.isPlaying ? "Pause" : "Play")
                .font(Font.custom("PermanentMarker-Regular", size: 18))
                .foregroundStyle(viewAdapter.isPlaying ? .orange : .white)
                .rotationEffect(.degrees(-8), anchor: .center)
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if !viewAdapter.isPlaying {
                        withAnimation(.easeIn(duration: 0.2)) {
                            isLongPressing = true
                            viewAdapter.isPlaying = true
                        }
                    }
                }
                .onEnded { _ in
                    if viewAdapter.isPlaying {
                        withAnimation(.easeOut(duration: 0.2)) {
                            isLongPressing = false
                            viewAdapter.isPlaying = false
                        }
                    }
                }
        )
        .onChange(of: viewAdapter.currentWord) {
            splitValues = viewAdapter.splitValues
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewAdapter = HomeViewAdapter(currentIndex: (0, 0))
        
        return CircleBtn(viewAdapter: viewAdapter, splitValues: .constant(viewAdapter.splitValues))
    }
}


