//
//  KeyboardViewController.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 2018/9/6.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var backwardDeleteButton: UIButton!
    
    @IBOutlet var topSquareBracketsButton: UIButton!
    @IBOutlet var topForwardSlashesButton: UIButton!
    @IBOutlet var topTildeButton: UIButton!
    
    @IBOutlet var bottomStack: UIStackView!
    
    @IBOutlet var keyCollection: UICollectionView!
    
    private var bottomButtons = [UIButton]()
    
    private let reuseIdentifier = "ReuseId"
    
    private let headerViewWidth: CGFloat = 140
    
    private let topInset: CGFloat = 24
    private let bottomInset: CGFloat = 8
    private var leftInset: CGFloat {
        get {
            return -(headerViewWidth - 12)
        }
    }
    private let rightInset: CGFloat = 12
    
    private let minimumLineSpacing: CGFloat = 4
    private let minimumInteritemSpacing: CGFloat = 4
    private let cellsPerColumn = 4
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        
        self.nextKeyboardButton = UIButton(type: .system)
        setupButton(button: self.nextKeyboardButton, title: NSLocalizedString("ABC", tableName: "Localizable", comment: "Switch keyboards"))
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allEvents)
        
        self.backwardDeleteButton = UIButton(type: .system)
        setupButton(button: self.backwardDeleteButton, title: "⌫")
        self.backwardDeleteButton.addTarget(self, action: #selector(deleteBackward), for: .touchDown)
        
        self.topSquareBracketsButton = UIButton(type: .system)
        setupButton(button: self.topSquareBracketsButton, title: "[ ]")
        self.topSquareBracketsButton.addTarget(self, action: #selector(self.addSquareBrackets), for: .primaryActionTriggered)
        
        self.topForwardSlashesButton = UIButton(type: .system)
        setupButton(button: self.topForwardSlashesButton, title: "/ /")
        self.topForwardSlashesButton.addTarget(self, action: #selector(self.addForwardSlashes), for: .primaryActionTriggered)
        
        self.topTildeButton = UIButton(type: .system)
        setupButton(button: self.topTildeButton, title: "~")
        self.topTildeButton.addTarget(self, action: #selector(self.addTilde), for: .primaryActionTriggered)
        
        self.view.addSubview(self.nextKeyboardButton)
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -6).isActive = true
        
        self.view.addSubview(self.backwardDeleteButton)
        
        self.view.addSubview(self.topSquareBracketsButton)
        self.view.addSubview(self.topForwardSlashesButton)
        self.view.addSubview(self.topTildeButton)
        
        self.backwardDeleteButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
        self.backwardDeleteButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -6).isActive = true
        
        self.topSquareBracketsButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
        self.topSquareBracketsButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 6).isActive = true
        
        self.topForwardSlashesButton.leftAnchor.constraint(equalTo: self.topSquareBracketsButton.rightAnchor, constant: 12).isActive = true
        self.topForwardSlashesButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 6).isActive = true
        
        self.topTildeButton.leftAnchor.constraint(equalTo: self.topForwardSlashesButton.rightAnchor, constant: 12).isActive = true
        self.topTildeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 6).isActive = true
        
        // Set up the collection view
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionHeadersPinToVisibleBounds = true
        flowLayout.headerReferenceSize = CGSize(width: self.headerViewWidth, height: 0)
        
        self.keyCollection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        self.keyCollection.backgroundColor = UIColor(white: 0, alpha: 0.001) // To fix touch hittest area
        self.keyCollection.dataSource = self
        self.keyCollection.delegate = self
        self.keyCollection.register(KeyButtonCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
        self.keyCollection.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.reuseIdentifier)
        
        self.keyCollection.isDirectionalLockEnabled = false
        self.keyCollection.clipsToBounds = false
        
        self.view.addSubview(self.keyCollection)
        
        self.keyCollection.translatesAutoresizingMaskIntoConstraints = false
        self.keyCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.keyCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.keyCollection.topAnchor.constraint(equalTo: self.topSquareBracketsButton.bottomAnchor, constant: 6).isActive = true
        self.keyCollection.bottomAnchor.constraint(equalTo: self.nextKeyboardButton.topAnchor, constant: -6).isActive = true
        self.keyCollection.heightAnchor.constraint(equalToConstant: 192).isActive = true
        
        // Set up the bottom stack view
        
        bottomButtons = []
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        if self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = .white
        } else {
            textColor = .black
        }
        
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
        self.backwardDeleteButton.setTitleColor(textColor, for: [])
        self.topSquareBracketsButton.setTitleColor(textColor, for: [])
        self.topForwardSlashesButton.setTitleColor(textColor, for: [])
        self.topTildeButton.setTitleColor(textColor, for: [])
        
        for cell in self.keyCollection.visibleCells {
            guard let button = (cell as? KeyButtonCell)?.button else { continue }
            changeKeyButtonColor(button)
        }
        
        for element in self.keyCollection.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader) {
            guard let header = element as? SectionHeader else { continue }
            changeSectionHeaderColor(header)
        }
        
        updateBottomButtons()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return IPASymbols.sectionNames.count
    }
    
    private func changeKeyButtonColor(_ button: UIButton) {
        guard let keyButtonCell = button.superview?.superview as? KeyButtonCell else {
            fatalError("Incorrect button setup")
        }
        
        if self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearance.dark {
            if keyButtonCell.isExpanded {
                button.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
                button.setTitleColor(.clear, for: [])
            } else {
                button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
                button.setTitleColor(.white, for: [])
            }
        } else {
            button.backgroundColor = .white
            if keyButtonCell.isExpanded {
                button.setTitleColor(.clear, for: [])
            } else {
                button.setTitleColor(.black, for: [])
            }
        }
        button.setTitleColor(.clear, for: .highlighted)
    }
    
    private func changeSectionHeaderColor(_ header: SectionHeader) {
        if self.textDocumentProxy.keyboardAppearance == .dark {
            header.label.textColor = .lightGray
        } else {
            header.label.textColor = .darkGray
        }
    }
    
    private func updateBottomButtons() {
        var textColor: UIColor
        var bottomButtonColor: UIColor
        var supportColor: UIColor
        
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
        
        for element in self.bottomStack.arrangedSubviews {
            guard let button = element as? UIButton else { continue }
            button.setTitleColor(bottomButtonColor, for: [])
            button.backgroundColor = UIColor(white: 0, alpha: 0.001) // To fix touch hittest area
            if button.titleLabel?.text == IPASymbols.sectionGlyphs[minimumSectionIndex] {
                button.setTitleColor(textColor, for: [])
                button.backgroundColor = supportColor
            }
        }
    }
    
    private func setupButton(button: UIButton, title: String) {
        button.setTitle(title, for: [])
        button.titleLabel?.font = button.titleLabel!.font.withSize(18)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 4
        button.backgroundColor = UIColor(white: 0, alpha: 0.001) // To fix touch hittest area
    }
    
    @objc
    @IBAction func deleteBackward() {
        self.textDocumentProxy.deleteBackward()
    }
    
    @objc
    @IBAction func addSquareBrackets() {
        self.textDocumentProxy.insertText(IPASymbols.squareBrackets)
        self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -1)
    }
    
    @objc
    @IBAction func addForwardSlashes() {
        self.textDocumentProxy.insertText(IPASymbols.forwardSlashes)
        self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -1)
    }
    
    @objc
    @IBAction func addTilde() {
        self.textDocumentProxy.insertText(IPASymbols.tilde)
    }
    
    @objc
    @IBAction func addButtonTitle(from button: UIButton, with event: UIEvent) {
        self.textDocumentProxy.insertText(button.currentTitle!)
    }
    
    @objc
    @IBAction func scrollToSection(from button: UIButton, with event: UIEvent) {
        UISelectionFeedbackGenerator().selectionChanged()
        guard let buttonTitle = button.currentTitle else { fatalError("Wrong button.") }
        for i in 0..<IPASymbols.sectionGlyphs.count {
            if buttonTitle == IPASymbols.sectionGlyphs[i] {
                self.keyCollection.scrollToItem(at: [i, 0], at: .left, animated: true)
                return
            }
        }
    }
    
    @objc
    @IBAction func keyButtonExpand(from button: UIButton, with event: UIEvent) {
        if let keyButtonCell = button.superview?.superview as? KeyButtonCell {
            keyButtonCell.keyExpand()
            changeKeyButtonColor(button)
            
            // Hide header view
            self.keyCollection.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).forEach { header in
                header.isHidden = true
            }
        } else {
            fatalError("Incorrect button setup.")
        }
    }
    
    @objc
    @IBAction func keyButtonRetract(from button: UIButton, with event: UIEvent) {
        if let keyButtonCell = button.superview?.superview as? KeyButtonCell {
            RunLoop.main.add(Timer(timeInterval: 0.1, repeats: false, block: {_ in
                keyButtonCell.keyRetract()
                self.changeKeyButtonColor(button)
                
                // Show header view
                self.keyCollection.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).forEach { header in
                    header.isHidden = false
                }
            }), forMode: .common)
        } else {
            fatalError("Incorrect button setup.")
        }
    }
    
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
                button.titleLabel?.font = button.titleLabel!.font.withSize(24)
                
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateBottomButtons()
    }
}
