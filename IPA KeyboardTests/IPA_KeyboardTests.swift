//
//  IPA_KeyboardTests.swift
//  IPA KeyboardTests
//
//  Created by Vincent C. on 7/30/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import XCTest
@testable import IPA_Keyboard

final class IPA_KeyboardTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testKeySetConsistency() throws {
        KeySetConsistentAcrossSizesTest.check(layout: IPASymbols.self)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
