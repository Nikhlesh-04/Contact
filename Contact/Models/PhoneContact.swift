import Foundation
import UIKit
import SwiftUI

struct PhoneContact {
    var givenName: String
    var middleName: String
    var familyName: String
    var number: String
    var numberLabel: String
    var image:Image?
    
    var fullName: String {
        return "\(givenName)\(middleName.isEmpty ? "" : " \(middleName)")\(familyName.isEmpty ? "" : " \(familyName)")"
    }
    
    var json: [String: String] {
        return ["mobileNumber": number, "contactName": fullName]
    }
}
