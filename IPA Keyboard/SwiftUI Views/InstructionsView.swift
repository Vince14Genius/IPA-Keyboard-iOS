//
//  InstructionsView.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 4/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct InstructionsView: View {
    @State private var textFieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("instructions.text")
                TextField("keyboardtest.textfield.placeholder", text: $textFieldText)
                Divider()
                Spacer()
            }
            .padding()
            .buttonStyle(MyButtonStyle())
            .navigationBarTitle("instructions.title")
            .navigationBarItems(trailing: Button("about.ipa.title") {
                
            })
        }
        .tabItem {
            Image(systemName: "text.book.closed.fill")
            Text("instructions.title")
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
