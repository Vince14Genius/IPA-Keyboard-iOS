//
//  Operators.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 5/29/22.
//  Copyright © 2022 Vince14Genius. All rights reserved.
//

import Foundation

infix operator ||= : AssignmentPrecedence
func ||=( _ lhs: inout Bool, _ rhs: Bool) {
    lhs = lhs || rhs
}
