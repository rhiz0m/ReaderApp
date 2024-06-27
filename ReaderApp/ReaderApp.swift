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

let coordinator = Coordinator()

@main
struct ReaderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewAdapter = AuthViewAdapter(coordinator: coordinator)
    
    var body: some Scene {
        WindowGroup {
            if let _ = viewAdapter.currentUser {
                NavigationStack(path: $viewAdapter.coordinator.path, root: {
                    viewAdapter.coordinator.build(screen: .HomeView, authViewAdapter: viewAdapter)
                        .navigationDestination(for: Screens.self) { screen in
                            viewAdapter.coordinator.build(screen: screen, authViewAdapter: viewAdapter)
                        }
                })
            } else {
                NavigationStack(path: $viewAdapter.coordinator.path, root: {
                    viewAdapter.coordinator.build(screen: .LoginView, authViewAdapter: viewAdapter)
                        .navigationDestination(for: Screens.self) { screen in
                            viewAdapter.coordinator.build(screen: screen, authViewAdapter: viewAdapter)
                        }
                })
            }
        }
    }
}

