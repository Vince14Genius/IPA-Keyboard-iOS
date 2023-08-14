//
//  Symbols.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 2019/7/26.
//  Copyright © 2019 Vince14Genius. All rights reserved.
//

import Foundation

struct Symbols {
    
    static let squareBrackets = "[]"
    static let forwardSlashes = "//"
    static let tilde = "~"
    static let dottedCircle = "◌"
    static let angleBrackets = "⟨⟩"
    
    // MARK: Dotted Circle Operations
    
    static let dottedCircleUnicodeScalar: Unicode.Scalar = "◌"
    
    /**
     - parameter displaySymbol: the symbol to check for whether it has a dotted circle
     - returns: whether the symbol has a dotted circle
     */
    static func hasDottedCircle(_ displaySymbol: String) -> Bool {
        return displaySymbol.unicodeScalars.contains(Symbols.dottedCircleUnicodeScalar)
    }
    
    /**
    - parameter originalString: the original string
    - returns: the original string, with all dotted circles removed
    */
    static func removedDottedCircles(_ originalString: String) -> String {
        return String(originalString.unicodeScalars.filter { unicodeScalar in unicodeScalar != Symbols.dottedCircleUnicodeScalar })
    }
    
}
