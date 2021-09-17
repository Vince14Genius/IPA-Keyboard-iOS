//
//  HoldRepeatButton.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct HoldRepeatButton: View {
    var label: Image
    var repeatCallback: () -> ()
    
    let repeatTimer = RepeatTimer(repeatInterval: 0.07)
    
    var tap: some Gesture {
        LongPressGesture(minimumDuration: 0)
            .onEnded { _ in
                repeatCallback()
                repeatTimer.cancel()
            }
    }
    
    var longHold: some Gesture {
        LongPressGesture(minimumDuration: 0.5)
            .onEnded { _ in
                repeatTimer.schedule(repeatCallback: repeatCallback)
            }
    }
    
    var touchEnded: some Gesture {
        DragGesture(minimumDistance: 0)
            .onEnded { _ in
                repeatTimer.cancel()
            }
    }
    
    var body: some View {
        Button {} label: { label }
            .simultaneousGesture(tap)
            .simultaneousGesture(longHold)
            .simultaneousGesture(touchEnded)
    }
}
