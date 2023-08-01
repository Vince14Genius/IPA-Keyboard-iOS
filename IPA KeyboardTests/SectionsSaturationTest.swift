//
//  SectionsSaturationTest.swift
//  IPA KeyboardTests
//
//  Created by Vincent C. on 8/1/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import XCTest
@testable import IPA_Keyboard

enum SectionsSaturationTest {
    static func check(layout: KeyboardLayout.Type) {
        XCTAssert(
            layout.sectionNames.count == layout.sectionData.count,
            "Check if the number of section names in `sectionData` is equal to the number of section names"
        )
        
        for sectionName in layout.sectionNames {
            XCTAssert(
                layout.sectionData.keys.contains { $0 == sectionName },
                "Check if the layout <\(layout.shortenedDisplayName)> contains section <\(sectionName)>"
            )
        }
    }
}
