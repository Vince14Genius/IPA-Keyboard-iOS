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
    
    var isTimerActive: Bool {
        get {
            return timer != nil
        }
    }
    
    init(repeatInterval: TimeInterval) {
        self.repeatInterval = repeatInterval
    }
    
    func schedule(repeatCallback: @escaping () -> ()) {
        guard !isTimerActive else { return }
        repeatCallback()
        self.timer = Timer.scheduledTimer(withTimeInterval: repeatInterval, repeats: true) { _ in
            repeatCallback()
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
