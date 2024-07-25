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
    @StateObject var coordinator = Coordinator()
    @StateObject var viewAdapter = AuthViewAdapter()
    
    var body: some Scene {
        WindowGroup {
            if let _ = viewAdapter.currentUser {
                NavigationStack(path: $coordinator.path) {
                    coordinator.build(screen: .HomeView, authViewAdapter: viewAdapter)
                        .navigationDestination(for: Screens.self) { screen in
                            coordinator.build(screen: screen, authViewAdapter: viewAdapter)
                        }
                        .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                            coordinator.build(fullScreenCover: fullScreenCover, authViewAdapter: viewAdapter)
                        }
                }
                .onAppear {
                    let poemsRepository = PoemsRepository()
                    poemsRepository.getPoems { result in
                        switch result {
                        case .success(let poems):
                            print("Testing the incoming data from poems API via REPOSITORY: \(poems)")
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
                
            } else {
                NavigationStack(path: $coordinator.path) {
                    coordinator.build(screen: .LoginView, authViewAdapter: viewAdapter)
                        .navigationDestination(for: Screens.self) { screen in
                            coordinator.build(screen: screen, authViewAdapter: viewAdapter)
                        }
                        .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                            coordinator.build(fullScreenCover: fullScreenCover, authViewAdapter: viewAdapter)
                        }
                }
            }
        }
        .environmentObject(coordinator)
    }
}

