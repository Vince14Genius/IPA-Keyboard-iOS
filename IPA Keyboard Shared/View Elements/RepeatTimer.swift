//
//  RepeatTimer.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import Foundation

class RepeatTimer {
    private var timer: Timer?
    private let repeatInterval: TimeInterval
    private let repeatCallback: () -> ()
    
    var isTimerActive: Bool {
        get {
            return timer != nil
        }
    }
    
    init(repeatInterval: TimeInterval, repeatCallback: @escaping () -> ()) {
        self.repeatInterval = repeatInterval
        self.repeatCallback = repeatCallback
    }
    
    func fire() {
        self.cancel()
        self.repeatCallback()
        self.timer = Timer.scheduledTimer(withTimeInterval: repeatInterval, repeats: true) { _ in
            self.repeatCallback()
        }
    }
    
    func cancel() {
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        cancel()
    }
}
