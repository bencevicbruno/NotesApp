//
//  FavoritesCoordinator.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation
import SwiftUI

final class FavoritesCoordinator: ObservableObject {
 
    @Published var viewModel: FavoritesViewModel!
    
    init() {
        self.viewModel = FavoritesViewModel()
    }
}

struct FavoritesCoordinatorView: View {
    
    @ObservedObject var coordinator: FavoritesCoordinator
    
    var body: some View {
        FavoritesView(viewModel: coordinator.viewModel)
            .removeNavigationBar()
    }
}
