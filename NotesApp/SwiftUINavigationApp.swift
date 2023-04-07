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
    
    @Environment(\.scenePhase) var scenePhase
    
    init() {
        CloudStoreService.instance.synchronize()
    }
    
    var body: some Scene {
        WindowGroup {
//            TestingView()
//                .preferredColorScheme(.light)
            
            RootCoordinatorView(coordinator: rootCoordinator)
                .preferredColorScheme(.light)
                .alertDialog($mainViewModel.alertDialog)
                .choiceDialog($mainViewModel.choiceDialog)
                .choiceDialog($mainViewModel.secondChoiceDialog)
                .confirmationDialog($mainViewModel.confirmationDialog)
                .multipleChoiceDialog($mainViewModel.multipleChoiceDialog)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                CloudStoreService.instance.synchronize()
            }
        }
    }
}
