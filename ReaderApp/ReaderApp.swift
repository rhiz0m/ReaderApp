//
//  ReaderAppApp.swift
//  ReaderApp
//
//  Created by Andreas Antonsson on 2024-06-22.
//

import SwiftUI

@main
struct ReaderApp: App {
    @StateObject var viewAdapter = HomeViewAdapter()
    //@StateObject var viewAdapter = AuthViewAdapter(emailInput: "", passwordInput: "")
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                homeView(viewAdapter: viewAdapter)
                //LoginView(viewAdapter: viewAdapter)
            }
        }
    }
}
