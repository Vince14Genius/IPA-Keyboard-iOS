//
//  UserTipView.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/2/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct UserTipView: View {
    var bodyText: LocalizedStringKey
    
    var body: some View {
        HStack(alignment: .top) {
            Text(Localized.gettingStartedNoteBullet)
            Text(bodyText)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(4.0)
    }
}

struct UserTipView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            UserTipView(bodyText: "Colorless green ideas sleep furiously.")
        }
        .padding()
    }
}
