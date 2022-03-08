//
//  SwiftUINavigationApp.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import SwiftUI
import Firebase

@main
struct SwiftUINavigationApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var rootCoordinator = RootCoordinator()
    
    var body: some Scene {
        WindowGroup {
            RootCoordinatorView(coordinator: rootCoordinator)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        
//        FirebaseApp.configure()
//        return true
//    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        var persistenceService = ServiceFactory.persistenceService
        
        if !persistenceService.keepUserLoggedIn {
            persistenceService.localUser = nil
        }
    }
}
