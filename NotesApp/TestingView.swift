//
//  TestingView.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 09.03.2023..
//

import SwiftUI
import CloudKit

final class TestingViewModel: ObservableObject {
    
    init() {
        
    }
    
    func go() {
        let record = CKRecord(recordType: "Note", recordID: .init(recordName: "NoteTestRecordName", zoneID: .init(zoneName: "huehuehue", ownerName: "me")))
        record.setValuesForKeys([
            "title": "Test Title",
            "text": "Lorem Ipsum what the duck...",
            "date": Date(),
            "author": "Me"
        ])
        
        let container = CKContainer.default()
//        let customContainer = CKCon
        let privateCloudDatabase = container.privateCloudDatabase
        
        
        let operation = CKFetchRecordZonesOperation(recordZoneIDs: [])
        operation.database = privateCloudDatabase
        operation.fetchRecordZonesResultBlock = { result in
            switch result {
            case .success:
                print("Fetched record zones")
            case .failure(let error):
                print("Error fetching record zones: \(error)")
            }
        }
        
        operation.perRecordZoneResultBlock = { id, result in
            print("Record zone '\(id)'")
            
            switch result {
            case .success(let zone):
                print("Fetched zone: \(zone)")
            case .failure(let error):
                print("Error fetching record zone: \(error)")
            }
        }
        
        operation.start()
        
        privateCloudDatabase.save(record) { record, error in
            if let error {
                print("Error saving record in private cloud database: \(error)")
                return
            }

            print("Record saved in private cloud database!")
            print(record!)
        }
//
//        let sharedCloudRecord = record
//
//        container.sharedCloudDatabase.save(record) {  record, error in
//            if let error {
//                print("Error saving record in sahred cloud database: \(error)")
//                return
//            }
//
//            print("Record saved in shared cloud database!")
//            print(record!)
//        }
//
//        container.publicCloudDatabase.save(record) {  record, error in
//            if let error {
//                print("Error saving record in public cloud database: \(error)")
//                return
//            }
//
//            print("Record saved in public cloud database!")
//            print(record!)
//        }
    }
}

struct KeyboardBottomPadding: ViewModifier {
    
    private let shouldAddPadding: Bool
    
    @State private var keyboardHeight: CGFloat = 0
    @State private var animationDuration: CGFloat?
    
    init(shouldAddPadding: Bool = true) {
        self.shouldAddPadding = shouldAddPadding
    }
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, shouldAddPadding ? keyboardHeight : 0)
            .animation(.linear(duration: animationDuration ?? 0.5), value: keyboardHeight)
            .onNotification(UIResponder.keyboardWillShowNotification) { notification in
                guard let userInfo = notification.userInfo,
                      let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                guard let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
                
                self.keyboardHeight = keyboardRect.height
                self.animationDuration = CGFloat(truncating: animationDuration)
            }
            .onNotification(UIResponder.keyboardWillHideNotification) { _ in
                self.keyboardHeight = 0
            }
    }
}

extension View {
    
    func addKeyboardBottomPadding(_ shouldAddPadding: Bool = true) -> some View {
        self.modifier(KeyboardBottomPadding(shouldAddPadding: shouldAddPadding))
    }
}

struct TestingView: View {
    
    @StateObject var viewModel = TestingViewModel()
    
    @State private var text = ""
    @FocusState private var isFocused
    
    var body: some View {
        VStack {
            Text("Keyboard height: ")
            
            TextField("Hihihohi", text: $text)
                .focused($isFocused)
                .padding(8)
                .background(.white)
                .padding(2)
                .background(.blue)
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.bottom, UIScreen.unsafeBottomPadding + 10)
                .addKeyboardBottomPadding()
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = false
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct TestingView_Previews: PreviewProvider {
    
    static var previews: some View {
        TestingView()
    }
}
