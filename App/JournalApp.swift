//
//  JournalApp.swift
//  Journal
//
//  Created by Shaquille McGregor on 30/08/2024.
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
    @StateObject private var apptVM = ApptViewModel(database: FirebaseService())
    @StateObject private var authVM = AuthViewModel()
    @StateObject private var calenderVM = CalenderViewModel(database: FirebaseService())
    @StateObject private var chartVM = ChartViewModel(service: FirebaseService())
    @StateObject private var clientVM = ClientViewModel(firebaseService: FirebaseService())
    @StateObject private var serviceVM = ServiceViewModel(firebaseService: FirebaseService())
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
                    .environmentObject(apptVM)
                    .environmentObject(authVM)
                    .environmentObject(calenderVM)
                    .environmentObject(chartVM)
                    .environmentObject(clientVM)
                    .environmentObject(serviceVM)
            }
        }
    }
}
