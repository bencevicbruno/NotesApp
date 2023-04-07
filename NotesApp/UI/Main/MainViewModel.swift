//
//  MainViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Bencevic on 07.03.2023..
//

import Foundation

final class MainViewModel: ObservableObject {
    
    @Published var currentTab: MainTab = .notes
    @Published var isTabBarVisible = true
    @Published var alertDialog: AlertDialog?
    @Published var choiceDialog: ChoiceDialog?
    @Published var secondChoiceDialog: ChoiceDialog?
    @Published var confirmationDialog: ConfirmationDialog?
    @Published var multipleChoiceDialog: MultipleChoiceDialog?
    
    static let instance = MainViewModel()
    
    init() {
        
    }
}

private extension MainViewModel {
    
}
