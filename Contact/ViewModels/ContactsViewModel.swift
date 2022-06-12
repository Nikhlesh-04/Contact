//
//  ContactsViewModel.swift
//  Contact
//
//  Created by Nikhlesh bagdiya on 10/06/22.
//

import Combine
import SwiftUI
import Foundation

final class ContactsViewModel: ObservableObject {
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    @Published private var contacts:[PhoneContact] = []
    
    init() {fetch()}

    private func fetch() {
        ContactsManager.manager.fetchAllContacts { contacts, error in
            if var contactss = contacts {
                // Chronological order
                contactss = contactss.sorted {$0.fullName < $1.fullName}
                DispatchQueue.main.async {
                    self.contacts = contactss
                }
            } else if let error = error {
                self.isErrorShown = true
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    var contactsCount:Int {
        return self.contacts.count
    }
    
    var contactStatus:ContactStatus {
        return ContactsManager.manager.contactStatus
    }
    
    func getContact(index: Int) -> PhoneContact {
        return contacts[index]
    }
    
    func searchResults(searchText:String) -> [PhoneContact] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter { $0.fullName.contains(searchText) }
        }
    }
}

