import Foundation
import ContactsUI
import SwiftUI

enum ContactsFilter {
    case none
    case mail
    case message
}

enum ContactStatus {
    case authorized
    case notDetermined
}

class ContactsManager {
    
    //MARK: - Properties
    
    static let manager = ContactsManager()
    
    var contactStatus:ContactStatus = .notDetermined
    
    //MARK: - Helpers
    
    private func getContacts(from contactStore: CNContactStore, filter: ContactsFilter = .none) -> [CNContact] {
        
        var results: [CNContact] = []
        
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey, CNContactImageDataKey, CNContactImageDataAvailableKey, CNContactThumbnailImageDataKey] as [Any]
        
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            return results
        }
        
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                return results
            }
        }
        
        return results
    }
    
    
    private func contactsAuthorization(for store: CNContactStore, completionHandler: @escaping ((_ isAuthorized: Bool) -> Void)) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch authorizationStatus {
        case .authorized:
            self.contactStatus = .authorized
            completionHandler(true)
        case .notDetermined:
            store.requestAccess(for: CNEntityType.contacts, completionHandler: { (isAuthorized: Bool, error: Error?) in
                if isAuthorized {
                    self.contactStatus = .authorized
                } else {
                    self.contactStatus = .notDetermined
                }
                completionHandler(isAuthorized)
            })
        case .denied:
            self.contactStatus = .notDetermined
            completionHandler(false)
        case .restricted:
            self.contactStatus = .notDetermined
            completionHandler(false)
        @unknown default:
            self.contactStatus = .notDetermined
            completionHandler(false)
        }
    }
    
    private func parse(_ contact: CNContact) -> PhoneContact? {
        
        for phoneNumber in contact.phoneNumbers {
            if let label = phoneNumber.label {
                let number = phoneNumber.value
                var userImage:Image? = nil
                if contact.imageDataAvailable, let data = contact.imageData, let image = UIImage(data: data) {
                    // there is an image for this contact
                    userImage = Image(uiImage: image)
                    // Do what ever you want with the contact image below
                }
                let localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
                return PhoneContact(givenName: contact.givenName, middleName: contact.middleName, familyName: contact.familyName, number: number.stringValue, numberLabel: localizedLabel, image: userImage)
            }
            
        }
        
        return nil
    }
    
    //MARK: - Actions
    
    func fetchAllContacts(completionHandler: @escaping (([PhoneContact]?, Error?) -> Void)) {
        
        var phoneContacts:[PhoneContact] = []
        
        let contactStore = CNContactStore()
        
        contactsAuthorization(for: contactStore) { isAuthorized in
            if isAuthorized {
                let contacts = self.getContacts(from: contactStore)
                for contact in contacts {
                    if let phoneContact = self.parse(contact) {
                        if phoneContact.givenName != "SPAM" && phoneContact.number != "" {
                            phoneContacts.append(phoneContact)
                        }
                    } else {
                        continue
                    }
                }
                completionHandler(phoneContacts, nil)
            } else {
                completionHandler(phoneContacts, CustomError.notAuthorized)
            }
        }
    }
}

