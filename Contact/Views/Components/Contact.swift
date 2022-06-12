//
//  Contact.swift
//  Contact
//
//  Created by Nikhlesh bagdiya on 10/06/22.
//

import SwiftUI

struct Contact: View {
    var image: Image?
    var name:String
    var number:String
    
    
    var body: some View {
        VStack {
            HStack {
                ZStack{
                    (image != nil ? image! : Image(ConstantImage.userImage))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
                VStack(alignment: .leading) {
                    Text(name)
                        .bold()
                        .padding(.vertical,3)
                    Text(number)
                        .bold()
                        .font(.footnote)
                        .foregroundColor(Color(.systemGray))
                }
            }
        }
    }
}


struct Contact_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(Constants.typeSizes, id: \.self) { size in
                Contact(image: nil, name: "John Deo", number: "+01-91############")
                    .environment(\.dynamicTypeSize, size)
                    .previewDisplayName("\(size)")
            }
            Contact(image: nil, name: "John Deo", number: "+01-91############")
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("dark")
        }.previewLayout(.sizeThatFits)
    }
}
