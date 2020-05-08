//
//  MasterKeyboardViewController.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 2019/7/25.
//  Copyright © 2019 Vince14Genius. All rights reserved.
//

import UIKit

class MasterKeyboardViewController: UIInputViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Constants
    
    @IBOutlet var keyCollection: UICollectionView!
    @IBOutlet var bottomStack: UIStackView!
    
    // Bottom buttons
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var backwardDeleteButton: UIButton!
    
    // Top leading buttons
    @IBOutlet var topSquareBracketsButton: UIButton!
    @IBOutlet var topForwardSlashesButton: UIButton!
    @IBOutlet var topTildeButton: UIButton!
    @IBOutlet var topDottedCircleButton: UIButton!
    
    // Top trailing buttons
    @IBOutlet var topSpaceBarButton: UIButton!
    @IBOutlet var topReturnButton: UIButton!
    
    // Reuse identifier constant for UICollectionView
    let reuseIdentifier = "ReuseId"
    
    // Dimensional constants
    let headerViewWidth: CGFloat = 140
    let topInset: CGFloat = 24
    let bottomInset: CGFloat = 8
    var leftInset: CGFloat { get { return -(headerViewWidth - 12) } }
    let rightInset: CGFloat = 12
    let minimumLineSpacing: CGFloat = 4
    let minimumInteritemSpacing: CGFloat = 4
    
    var cellSize: CGFloat {
        get {
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                return 45
            default:
                return 38
            }
        }
    }
    
    var cellsPerColumn: Int {
        get {
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                return LargeDisplayKeyArrangement.numberOfRows
            default:
                return IPASymbols.numberOfRows
            }
        }
    }
    
    // MARK: - setupButton()
    
    private var buttonsThatNeedColorUpdate = [UIButton]()
    
    /**
     A reusable setup process for UI buttons in the keyboard.
     - Parameters:
        - button: the `UIButton` to set up
        - title: the text displayed on the button (use `NSLocalizedString` for all non-universally-understood strings)
     */
    private func setupButton(button: UIButton, title: String) {
        self.view.addSubview(button)
        buttonsThatNeedColorUpdate.append(button)
        
        button.setTitle(title, for: [])
        button.titleLabel?.font = button.titleLabel!.font.withSize(18)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 4
        button.backgroundColor = UIColor(white: 0, alpha: 0.001) // To fix touch hittest area
    }
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Perform custom UI setup here
        
        self.nextKeyboardButton = UIButton(type: .system)
        setupButton(button: self.nextKeyboardButton, title: NSLocalizedString("ABC", tableName: "Localizable", comment: "Switch keyboards"))
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allEvents)
        
        self.backwardDeleteButton = UIButton(type: .system)
        setupButton(button: self.backwardDeleteButton, title: "⌫")
        
        self.topSquareBracketsButton = UIButton(type: .system)
        setupButton(button: self.topSquareBracketsButton, title: "[ ]")
        self.topSquareBracketsButton.addTarget(self, action: #selector(self.addSquareBrackets), for: .primaryActionTriggered)
        
        self.topForwardSlashesButton = UIButton(type: .system)
        setupButton(button: self.topForwardSlashesButton, title: "/ /")
        self.topForwardSlashesButton.addTarget(self, action: #selector(self.addForwardSlashes), for: .primaryActionTriggered)
        
        self.topTildeButton = UIButton(type: .system)
        setupButton(button: self.topTildeButton, title: "~")
        self.topTildeButton.addTarget(self, action: #selector(self.addTilde), for: .primaryActionTriggered)
        
        self.topDottedCircleButton = UIButton(type: .system)
        setupButton(button: self.topDottedCircleButton, title: String(GlobalSymbols.dottedCircle))
        self.topDottedCircleButton.addTarget(self, action: #selector(self.addDottedCircle), for: .primaryActionTriggered)
        
        self.topSpaceBarButton = UIButton(type: .system)
        setupButton(button: self.topSpaceBarButton, title: NSLocalizedString("SpaceBarText", comment: "space"))
        self.topSpaceBarButton.addTarget(self, action: #selector(self.addSpace), for: .primaryActionTriggered)
        
        self.topReturnButton = UIButton(type: .system)
        setupButton(button: self.topReturnButton, title: "⏎")
        self.topReturnButton.addTarget(self, action: #selector(self.addReturn), for: .primaryActionTriggered)
        
        // MARK: - Set up constraints
        
        self.nextKeyboardButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -6).isActive = true
        
        self.backwardDeleteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12).isActive = true
        self.backwardDeleteButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -6).isActive = true
        
        self.topSquareBracketsButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12).isActive = true
        self.topSquareBracketsButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 6).isActive = true
        
        self.topForwardSlashesButton.leadingAnchor.constraint(equalTo: self.topSquareBracketsButton.trailingAnchor, constant: 12).isActive = true
        self.topForwardSlashesButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 6).isActive = true
        
        self.topTildeButton.leadingAnchor.constraint(equalTo: self.topForwardSlashesButton.trailingAnchor, constant: 12).isActive = true
        self.topTildeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 6).isActive = true
        
        self.topDottedCircleButton.leadingAnchor.constraint(equalTo: self.topTildeButton.trailingAnchor, constant: 12).isActive = true
        self.topDottedCircleButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 6).isActive = true
        
        self.topSpaceBarButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 6).isActive = true
        self.topSpaceBarButton.trailingAnchor.constraint(equalTo: self.topReturnButton.leadingAnchor, constant: -12).isActive = true
        
        self.topReturnButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 6).isActive = true
        self.topReturnButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12).isActive = true
        
        // MARK: - Set up the collection view
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionHeadersPinToVisibleBounds = true
        flowLayout.headerReferenceSize = CGSize(width: self.headerViewWidth, height: 0)
        
        self.keyCollection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        self.keyCollection.backgroundColor = UIColor(white: 0, alpha: 0.001) // To fix touch hittest area
        self.keyCollection.register(KeyButtonCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
        self.keyCollection.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.reuseIdentifier)
        
        self.keyCollection.isDirectionalLockEnabled = false
        self.keyCollection.clipsToBounds = false
        
        self.view.addSubview(self.keyCollection)
        
        self.keyCollection.translatesAutoresizingMaskIntoConstraints = false
        self.keyCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.keyCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.keyCollection.topAnchor.constraint(equalTo: self.topSquareBracketsButton.bottomAnchor, constant: 6).isActive = true
        self.keyCollection.bottomAnchor.constraint(equalTo: self.nextKeyboardButton.topAnchor, constant: -6).isActive = true
        
        let insetsTotalHeight = topInset + bottomInset
        let cellTotalHeight = CGFloat(cellsPerColumn) * cellSize
        let spacingTotalHeight = CGFloat(cellsPerColumn - 1) * minimumInteritemSpacing
        let keyCollectionHeight = insetsTotalHeight + cellTotalHeight + spacingTotalHeight
        self.keyCollection.heightAnchor.constraint(equalToConstant: keyCollectionHeight).isActive = true
        
        // MARK: - Set up backspace button
        
        let cancelEvents: UIControl.Event = [.touchUpInside, .touchUpInside, .touchDragExit, .touchUpOutside, .touchCancel, .touchDragOutside]
        
        self.backwardDeleteButton.addTarget(self,
                                            action: #selector(deleteBackward),
                                            for: .touchDown)
        self.backwardDeleteButton.addTarget(self,
                                            action: #selector(deleteEnded),
                                            for: cancelEvents)
        
        // MARK: - Set up input mode switch button if needed
        
        if #available(iOSApplicationExtension 11.0, *), needsInputModeSwitchKey {
            
        } else {
            
        }
    }
    
    // MARK: - Other Boilerplate Code
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    // MARK: - Color Update Methods
    
    /**
    Update the colors of all first-level UI elements, key buttons, and section headers
    */
    func generalColorUpdate() {
        var textColor: UIColor
        if self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = .white
        } else {
            textColor = .black
        }
        
        for buttonToUpdate in buttonsThatNeedColorUpdate {
            buttonToUpdate.setTitleColor(textColor, for: [])
        }
        
        for cell in self.keyCollection.visibleCells {
            guard let button = (cell as? KeyButtonCell)?.button else { continue }
            changeKeyButtonColor(button)
        }
        
        for element in self.keyCollection.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader) {
            guard let header = element as? SectionHeader else { continue }
            changeSectionHeaderColor(header)
        }
    }
    
    /**
    Update the colors of all key buttons and their labels, based on the system keyboard color.
    - Parameters:
       - button: the `UIButton` to set up
    */
    func changeKeyButtonColor(_ button: UIButton) {
        guard let keyButtonCell = button.superview?.superview as? KeyButtonCell else {
            fatalError("Incorrect button setup")
        }
        
        if self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearance.dark {
            if keyButtonCell.isExpanded {
                button.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
                button.setTitleColor(.clear, for: []) // if keyButtonCell.isExpanded
            } else {
                button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
                button.setTitleColor(.white, for: [])
            }
        } else if self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearance.light {
            button.backgroundColor = .white
            button.setTitleColor(.clear, for: []) // if keyButtonCell.isExpanded
            if !keyButtonCell.isExpanded {
                button.setTitleColor(.black, for: [])
            }
        }
        
        button.setTitleColor(.clear, for: .highlighted)
    }
    
    /**
    Update the colors of all section header text, based on the system keyboard color.
    - Parameters:
       - header: the `SectionHeader` to set up
    */
    func changeSectionHeaderColor(_ header: SectionHeader) {
        if self.textDocumentProxy.keyboardAppearance == .dark {
            header.label.textColor = .lightGray
        } else {
            header.label.textColor = .darkGray
        }
    }
    
    // MARK: - Backspace Repeat
    
    let backspaceDelay: TimeInterval = 0.5
    let backspaceRepeat: TimeInterval = 0.07
    
    var backspaceActive: Bool {
        get {
            return (backspaceDelayTimer != nil) || (backspaceRepeatTimer != nil)
        }
    }
    var backspaceDelayTimer: Timer?
    var backspaceRepeatTimer: Timer?
    
    deinit {
        backspaceDelayTimer?.invalidate()
        backspaceRepeatTimer?.invalidate()
    }
    
    func cancelBackspaceTimers() {
        self.backspaceDelayTimer?.invalidate()
        self.backspaceRepeatTimer?.invalidate()
        self.backspaceDelayTimer = nil
        self.backspaceRepeatTimer = nil
    }
    
    @objc func backspaceDelayCallback() {
        self.backspaceDelayTimer = nil
        self.backspaceRepeatTimer = Timer.scheduledTimer(timeInterval: backspaceRepeat, target: self, selector: #selector(backspaceRepeatCallback), userInfo: nil, repeats: true)
    }
    
    @objc func backspaceRepeatCallback() {
        //self.playKeySound()
        self.textDocumentProxy.deleteBackward()
    }
    
    @objc func deleteBackward() {
        self.cancelBackspaceTimers()
        self.textDocumentProxy.deleteBackward()
        
        // trigger for subsequent deletes
        self.backspaceDelayTimer = Timer.scheduledTimer(timeInterval: backspaceDelay - backspaceRepeat, target: self, selector: #selector(backspaceDelayCallback), userInfo: nil, repeats: false)
    }
    
    @objc func deleteEnded() {
        self.cancelBackspaceTimers()
    }
    
    // MARK: - Button Actions
    
    @objc func addSquareBrackets() {
        self.textDocumentProxy.insertText(GlobalSymbols.squareBrackets)
        self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -1)
    }
    
    @objc func addForwardSlashes() {
        self.textDocumentProxy.insertText(GlobalSymbols.forwardSlashes)
        self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -1)
    }
    
    @objc func addTilde() {
        self.textDocumentProxy.insertText(GlobalSymbols.tilde)
    }
    
    @objc func addDottedCircle() {
        self.textDocumentProxy.insertText(String(GlobalSymbols.dottedCircle))
    }
    
    @objc func addSpace() {
        self.textDocumentProxy.insertText(" ")
    }
    
    @objc func addReturn() {
        self.textDocumentProxy.insertText("\n")
    }
    
    @objc func keyButtonExpand(from button: UIButton, with event: UIEvent) {
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
    
    @objc func keyButtonRetract(from button: UIButton, with event: UIEvent) {
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
    
}
