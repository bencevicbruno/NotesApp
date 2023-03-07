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
    @ObservedObject var mainViewModel = MainViewModel.instance
    
    var body: some Scene {
        WindowGroup {
//            CustomTextField(title: "hihi", isFocused: .constant(true))
            RootCoordinatorView(coordinator: rootCoordinator)
                .preferredColorScheme(.light)
                .confirmationDialog($mainViewModel.confirmationDialog)
        }
    }
}
