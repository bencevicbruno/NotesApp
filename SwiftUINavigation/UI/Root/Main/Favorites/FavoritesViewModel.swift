//
//  FavoritesViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation

final class FavoritesViewModel: ObservableObject {
    
    @Published var notes: [String] = []
    
    private weak var coordinator: FavoritesCoordinator?
    
    init(coordinator: FavoritesCoordinator? = nil) {
        self.coordinator = coordinator
    }
}
