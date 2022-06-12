//
//  DispatchView.swift
//  Contact
//
//  Created by Nikhlesh bagdiya on 10/06/22.
//

import Foundation
import SwiftUI

struct DispatchView: View {

    @EnvironmentObject var state: AppState
    @Environment(\.colorScheme) var colorScheme

    // MARK: - Body

    var body: some View {
        Constants.setupAppearance(colorScheme: colorScheme)
        switch state.user.state {
            case .login:
                return AnyView(Login().environmentObject(state))

            case .isReady:
                return AnyView(ContactsView().environmentObject(state))

        }
    }
}
