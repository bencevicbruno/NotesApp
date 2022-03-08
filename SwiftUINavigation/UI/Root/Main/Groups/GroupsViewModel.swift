//
//  GroupsViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation

final class GruopsViewModel: ObservableObject {
    
    @Published var notes: [String] = []
    
    private weak var coordinator: GroupsCoordinator?
    
    init(coordinator: GroupsCoordinator? = nil) {
        self.coordinator = coordinator
    }
}
