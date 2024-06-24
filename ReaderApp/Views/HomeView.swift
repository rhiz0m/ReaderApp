//
//  homeView.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-01-08.
//

import SwiftUI

struct homeView: View {
    @ObservedObject var viewAdapter: HomeViewAdapter
    @State var showSideMenu = false
    
    var body: some View {
        if let viewModel = viewAdapter.viewModel {
            topHeader(viewModel: viewModel)
            
        } else {
            ProgressView()
                .onAppear(perform: {
                    viewAdapter.generateViewModel()
                })
        }
    }
    
    struct ViewModel {
        let title: String
        let burgerIcon: String
        let libraryIcon: String
        let xMarkIcon: String
        let flipIcon: String
        let dottedRectangle: String
        let indicator: String
        let showSelectedText: (Int) -> Void
        let closeSelectedText: (Int) -> Void
    }
    
    @ViewBuilder func topHeader(viewModel: ViewModel) -> some View{
        GeometryReader { geometry in
            VStack {
                GridView(
                    viewAdapter: viewAdapter,
                    gridItemState: $viewAdapter.gridItemState,
                    textState: $viewAdapter.textState,
                    usersText: viewAdapter.usersText)
                .padding(.horizontal, GridPoints.x1)
                .padding(.top, GridPoints.x8)
                
                VStack(spacing: 0) {
                    Image(systemName: "\(viewModel.indicator)")
                        .padding(.top, GridPoints.half)
                        .padding(.horizontal, GridPoints.half)
                        .font(.title)
                        .fontWeight(.heavy)
                        .background(.white)
                        .padding(.top, GridPoints.x3)
                        .foregroundStyle(.red)
                    HStack(spacing: 0) {
                        Text("\(viewAdapter.splitValues.start)")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        Text("\(viewAdapter.splitValues.middle)")
                            .foregroundStyle(.red)
                        Text("\(viewAdapter.splitValues.end)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(height: GridPoints.x6)
                    .background(.white)
                    
                    BtnSection(viewAdapter: viewAdapter)
                    
                }
                .bold()
                .font(.largeTitle)
            }
            
            HStack {
                if showSideMenu {
                    SideMenuView(viewAdapter: viewAdapter)
                        .frame(height: geometry.size.height)
                        .transition(.move(edge: .leading))
                        .zIndex(1)
                }
                Spacer()
            }
            VStack {
                HStack {
                    Icons(imageName: showSideMenu ? viewModel.xMarkIcon : viewModel.burgerIcon)
                    
                        .foregroundStyle(showSideMenu ? .black : CustomColors.defaultGreen)
                        .bold()
                        .padding(GridPoints.half)
                        .background(showSideMenu ? CustomColors.defaultGreen : .black)
                        .cornerRadius(showSideMenu ? 16 : 8)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showSideMenu.toggle()
                            }
                        }
                    
                    Spacer()
                    Text(viewModel.title)
                        .font(Font.custom("PermanentMarker-Regular", size: 20))
                    Spacer()
                    Icons(imageName: viewModel.libraryIcon)
                }
                .padding(GridPoints.x2)
            }
            
        }
        .background(CustomColors.homeBackgroundColor.gradient)
    }
}


#Preview {
    homeView(viewAdapter: HomeViewAdapter(currentIndex: (0, 0)))
}
