//
//  FavoritesView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import SwiftUI

struct FavoritesView: View {
    
    @ObservedObject var viewModel: FavoritesViewModel
    
    var body: some View {
        Text("Hello, Favorites!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(viewModel: FavoritesViewModel(coordinator: nil))
    }
}
