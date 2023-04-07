//
//  NoteNewView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 01.03.2022..
//

import SwiftUI

struct NoteNewView: View {
    
    @StateObject var viewModel: NoteNewViewModel
    
    @State private var focusedField: FocusedField? = nil
    
    init(_ note: Note?, navigationPath: Binding<NavigationPath>) {
        self._viewModel = .init(wrappedValue: .init(note, navigationPath: navigationPath))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            content
                .padding(.top, NavigationBar.totalHeight)
            
            NavigationBar(viewModel.note == nil ? "New Note" : "Edit Note")
                .leadingAction(systemImageName: "pencil.slash", viewModel.dismiss())
                .trailingAction(systemImageName: "checkmark", viewModel.save())
        }
        .contentShape(Rectangle())
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .removeNavigationBar()
        .edgesIgnoringSafeArea(.all)
        .alertDialog($viewModel.alertDialog)
        .choiceDialog($viewModel.choiceDialog)
        .choiceDialog($viewModel.secondChoiceDialog)
        .confirmationDialog($viewModel.confirmationDialog)
        .activityIndicatorOverlay(viewModel.isActivityRunning)
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            CustomTextField(title: "Title", text: $viewModel.title, isFocused: focusBinding(for: .title), onCommit: {
                focusedField = .text
            })
            .font(.title)
            .fontWeight(.bold)
            
            CustomTextView(title: "Enter note here...", text: $viewModel.text, isFocused: focusBinding(for: .text), onCommit: {})
                .font(.body)
                .fontWeight(.medium)
                .lineSpacing(viewModel.text.isEmpty ? 0 : 12.5)
                .fixedSize(horizontal: false, vertical: true)
            
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .clipped()
    }
}

private extension NoteNewView {
    
    enum FocusedField: Hashable {
        case title
        case text
    }
    
    func focusBinding(for field: FocusedField) -> Binding<Bool> {
        return .init(get: {
            focusedField == field
        }, set: { focused in
            if focused {
                focusedField = field
            } else {
                focusedField = nil
            }
        })
    }
}

struct NoteNewView_Previews: PreviewProvider {
    
    static var previews: some View {
        NoteNewView(nil, navigationPath: .constant(.init()))
    }
}
