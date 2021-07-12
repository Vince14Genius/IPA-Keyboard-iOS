//
//  InstructionsListItem.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/11/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct InstructionsListItem: View {
    var index: Int
    var bodyText: Text
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(index).")
                .font(.title2)
            bodyText.padding([.top], 5)
            Spacer()
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12.0)
    }
}

struct InstructionsListItem_Previews: PreviewProvider {
    static private let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque convallis ultrices enim, in porttitor ante tincidunt nec. Morbi ullamcorper lectus placerat, egestas tellus eget, condimentum arcu. Etiam cursus lacus ipsum, ac iaculis ligula lobortis et. Nulla et ultrices ipsum. Etiam suscipit auctor nisi sed vestibulum. Curabitur ac tempus lacus. Nam sit amet arcu massa."
    
    static var previews: some View {
        VStack(alignment: .leading) {
            InstructionsListItem(index: 1, bodyText: Text("Colorless green ideas sleep furiously."))
            InstructionsListItem(index: 2, bodyText: Text(Self.loremIpsum))
        }
        .padding()
    }
}
