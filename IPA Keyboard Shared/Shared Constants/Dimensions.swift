//
//  Dimensions.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 5/24/22.
//  Copyright © 2022 Vince14Genius. All rights reserved.
//

import CoreGraphics

enum Dimensions {
    public static let topInset: CGFloat = 24
    public static let bottomInset: CGFloat = 8
    public static let leftInsetRaw: CGFloat = 12
    public static func leftInset(headerWidth: CGFloat) -> CGFloat { return leftInsetRaw - headerWidth }
    public static let rightInset: CGFloat = 12
    public static let minimumLineSpacing: CGFloat = 4
    public static let minimumInteritemSpacing: CGFloat = 4
}
