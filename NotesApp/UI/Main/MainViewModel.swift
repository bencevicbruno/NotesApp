//
//  MainViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Bencevic on 07.03.2023..
//

import Foundation

final class MainViewModel: ObservableObject {
    
    @Published var currentTab: MainTab = .notes
    @Published var confirmationDialog: ConfirmationDialog?
    
    static let instance = MainViewModel()
    
    init() {
        
    }
}

private extension MainViewModel {
    
}
