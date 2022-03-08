//
//  GroupsCoordinator.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation
import SwiftUI

final class GroupsCoordinator: ObservableObject {
 
    @Published var viewModel: GruopsViewModel!
    
    init() {
        self.viewModel = GruopsViewModel()
    }
}

struct GroupsCoordinatorView: View {
    
    @ObservedObject var coordinator: GroupsCoordinator
    
    var body: some View {
        GroupsView(viewModel: coordinator.viewModel)
            .removeNavigationBar()
    }
}
