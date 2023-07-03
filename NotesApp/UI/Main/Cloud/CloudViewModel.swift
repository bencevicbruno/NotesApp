//
//  CloudViewModel.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 17.03.2023..
//

import SwiftUI

final class CloudViewModel: ObservableObject {
    
    @Binding private var navigationPath: NavigationPath
    
    init(navigationPath: Binding<NavigationPath>) {
        self._navigationPath = navigationPath
        
    }
}

private extension CloudViewModel {
    
    
}
