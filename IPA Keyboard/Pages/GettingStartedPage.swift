//
//  GettingStartedPage.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct GettingStartedPage: View {
    @State private var textFieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("getting-started-description")
                    .font(.title2)
                InstructionsListItem(index: 1, bodyText: Text("getting-started-1"))
                InstructionsListItem(index: 2, bodyText: Text("getting-started-2"))
                InstructionsListItem(index: 3, bodyText: Text("getting-started-3"))
                InstructionsListItem(index: 4, bodyText: Text("getting-started-4"))
                TextField("keyboardtest.textfield.placeholder", text: $textFieldText)
                    .padding([.top])
                Divider()
                    .padding([.bottom])
                Text("getting-started-note")
                Spacer()
            }
            .padding()
            .buttonStyle(BlueButtonStyle())
            .navigationBarTitle("instructions.title")
            .navigationBarItems(trailing: Button("about.ipa.title") {
                
            })
        }
    }
}

struct GettingStartedPage_Previews: PreviewProvider {
    static var previews: some View {
        GettingStartedPage()
    }
}

