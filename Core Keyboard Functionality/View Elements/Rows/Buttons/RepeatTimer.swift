//
//  RepeatTimer.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import Foundation

typealias RepeatableCallback = (_ isRepeat: Bool) -> ()

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
    
    func schedule(repeatCallback: @escaping RepeatableCallback) {
        guard !isTimerActive else { return }
        repeatCallback(true)
        timer = Timer.scheduledTimer(withTimeInterval: repeatInterval, repeats: true) { _ in
            repeatCallback(true)
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
