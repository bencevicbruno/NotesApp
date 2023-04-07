//
//  AccountCoordinator.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation
import SwiftUI

final class AccountCoordinator: ObservableObject {
    
    @Published var viewModel = AccountViewModel()
    
    var onLoggedOut: EmptyCallback?
    
    init() {
        viewModel.onLoggedOut = { [weak self] in
            self?.onLoggedOut?()
        }
    }
}

struct AccountCoordinatorView: View {
    
    @ObservedObject var coordinator: AccountCoordinator
    
    var body: some View {
        AccountView(viewModel: coordinator.viewModel)
    }
}
