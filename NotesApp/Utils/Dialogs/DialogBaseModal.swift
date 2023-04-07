//
//  DialogBaseModal.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 03.03.2022..
//

import SwiftUI

enum DialogBaseModalUtils {
    
    static let animation: Animation = .linear(duration: 0.25)
}

struct DialogBaseModal<D, Content>: View where D: Dialog, Content: View {
    
    @Binding private var dialog: D?
    @ViewBuilder private let content: (D) -> Content
    
    init(_ dialog: Binding<D?>, _ content: @escaping (D) -> Content) {
        self._dialog = dialog
        self.content = content
    }
    
    var body: some View {
        ZStack {
            if let dialog {
                content(dialog)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(16)
                    .shadow(radius: 16)
                    .padding(.horizontal, 20)
                    .padding(.bottom, max(UIScreen.unsafeBottomPadding, 20))
                    .transition(.move(edge: .bottom)
                        .animation(DialogBaseModalUtils.animation))
                    .onTapGesture {}
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(.ultraThinMaterial.opacity(self.dialog == nil ? 0 : 1))
        .edgesIgnoringSafeArea(.all)
        .animation(DialogBaseModalUtils.animation, value: dialog)
        .onTapGesture {
            if dialog?.isDismissable ?? false {
                dialog?.dismissAction?()
                dialog = nil
            }
        }
    }
}
