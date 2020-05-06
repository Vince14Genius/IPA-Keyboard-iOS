//
//  KeyboardViewController.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 2018/9/6.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import UIKit

class KeyboardViewController: MasterKeyboardViewController, UICollectionViewDataSource {
    
    // MARK: Constants
    
    let defaultKeyFontSize: CGFloat = 24
    let complexKeyFontSize: CGFloat = 20
    
    // MARK: Main UI Code
    
    private var bottomButtons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.keyCollection.dataSource = self
        self.keyCollection.delegate = self
        
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
        self.bottomStack.leftAnchor.constraint(equalTo: self.nextKeyboardButton.rightAnchor, constant: 12).isActive = true
        self.bottomStack.rightAnchor.constraint(equalTo: self.backwardDeleteButton.leftAnchor, constant: -12).isActive = true
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return IPASymbols.sectionNames.count
    }
    
    @objc func addButtonTitle(from button: UIButton, with event: UIEvent) {
        guard let text = button.currentTitle else { fatalError("Unable to find button title.") }
        if let replacementOutput = IPASymbols.replacementOutputText[text] {
            self.textDocumentProxy.insertText(replacementOutput)
        } else {
            self.textDocumentProxy.insertText(text)
        }
    }
    
    @objc func scrollToSection(from button: UIButton, with event: UIEvent) {
        UISelectionFeedbackGenerator().selectionChanged()
        guard let buttonTitle = button.currentTitle else { fatalError("Wrong button.") }
        for i in 0..<IPASymbols.sectionGlyphs.count {
            if buttonTitle == IPASymbols.sectionGlyphs[i] {
                self.keyCollection.scrollToItem(at: [i, 0], at: .left, animated: true)
                return
            }
        }
    }

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        generalColorUpdate()
        updateBottomButtons()
    }
    
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
        
        var minimumSectionIndex = Int.max
        for indexPath in self.keyCollection.indexPathsForVisibleItems {
            if indexPath.section < minimumSectionIndex {
                minimumSectionIndex = indexPath.section
            }
        }
        
        for button in bottomButtons {
            button.setTitleColor(bottomButtonColor, for: [])
            button.backgroundColor = UIColor(white: 0, alpha: 0.001) // To fix touch hittest area
            if button.titleLabel?.text == IPASymbols.sectionGlyphs[minimumSectionIndex] {
                button.setTitleColor(textColor, for: [])
                button.backgroundColor = supportColor
            }
        }
    }
    
    // MARK: - Collection View Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numberOfItems = IPASymbols.keys[IPASymbols.sectionNames[section]]?.count {
            return numberOfItems
        } else {
            fatalError("Section index overflow.")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath)
        
        if let button = (cell as? KeyButtonCell)?.button {
            if let text = IPASymbols.keys[IPASymbols.sectionNames[indexPath.section]]![indexPath.item] {
                cell.isHidden = false
                
                (cell as! KeyButtonCell).altLabel.text = text
                
                button.setTitle(text, for: [])
                
                if IPASymbols.hasDottedCircle(text) {
                    // Set to smaller font size if there's a dotted circle
                    button.titleLabel?.font = button.titleLabel!.font.withSize(complexKeyFontSize)
                } else {
                    // Default font size
                    button.titleLabel?.font = button.titleLabel!.font.withSize(defaultKeyFontSize)
                }
                
                button.titleLabel?.lineBreakMode = .byClipping // to make sure overflow is not hidden by ellipsis
                
                // Reset the button's targets
                button.removeTarget(nil, action: nil, for: .allEvents)
                button.addTarget(self, action: #selector(addButtonTitle(from:with:)), for: .primaryActionTriggered)
                button.addTarget(self, action: #selector(keyButtonExpand(from:with:)), for: .touchDown)
                
                // Add retraction targets
                button.addTarget(self, action: #selector(keyButtonRetract(from:with:)), for: .touchCancel)
                button.addTarget(self, action: #selector(keyButtonRetract(from:with:)), for: .touchUpOutside)
                button.addTarget(self, action: #selector(keyButtonRetract(from:with:)), for: .touchUpInside)
                
                // Set color based on keyboard appearance
                changeKeyButtonColor(button)
            } else {
                cell.isHidden = true
            }
        } else {
            cell.backgroundColor = UIColor.red
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.topInset, left: self.leftInset, bottom: self.bottomInset, right: self.rightInset)
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
    
    // MARK: - Scroll View Action
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateBottomButtons()
    }
}
