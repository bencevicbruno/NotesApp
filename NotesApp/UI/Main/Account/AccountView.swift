//
//  AccountView.swift
//  SwiftUINavigation
//
//  Created by Bruno Benčević on 25.02.2022..
//

import SwiftUI
import CloudKit

struct AccountView: View {
    
    @ObservedObject var viewModel: AccountViewModel
    
    @State private var id = false
    
    var body: some View {
        ZStack(alignment: .top) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top, NavigationBar.totalHeight)
            
            NavigationBar("Account")
                .trailingAction(systemImageName: "gear", viewModel.interact(.logout))
                
        }
        .edgesIgnoringSafeArea(.all)
        .background(background)
        .confirmationDialog($viewModel.confirmationDialog)
        .alertDialog($viewModel.alertDialog)
    }
}

private extension AccountView {
    
    var background: some View {
        Image("background_account")
            .resizable()
            .scaledToFill()
            .blur(radius: 8)
            .frame(width: UIScreen.width, height: UIScreen.height)
    }
    
    var content: some View {
        ScrollView(.vertical) {
            VStack(spacing: 24) {
                iCloudSection
            }
            .padding(20)
        }
    }
    
    func sectionHeader(_ title: String) -> some View {
        HStack(spacing: 8) {
            Capsule()
                .fill(.white)
                .frame(width: 32, height: 4)
            
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.title3)
            
            Capsule()
                .fill(.white)
                .frame(height: 4)
        }
    }
    
    var iCloudSection: some View {
        VStack(alignment: .leading) {
            sectionHeader("iCloud")
            
            HStack(spacing: 8) {
                Image(systemName: "icloud")
                    .resizable()
                    .scaledToFit()
                    .fontWeight(.semibold)
                    .frame(width: 24, height: 24)
                
                Text("Status")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Group {
                    if viewModel.isFetchingICloudAccountStatus {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text(viewModel.iCloudAccountStatus?.prettyDescription ?? "Unknown")
                            .fontWeight(.medium)
                            .foregroundColor(viewModel.iCloudAccountStatus != .available ? .red : .black)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(16)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            HStack(spacing: 8) {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .fontWeight(.semibold)
                    .frame(width: 24, height: 24)
                
                Text("Lock Notes")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Toggle("", isOn: .init(get: {
                    viewModel.lockNotes
                }, set: {
                    viewModel.lockNotes = $0
                }))
            }
            .padding(16)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .contentShape(RoundedRectangle(cornerRadius: 16))
            .onLongPressGesture {
                viewModel.interact(.showLockNotesInfo)
            }
            
            Text("Sync Devices")
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .contentShape(RoundedRectangle(cornerRadius: 16))
                .onTapGesture {
                    viewModel.interact(.syncDevices)
                }
        }
    }
}

extension CKAccountStatus {
    
    var prettyDescription: String {
        switch self {
        case .couldNotDetermine:
            return "Could not determine"
        case .available:
            return "Available"
        case .restricted:
            return "Restricted"
        case .noAccount:
            return "No Account"
        case .temporarilyUnavailable:
            return "Temprarily Unavailable"
        @unknown default:
            return "Unknown"
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    
    static var previews: some View {
        AccountView(viewModel: .init())
    }
}
