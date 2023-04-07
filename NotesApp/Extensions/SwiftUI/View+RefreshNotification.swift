//
//  View+RefreshNotification.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 20.03.2023..
//

import SwiftUI

struct RefreshOnNotificationModifier: ViewModifier {
    
    private let notificationName: Notification.Name
    
    init(_ notificationName: Notification.Name) {
        self.notificationName = notificationName
    }
    
    @State private var id = true
    
    func body(content: Content) -> some View {
        content.id(self.id)
            .onNotification(notificationName) { _ in
                id.toggle()
            }
    }
}

extension View {
    
    func refreshOnNotification(_ notificationName: Notification.Name) -> some View {
        self.modifier(RefreshOnNotificationModifier(notificationName))
    }
}
