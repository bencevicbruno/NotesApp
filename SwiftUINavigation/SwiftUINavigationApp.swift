//
//  SwiftUINavigationApp.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import SwiftUI

@main
struct SwiftUINavigationApp: App {
    
    @StateObject var rootCoordinator = RootCoordinator()
    
    var body: some Scene {
        WindowGroup {
            RootCoordinatorView(coordinator: rootCoordinator)
        }
    }
}
