//
//  Coordinator.swift
//  ReaderApp
//
//  Created by Andreas Antonsson on 2024-06-27.
//

import Foundation
import SwiftUI

enum Screens: String, Identifiable {
    case LoginView
    case HomeView
    var id: String {
        self.rawValue
    }
}

enum Sheet: String, Identifiable {
    case LibraryView
    var id: String {
        self.rawValue
    }
}

enum FullScreenCover: String, Identifiable {
    case RegisterView
    var id: String {
        self.rawValue
    }
}

class Coordinator : ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    func push(_ screen: Screens) {
        path.append(screen)
    }
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    @MainActor @ViewBuilder
    func build(screen: Screens, authViewAdapter: AuthViewAdapter) -> some View {
        switch screen {
        case .LoginView:
            LoginView(authViewAdapter: authViewAdapter)
        case .HomeView:
            HomeView(authViewAdapter: authViewAdapter)
        }
    }
    
    @MainActor @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .LibraryView:
            LibraryView()
        }
    }
    
    @MainActor @ViewBuilder
    func build(fullScreenCover: FullScreenCover, authViewAdapter: AuthViewAdapter) -> some View {
        switch fullScreenCover {
        case .RegisterView:
            RegisterView(authViewAdapter: authViewAdapter)
        }
    }
}

