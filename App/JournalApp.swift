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
    @StateObject private var apptViewModel = ApptViewModel(firebaseService: FirebaseService())
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var calenderViewModel = CalenderViewModel()
    @StateObject private var clientViewModel = ClientViewModel(firebaseService: FirebaseService())
    @StateObject private var serviceViewModel = ServiceViewModel(firebaseService: FirebaseService())
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
            .environmentObject(apptViewModel)
            .environmentObject(authViewModel)
            .environmentObject(calenderViewModel)
            .environmentObject(clientViewModel)
            .environmentObject(serviceViewModel)
        }
    }
}
