//
//  KeyboardViewController.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 2018/9/6.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import UIKit
import SwiftUI

class KeyboardViewController: MasterKeyboardViewController {
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyCollection.dataSource = self
        keyCollection.delegate = self
        LocalStorage.setDefaultValues()
        
        // Run IPASymbols consistency checks
        
        IPASymbols.keyArrangementConsistencyCheck()
        
        // Set up the bottom stack view
        
        bottomBarDataSource.sectionGlyphs = IPASymbols.enabledSections.map {
            IPASymbols.sectionData[$0]!.sectionGlyph
        }
        
        bottomBarDataSource.mainAction = { index in
            self.scrollToSection(index: index, in: IPASymbols.self)
        }
    }
    
    // MARK: - Delegate Methods
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        updateBottomButtons()
    }
    
    // MARK: - Scroll View Action
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateBottomButtons()
        expandedKeyOverlay.hide()
        
        for cell in keyCollection.visibleCells {
            guard let buttonCell = cell as? KeyButtonCell else { continue }
            buttonCell.delegate.isPressed = false
        }
    }
}
