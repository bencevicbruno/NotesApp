//
//  View+.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 28.02.2022..
//

import Foundation
import SwiftUI

extension View {
    
    func onNotification(_ notificationName: Notification.Name, _ action: @escaping (NotificationCenter.Publisher.Output) -> Void) -> some View {
        self.onReceive(NotificationCenter.default
            .publisher(for: notificationName)
            .receive(on: RunLoop.main)) { output in
                action(output)
            }
    }
    
    func activityIndicatorOverlay(_ isVisible: Bool) -> some View {
        self.overlay {
            ActivityIndicator(isVisible: isVisible)
        }
    }
    
    func pushNavigation<Item, Destination: View>(item: Binding<Item?>, @ViewBuilder destination: @escaping (Item) -> Destination) -> some View {
        let isActive = Binding(
            get: { item.wrappedValue != nil },
            set: { value in
                if !value {
                    item.wrappedValue = nil
                }
            }
        )
        
        return LazyView(pushNavigation(isActive: isActive) {
            if let item = item.wrappedValue {
                destination(item)
            } else {
                EmptyView()
            }
        })
    }
    
    func presentNavigation<Item, Destination: View>(item: Binding<Item?>, @ViewBuilder destination: @escaping (Item) -> Destination) -> some View {
        let isActive = Binding(
            get: { item.wrappedValue != nil },
            set: { value in
                if !value {
                    item.wrappedValue = nil
                }
            }
        )
        
        return LazyView(fullScreenCover(isPresented: isActive) {
            if let item = item.wrappedValue {
                destination(item)
            } else {
                EmptyView()
                    .background(.green)
            }
        })
    }
}

fileprivate extension View {
    
    private func pushNavigation<Destination: View>(isActive: Binding<Bool>, @ViewBuilder destination: () -> Destination) -> some View {
        self.overlay {
            if isActive.wrappedValue {
                NavigationLink(
                    destination: destination(),
                    label: { EmptyView() }
                )
            }
        }
    }
}

extension View {
    
    func removeNavigationBar() -> some View {
        self.navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
    }
}
