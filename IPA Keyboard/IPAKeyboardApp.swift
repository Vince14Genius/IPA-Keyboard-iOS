//
//  IPAKeyboardApp.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 4/7/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

@main
struct IPAKeyboardApp: App {
    init() {
        LocalStorage.setDefaultValues()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}

struct SceneDelegate_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
