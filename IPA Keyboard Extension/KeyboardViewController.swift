//
//  KeyboardViewController.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 2018/9/6.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import UIKit

class KeyboardViewController: MasterKeyboardViewController, UICollectionViewDataSource {
    
    // MARK: - viewDidLoad()
    
    private var bottomButtons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.keyCollection.dataSource = self
        self.keyCollection.delegate = self
        LocalStorage.setDefaultValues()
        
        // Run IPASymbols consistency checks
        
        LargeDisplayKeyArrangement.keyArrangementConsistencyCheck()
        
        // Set up the bottom stack view
        
        for glyph in IPASymbols.sectionGlyphs {
            let glyphButton = UIButton(type: .system)
            glyphButton.setTitle(glyph, for: [])
            glyphButton.titleLabel?.font = glyphButton.titleLabel!.font.withSize(18)
            
            glyphButton.translatesAutoresizingMaskIntoConstraints = false
            
            glyphButton.layer.cornerRadius = 12
            
            glyphButton.addTarget(self, action: #selector(scrollToSection(from:with:)), for: .touchDown)
            bottomButtons.append(glyphButton)
        }
        
        self.bottomStack = UIStackView(arrangedSubviews: bottomButtons)
        self.bottomStack.axis = .horizontal
        self.bottomStack.distribution = .fillEqually
        self.bottomStack.alignment = .fill
        self.bottomStack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.addSubview(self.bottomStack)
        
        self.bottomStack.translatesAutoresizingMaskIntoConstraints = false
        self.bottomStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -6).isActive = true
        self.bottomStack.topAnchor.constraint(equalTo: self.keyCollection.bottomAnchor).isActive = true
        // self.bottomStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.bottomStack.trailingAnchor.constraint(equalTo: self.backwardDeleteButton.leadingAnchor, constant: -12).isActive = true
        
        if self.needsInputModeSwitchKey {
            self.bottomStack.leadingAnchor.constraint(equalTo: self.nextKeyboardButton.trailingAnchor, constant: 12).isActive = true
        } else {
            self.bottomStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12).isActive = true
        }
    }
    
    // MARK: - Helper Methods

    func updateBottomButtons() {
        var textColor: UIColor
        var bottomButtonColor: UIColor
        var supportColor: UIColor
        
        // Update appearance
        if self.textDocumentProxy.keyboardAppearance == .dark {
            textColor = .white
            bottomButtonColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
            supportColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        } else {
            textColor = .black
            bottomButtonColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            supportColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        }
        
        let visibleItems = self.keyCollection.indexPathsForVisibleItems.sorted {
            return $0.section < $1.section
        }
        let medianSectionIndex = visibleItems[visibleItems.count / 2].section
        
        for button in bottomButtons {
            button.setTitleColor(bottomButtonColor, for: [])
            button.backgroundColor = UIColor(white: 0, alpha: 0.001) // To fix touch hittest area
            if button.titleLabel?.text == IPASymbols.sectionGlyphs[medianSectionIndex] {
                button.setTitleColor(textColor, for: [])
                button.backgroundColor = supportColor
            }
        }
    }
    
    func getKeySet(section: Int) -> [String?]? {
        let largeDisplayKeySet = LargeDisplayKeyArrangement.keys[IPASymbols.sectionNames[section]]
        let defaultKeySet = IPASymbols.keys[IPASymbols.sectionNames[section]]
        return (cellsPerColumn == LargeDisplayKeyArrangement.numberOfRows) ? largeDisplayKeySet : defaultKeySet
    }
    
    func getHeaderWidth(section: Int) -> CGFloat {
        guard section < IPASymbols.sectionNames.count else {
            fatalError("Index out of range for section ID: \(section)")
        }
        
        // Calculate text width
        let sectionKey = IPASymbols.sectionNames[section]
        let sectionHeaderText = NSLocalizedString(sectionKey, comment: "Localized versions of the section names.")
        let textSize = (sectionHeaderText as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)])
        let textWidth = textSize.width + leftInsetRaw + rightInset + minimumLineSpacing
        
        return textWidth
    }
    
    // MARK: - Button Actions

    @objc func addButtonTitle(from button: UIButton, with event: UIEvent) {
        guard let text = button.currentTitle else { fatalError("Unable to find button title.") }
        self.textDocumentProxy.insertText(GlobalSymbols.removedDottedCircles(text))
    }
    
    @objc func scrollToSection(from button: UIButton, with event: UIEvent) {
        UISelectionFeedbackGenerator().selectionChanged()
        guard let buttonTitle = button.currentTitle else { fatalError("Wrong button.") }
        for i in 0..<IPASymbols.sectionGlyphs.count {
            if buttonTitle == IPASymbols.sectionGlyphs[i] {
                // Calculate middle index
                let middleIndex = (getKeySet(section: i)?.count ?? 0) / 2
                
                // Calculate columns on screen
                let visibleItemsCount = self.keyCollection.indexPathsForVisibleItems.count
                
                if middleIndex > visibleItemsCount / 2 + cellsPerColumn {
                    // big section
                    self.keyCollection.scrollToItem(at: [i, visibleItemsCount / 2 - cellsPerColumn], at: .centeredHorizontally, animated: true)
                } else {
                    // small section
                    self.keyCollection.scrollToItem(at: [i, middleIndex], at: .centeredHorizontally, animated: true)
                }
                
                return
            }
        }
    }
    
    // MARK: - Collection View Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return IPASymbols.sectionNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numberOfItems = getKeySet(section: section)?.count {
            return numberOfItems
        } else {
            fatalError("Section index overflow.")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! KeyButtonCell
        let button = cell.button
        
        if let text = getKeySet(section: indexPath.section)?[indexPath.item] {
            cell.setTitle(text: text)
            changeKeyButtonColor(button) // Set color based on keyboard appearance
        }
        
        if cell.requestToInitializeAction() {
            // Will only run if targets have not been added
            // Add targets
            button.addTarget(self, action: #selector(addButtonTitle(from:with:)), for: .primaryActionTriggered)
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
            top: self.topInset,
            left: leftInset(headerWidth: getHeaderWidth(section: section)),
            bottom: self.bottomInset,
            right: self.rightInset
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets: CGFloat
        if #available(iOSApplicationExtension 11.0, *) {
            marginsAndInsets = self.topInset + self.bottomInset + collectionView.safeAreaInsets.top + collectionView.safeAreaInsets.bottom + minimumInteritemSpacing * CGFloat(cellsPerColumn - 1)
        } else {
            // Fallback on earlier versions
            marginsAndInsets = self.topInset + self.bottomInset + minimumInteritemSpacing * CGFloat(cellsPerColumn - 1)
        }
        let itemHeight = ((collectionView.bounds.size.height - marginsAndInsets) / CGFloat(cellsPerColumn)).rounded(.down)
        return CGSize(width: itemHeight, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let element = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.reuseIdentifier, for: indexPath)
        if let header = element as? SectionHeader {
            // Pass touches to the views underneath
            header.isUserInteractionEnabled = false
            
            // Set the header title
            header.label.text = NSLocalizedString(IPASymbols.sectionNames[indexPath.section], comment: "Localized versions of the section names.")
            changeSectionHeaderColor(header)
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
        generalColorUpdate()
        updateBottomButtons()
    }
    
    // MARK: - Scroll View Action
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateBottomButtons()
    }
}
