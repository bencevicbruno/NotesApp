//
//  MultipleChoiceModal.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 28.03.2023..
//

import SwiftUI

struct MultipleChoiceModal: View {
    
    @Binding var binding: MultipleChoiceDialog?
    
    @State private var choices: [MultipleChoiceDialog.Choice] = []
    
    init(_ binding: Binding<MultipleChoiceDialog?>) {
        self._binding = binding
    }
    
    var body: some View {
        DialogBaseModal($binding) { dialog in
            VStack(spacing: 0) {
                VStack(spacing: 16) {
                    Text(verbatim: dialog.title)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    if let message = dialog.message {
                        Text(verbatim: message)
                            .font(.body)
                    }
                }
                .multilineTextAlignment(.center)
                
                Color.gray
                    .frame(height: 1)
                    .padding(.top, 16)
                
                ScrollView(isContentIdeal ? [] : .vertical) {
                    VStack(spacing: 4) {
                        ForEach(0..<choices.count, id: \.self) { index in
                            choiceCell(index)
                        }
                    }
                    .padding(.vertical, 16)
                }
                .frame(height: choicesHeight)
                .overlay {
                    VStack(spacing: 0) {
                        LinearGradient(colors: [.white, .white.opacity(0)], startPoint: .top, endPoint: .bottom)
                            .frame(height: 16)
                        
                        Spacer()
                        
                        LinearGradient(colors: [.white.opacity(0), .white], startPoint: .top, endPoint: .bottom)
                            .frame(height: 16)
                    }
                    .opacity(isContentIdeal ? 0 : 1)
                }
                
                Color.gray
                    .frame(height: 1)
                
                HStack(spacing: 0) {
                    Text(verbatim: dialog.cancelTitle)
                        .foregroundColor(.blue)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            dialog.cancelAction?()
                            binding = nil
                        }
                    
                    Text(verbatim: dialog.confirmationTitle)
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            dialog.confirmAction?(choices.enumerated().filter { $0.element.isSelected }.map { $0.offset })
                            binding = nil
                        }
                }
            }
            .padding([.top, .horizontal], 16)
            .onAppear {
                self.choices = dialog.choices
            }
        }
    }
}

private extension MultipleChoiceModal {
    
    var idealHeight: CGFloat {
        let count = binding?.choices.count ?? 0
        return CGFloat(count * 44 + (count - 1) * 4 + 2 * 16)
    }
    
    var maxHeight: CGFloat {
        let content: CGFloat = 3.5 * 44
        let contentSpacing: CGFloat = 3 * 4
        let padding: CGFloat = 2 * 16
        
        return content + contentSpacing + padding
    }
    
    var isContentIdeal: Bool {
        idealHeight <= maxHeight
    }
    
    var choicesHeight: CGFloat {
        return min(maxHeight, idealHeight)
    }
    
    func choiceCell(_ index: Int) -> some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .stroke(style: .init(lineWidth: 2))
                
                Circle()
                    .fill(choices[index].isSelected ? .blue : .clear)
                    .padding(4)
            }
            .frame(width: 24, height: 24)
            .frame(width: 40, height: 40)
            
            Text(verbatim: choices[index].title)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.blue)
        .frame(height: 44)
        .onTapGesture {
            choices[index].isSelected.toggle()
        }
    }
}

struct MultipleChoiceModal_Previews: PreviewProvider {
    
    static var previews: some View {
        MultipleChoiceModal(.constant(.sample(long: true)))
    }
}
