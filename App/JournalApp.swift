//
//  JournalApp.swift
//  Journal
//
//  Created by Shaquille McGregor on 10/07/2024.
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
struct JournalApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel(authService: AuthService())
    @StateObject private var settingsViewModel = SettingsViewModel(authService: AuthService())
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
            .environmentObject(authViewModel)
            .environmentObject(settingsViewModel)
        }
    }
}
