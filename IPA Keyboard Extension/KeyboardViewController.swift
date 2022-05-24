//
//  KeyboardViewController.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 2018/9/6.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import UIKit
import SwiftUI

class KeyboardViewController: MasterKeyboardViewController, UICollectionViewDataSource {
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyCollection.dataSource = self
        keyCollection.delegate = self
        LocalStorage.setDefaultValues()
        
        // Run IPASymbols consistency checks
        
        IPASymbols.keyArrangementConsistencyCheck()
        
        // Set up the bottom stack view
        
        var glyphs = [String]()
        
        for sectionName in IPASymbols.enabledSections {
            let glyph = IPASymbols.sectionData[sectionName]!.sectionGlyph
            glyphs.append(glyph)
        }
        
        bottomBarDataSource.sectionGlyphs = glyphs
        bottomBarDataSource.mainAction = { index in
            self.scrollToSection(index: index)
        }
    }
    
    // MARK: - Helper Methods

    func updateBottomButtons() {
        let visibleItems = keyCollection.indexPathsForVisibleItems.sorted {
            return $0.section < $1.section
        }
        
        let medianSectionIndex = visibleItems[visibleItems.count / 2].section
        bottomBarDataSource.highlightedSectionIndex = medianSectionIndex
    }
    
    func getKeySet(section: Int) -> [String?]? {
        let largeDisplayKeySet = IPASymbols.sectionData[IPASymbols.enabledSections[section]]?.largeDisplayKeys
        let defaultKeySet = IPASymbols.sectionData[IPASymbols.enabledSections[section]]?.regularDisplayKeys
        return UIDevice.current.userInterfaceIdiom == .pad ? largeDisplayKeySet : defaultKeySet
    }
    
    func getHeaderWidth(section: Int) -> CGFloat {
        guard section < IPASymbols.enabledSections.count else {
            fatalError("Index out of range for section ID: \(section)")
        }
        
        // Calculate text width
        let sectionKey = IPASymbols.enabledSections[section]
        let sectionHeaderText = NSLocalizedString(sectionKey, comment: "Localized versions of the section names.")
        let textSize = (sectionHeaderText as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)])
        let textWidth = textSize.width + Dimensions.leftInsetRaw + Dimensions.rightInset + Dimensions.minimumLineSpacing
        
        return textWidth
    }
    
    // MARK: - Button Actions

    @objc func insertKeyButtonText(from button: UIButton, with event: UIEvent) {
        guard let text = (button.superview?.superview as? KeyButtonCell)?.delegate.title else {
            return
        }
        textDocumentProxy.insertText(Symbols.removedDottedCircles(text))
    }
    
    func scrollToSection(index: Int) {
        let middleIndex = (getKeySet(section: index)?.count ?? 0) / 2
        
        // Calculate columns on screen
        let visibleItemsCount = keyCollection.indexPathsForVisibleItems.count
        
        if middleIndex > visibleItemsCount / 2 + cellsPerColumn {
            // big section
            keyCollection.scrollToItem(at: [index, visibleItemsCount / 2 - cellsPerColumn], at: .centeredHorizontally, animated: true)
        } else {
            // small section
            keyCollection.scrollToItem(at: [index, middleIndex], at: .centeredHorizontally, animated: true)
        }
    }
    
    // MARK: - Collection View Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return IPASymbols.enabledSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numberOfItems = getKeySet(section: section)?.count {
            return numberOfItems
        } else {
            fatalError("Section index overflow.")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! KeyButtonCell
        let button = cell.button
        cell.delegate.title = getKeySet(section: indexPath.section)?[indexPath.item]
        
        if cell.requestToInitializeAction() {
            // Will only run if targets have not been added
            // Add targets
            button.addTarget(self, action: #selector(insertKeyButtonText(from:with:)), for: .primaryActionTriggered)
            button.addTarget(self, action: #selector(keyButtonExpand(from:with:)), for: .touchDown)
            
            // Add retraction targets
            button.addTarget(self, action: #selector(keyButtonRetract(from:with:)), for: .touchCancel)
            button.addTarget(self, action: #selector(keyButtonRetract(from:with:)), for: .touchUpOutside)
            button.addTarget(self, action: #selector(keyButtonRetract(from:with:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: Dimensions.topInset,
            left: Dimensions.leftInset(headerWidth: getHeaderWidth(section: section)),
            bottom: Dimensions.bottomInset,
            right: Dimensions.rightInset
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Dimensions.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Dimensions.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = Dimensions.topInset + Dimensions.bottomInset + collectionView.safeAreaInsets.top + collectionView.safeAreaInsets.bottom + Dimensions.minimumInteritemSpacing * CGFloat(cellsPerColumn - 1)
        let itemHeight = ((collectionView.bounds.size.height - marginsAndInsets) / CGFloat(cellsPerColumn)).rounded(.down)
        return CGSize(width: itemHeight, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let element = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let header = element as? SectionHeader {
            // Pass touches to the views underneath
            header.isUserInteractionEnabled = false
            
            // Set the header title
            header.label.text = NSLocalizedString(IPASymbols.enabledSections[indexPath.section], comment: "Localized versions of the section names.")
            setSectionHeaderColor(header)
        }
        return element
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: getHeaderWidth(section: section), height: 0)
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
