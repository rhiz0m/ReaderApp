//
//  UserTextArea.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-04-11.
//

import SwiftUI

struct UserTextArea: View {
    @ObservedObject var viewAdapter: HomeViewAdapter
    @Binding var isFlipped: Bool
    @Binding var textState: TextState
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Paste a text or write a text of your own!")
                    .font(.caption)
                ScrollView {
                    TextEditor(text: $textState.selectedText)
                        .background(.brown)
                        .frame(minHeight: GridPoints.custom(25))
                        .frame(minHeight: geometry.size.height)
                        .cornerRadius(GridPoints.x1)
                        .onReceive(NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification)) { _ in
                            DispatchQueue.main.async {
                                textState.selectedText = textState.selectedText
                            }
                        }
                }
                FlipBackBtn(viewAdapter: viewAdapter)
                .onTapGesture {
                    withAnimation(.bouncy(duration: 1.0)) {
                        viewAdapter.resetReader()
                        textState.selectedText = ""
                        isFlipped.toggle()
                    }
                }
            }
        }
    }
}

