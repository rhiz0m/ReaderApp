//
//  GridView.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-01-10.
//

import SwiftUI

struct GridView: View {
    @ObservedObject var viewAdapter: HomeViewAdapter
    
    @State private var readPercentages: [Int: String] = [:]
    @State private var percentagesInHeight: [Int: Double] = [:]
    @State var isFlipped = false
    @State var isItemSelected = false
    
    @Binding var gridItemState: GridItemState
    @Binding var textState: TextState
    
    let usersText: UsersTexts
    
    private let numOfRectangles: [Int] = Array(1...8)
    private let adaptiveColumns = [GridItem(.adaptive(minimum: GridPoints.custom(10)))]
    
    var body: some View {
        ZStack {
            if textState.selectedText.isEmpty && !isFlipped {
                
                VStack {
                    LazyVGrid(columns: adaptiveColumns, spacing: 16) {
                        ForEach(numOfRectangles, id: \.self) { item in
                            ZStack(alignment: .bottom) {
                                GridImage()
                                Text(usersText.texts[safe: item - 1] ?? "")
                                    .background(gridItemState.index == item ? Color.orange
                                                : .clear)
                                    .cornerRadius(8)
                                    .foregroundStyle(gridItemState.index == item ? .white : Color.green)
                                    .lineLimit(14)
                                    .minimumScaleFactor(0.2)
                                    .padding(GridPoints.x1)
                                    .onTapGesture {
                                            guard usersText.texts[safe: item - 1] != nil else { return }
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            viewAdapter.gridItemState = GridItemState(
                                                index: item,
                                                isSelected: !(gridItemState.index == item)
                                            )
                                        }
                                    }
                                
                                if let percentage = readPercentages[item], !percentage.isEmpty {
                                    ProcentageStack()
                                        .frame(maxWidth: .infinity, maxHeight: viewAdapter.heightInProcent(forItem: item, itemHeightInPercentage: percentagesInHeight))
                                    
                                    Text("\(percentage)")
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                        .padding(GridPoints.x1)
                                }
                            }
                        }
                    }
                    HStack {
                        FlipBtn(viewAdapter: viewAdapter)
                            .onTapGesture {
                                if gridItemState.isSelected {
                                    viewAdapter.resetReader()
                                    viewAdapter.showSelectedText(selectedIndex: gridItemState.index)
                                    withAnimation(.smooth(duration: 1.0)) {
                                        self.isFlipped.toggle()
                                    }
                                } else if !gridItemState.isSelected {
                                    withAnimation(.smooth(duration: 1.0)) {
                                        self.isFlipped.toggle()
                                    }
                                } else {
                                    viewAdapter.closeSelectedText(selectedItem: gridItemState.index)
                                }
                            }
                        Spacer()
                        UnSelectBtn()
                            .onTapGesture {
                                viewAdapter.resetReader()
                                gridItemState.index = 0
                            }
                        }
                    .padding(GridPoints.half)
                    }

                } else if !gridItemState.isSelected {
                    VStack {
                        UserTextArea(viewAdapter: viewAdapter, isFlipped: $isFlipped, textState: $viewAdapter.textState)
                    }
                    .rotationEffect(.degrees(isFlipped ? 180 : 0), anchor: .center)
                    .scaleEffect(x: isFlipped ? 1 : 1, y: -1, anchor: .center)
                }
                else {
                    VStack {
                        ScrollView {
                            Text(textState.selectedText)
                                .padding(GridPoints.x1)
                                .background(.white)
                                .cornerRadius(GridPoints.x1)
                        }
                        FlipBackBtn(viewAdapter: viewAdapter)
                            .onTapGesture {
                                let result = textState.textPercentage
                                let selectedIndex = viewAdapter.gridItemState.index
                                
                                percentagesInHeight[selectedIndex] = result
                                readPercentages[selectedIndex] = "\(result) %"
                                viewAdapter.closeSelectedText(selectedItem: selectedIndex)
                                withAnimation(.bouncy(duration: 1.0)) {
                                    self.isFlipped.toggle()
                                }
                            }
                    }
                    .rotationEffect(.degrees(isFlipped ? 180 : 0), anchor: .center)
                    .scaleEffect(x: isFlipped ? 1 : 1, y: -1, anchor: .center)
                }
        }
        .modifier(CardStyling())
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0.0, y: 1.0, z: 0.0))
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        let gridItemState = GridItemState(index: 0, isSelected: false)
        let textState = TextState(homeViewAdapter: HomeViewAdapter(), index: 0, selectedText: "", totalTextLength: 0)
        
        return GridView(
            viewAdapter: HomeViewAdapter(
                currentIndex: (0, 0)),
            isFlipped: false,
            gridItemState: .constant(gridItemState),
            textState: .constant(textState),
            usersText: UsersTexts())
        .previewLayout(.sizeThatFits)
    }
}
