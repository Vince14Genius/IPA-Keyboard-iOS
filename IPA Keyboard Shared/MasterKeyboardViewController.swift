//
//  MasterKeyboardViewController.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 2019/7/25.
//  Copyright © 2019 Vince14Genius. All rights reserved.
//

import UIKit
import SwiftUI

class MasterKeyboardViewController: UIInputViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Constants
    
    @IBOutlet var keyCollection: UICollectionView!
    @IBOutlet var bottomStack: UIStackView!
    
    // Bottom buttons
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var backwardDeleteButton: UIButton!
    
    // Reuse identifier constant for UICollectionView
    let reuseIdentifier = "ReuseId"
    
    // Dimensional constants
    let topInset: CGFloat = 24
    let bottomInset: CGFloat = 8
    let leftInsetRaw: CGFloat = 12
    func leftInset(headerWidth: CGFloat) -> CGFloat { return leftInsetRaw - headerWidth }
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
        
        self.backwardDeleteButton = UIButton(type: .system)
        setupButton(button: self.backwardDeleteButton, title: "⌫")
        
        let toolbarRow = UIHostingController(rootView: ToolbarRow(inputViewController: self))
        self.view.addSubview(toolbarRow.view)
        self.addChild(toolbarRow)
        toolbarRow.view.backgroundColor = .clear
        toolbarRow.view.sizeToFit()
        toolbarRow.view.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Set up constraints
        
        self.backwardDeleteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12).isActive = true
        self.backwardDeleteButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -6).isActive = true
        
        toolbarRow.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        toolbarRow.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        toolbarRow.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
        // MARK: - Set up the collection view
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionHeadersPinToVisibleBounds = true
        
        self.keyCollection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        self.keyCollection.backgroundColor = UIColor(white: 0, alpha: 0.001) // To fix touch hittest area
        self.keyCollection.register(KeyButtonCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
        self.keyCollection.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.reuseIdentifier)
        
        self.keyCollection.isDirectionalLockEnabled = false
        self.keyCollection.clipsToBounds = false
        self.keyCollection.isPrefetchingEnabled = true // this doesn't fix the scroll update delay problem
        
        self.view.addSubview(self.keyCollection)
        
        self.keyCollection.translatesAutoresizingMaskIntoConstraints = false
        self.keyCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.keyCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.keyCollection.topAnchor.constraint(equalTo: toolbarRow.view.bottomAnchor).isActive = true
        self.keyCollection.bottomAnchor.constraint(equalTo: self.backwardDeleteButton.topAnchor, constant: -6).isActive = true
        
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
        
        if self.needsInputModeSwitchKey {
            self.nextKeyboardButton = UIButton(type: .system)
            setupButton(button: self.nextKeyboardButton, title: NSLocalizedString("ABC", tableName: "Localizable", comment: "Switch keyboards"))
            self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allEvents)
            
            self.nextKeyboardButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12).isActive = true
            self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -6).isActive = true
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
