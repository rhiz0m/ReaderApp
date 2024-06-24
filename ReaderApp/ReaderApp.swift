//
//  ReaderAppApp.swift
//  ReaderApp
//
//  Created by Andreas Antonsson on 2024-06-22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct ReaderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    //@StateObject var viewAdapter = HomeViewAdapter()
    @StateObject var viewAdapter = AuthViewAdapter(emailInput: "", passwordInput: "")
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                //homeView(viewAdapter: viewAdapter)
                LoginView(viewAdapter: viewAdapter)
            }
        }
    }
}
