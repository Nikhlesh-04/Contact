//
//  Constants.swift
//  Contact
//
//  Created by Nikhlesh bagdiya on 10/06/22.
//

import Foundation
import SwiftUI

public struct Constants {
    
    static let kUserDefaults        = UserDefaults.standard

    static let kScreenWidth         = UIScreen.main.bounds.width
    static let kScreenHeight        = UIScreen.main.bounds.height
    
    static let kHeaders = ["Content-Type": "application/json"]
    
    static let typeSizes: [DynamicTypeSize] = [
        .xSmall,
        .large,
        .xxxLarge
    ]
    
    static func setupAppearance(colorScheme:ColorScheme) {
        ColourStyle.shared.colorScheme = colorScheme
    }
}

public struct UserDefaultsConstants {
    static let userState = "UserState"
}

// MARK: - Error Messages Objects.
public struct ConstantsMessages {
    static let welcomeText      = "Welcome to Contact App"
    static let navigationTitle  = "Contacts"
    static let permissionError  = "Please kindly go to settings and enabled permissions to see contacts."
}

public struct Identifiers {
    static let contactTable     = "contact_table_view"
}

public struct ConstantImage {
    
    static let userImage        = "user"
    static let personCircle     = "person.circle.fill"
    
}

public enum CustomError: Error {
    case notAuthorized
}

