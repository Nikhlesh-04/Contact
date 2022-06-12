//
//  MainContainer.swift
//  Contact
//
//  Created by Nikhlesh bagdiya on 10/06/22.
//

import SwiftUI

struct ContactsView: View {
    
    @EnvironmentObject var state: AppState
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private var model = ContactsViewModel()
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(0..<model.searchResults(searchText: searchText).count, id:\.self) { index in
                        let contact = model.searchResults(searchText: searchText)[index]
                        Contact(image: contact.image, name: contact.fullName, number: contact.number)
                    }
                }
                .accessibilityIdentifier(Identifiers.contactTable)
                
                if model.contactStatus == .notDetermined {
                    Text(ConstantsMessages.permissionError)
                        .bold()
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                        .foregroundColor(Color(.systemGray))
                }
                
            }
            .searchable(text: $searchText)
            .navigationTitle(ConstantsMessages.navigationTitle)
            .toolbar {
                Button("Logout") {
                    Constants.kUserDefaults.removeObject(forKey: UserDefaultsConstants.userState)
                    state.user.state = .login
                }
            }
        }
    }
}

struct ContactsView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            ForEach(Constants.typeSizes, id: \.self) { size in
                ContactsView()
                    .environment(\.dynamicTypeSize, size)
                    .previewDisplayName("\(size)")
            }
            ContactsView()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("dark")
        }.previewLayout(.sizeThatFits)
    }
}
