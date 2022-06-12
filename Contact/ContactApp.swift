//
//  ContactApp.swift
//  Contact
//
//  Created by Nikhlesh bagdiya on 10/06/22.
//

import SwiftUI

@main
struct ContactApp: App {
    let state = AppState()
    let dispatchView = DispatchView()

    var body: some Scene {
        WindowGroup {
            dispatchView.environmentObject(state)
        }
    }
}
