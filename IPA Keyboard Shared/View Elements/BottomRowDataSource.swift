//
//  BottomRowDataSource.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 10/8/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

class BottomRowDataSource: ObservableObject {
    @Published var highlightedSectionIndex = 0
    @Published var sectionGlyphs: [String] = []
    @Published var sectionIconTapAction: ((_ section: Int) -> ())?
    @Published var dragScrollAction: ((_ section: Int, _ fraction: Double) -> ())?
    
    init() {}
    
    convenience init(sectionGlyphs: [String]) {
        self.init()
        self.sectionGlyphs = sectionGlyphs
    }
}
