//
//  AccountViewModel.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import Foundation
import SwiftUI
import CloudKit
import Combine

final class AccountViewModel: ObservableObject {
    
    @Published var iCloudAccountStatus: CKAccountStatus?
    @Published var isFetchingICloudAccountStatus = false
    @Published var lockNotes = false
    
    private var updateLockNotes = true
    
    @Published var alertDialog: AlertDialog?
    @Published var confirmationDialog: ConfirmationDialog?
    
    var persistenceService = ServiceFactory.persistenceService
    
    var onLoggedOut: EmptyCallback?
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        isFetchingICloudAccountStatus = true
        checkAccountStatus()
        
        self._lockNotes.projectedValue.sink { [weak self] value in
            guard let self,
                  self.updateLockNotes else { return }
            self.persistenceService.lockNotes = value
        }
        .store(in: &cancellables)
        
        NotificationCenter.addAction(for: .iCloudUpdated) { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.updateLockNotes = false
                self.lockNotes = self.persistenceService.lockNotes
                self.updateLockNotes = true
            }
            
        }
        
        NotificationCenter.default.addObserver(forName: .CKAccountChanged, object: nil, queue: .main) { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                self?.checkAccountStatus()
            }
        }
    }
    
    func checkAccountStatus() {
        CKContainer.default().accountStatus { [weak self] status, error in
            guard let self else { return }
            
            if let error {
                print("Error getting iCloud account status: \(error)")
            }
            
            self.iCloudAccountStatus = status
            self.isFetchingICloudAccountStatus = false
        }
    }
    
    func interact(_ interaction: Interaction) {
        switch interaction {
        case .logout:
            showLogOutDialog()
        case .showLockNotesInfo:
            longPressedLockNotes()
        case .syncDevices:
            CloudStoreService.instance.synchronize()
        }
    }
    
    enum Interaction {
        case logout
        case showLockNotesInfo
        case syncDevices
    }
}

private extension AccountViewModel {
    
    func showLogOutDialog() {
        MainViewModel.instance.confirmationDialog = .init(
            title: "Log out?",
            message: "You can always sign back in.",
            confirmationTitle: "Sign out",
            confirmAction: {
                [weak self] in
                self?.logOut()
            })
    }
    
    func logOut() {
        persistenceService.localUser = nil
        self.onLoggedOut?()
    }
    
    func longPressedLockNotes() {
        MainViewModel.instance.alertDialog = .init(
            title: "Lock Notes",
            message: "Locking notes prevents you from editing and deleting notes.")
        Vibration.selection.vibrate()
    }
}
