//
//  Login.swift
//  SwiftUI Developement
//
//  Created by Nikhlesh on 29/12/21.
//

import SwiftUI

struct Login: View {
    
    @EnvironmentObject var state: AppState
    
    var body: some View {
        VStack {
            Text(ConstantsMessages.welcomeText)
                .font(.title2)
                .fontWeight(.medium)
                .padding()
            VStack {
                Button(action: {
                    Constants.kUserDefaults.set(true, forKey: UserDefaultsConstants.userState)
                    state.user.state = .isReady
                }) {
                    HStack {
                        Image(systemName: ConstantImage.personCircle)
                            .renderingMode(.template)
                            .foregroundColor(.blue)
                        Text("Login")
                            .font(.system(size: 23))
                            .foregroundColor(.blue)
                        
                    }
                    .padding(.horizontal, 50)
                }
                .buttonStyle(BorderButtonStyle())
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ForEach(Constants.typeSizes, id: \.self) { size in
                Login()
                    .environment(\.dynamicTypeSize, size)
                    .previewDisplayName("\(size)")
            }
            Login()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("dark")
        }.previewLayout(.sizeThatFits)
    }
}
