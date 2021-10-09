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
    
    var toolbarRow: UIHostingController<ToolbarRow>!
    var bottomRow: UIHostingController<BottomRow>!
    
    var expandedKeyOverlay: ExpandedKeyOverlay!
    
    let bottomBarDataSource = BottomRowDataSource()
    
    // Bottom buttons
    @IBOutlet var nextKeyboardButton: UIButton!
    
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
                return IPASymbols.numberOfRowsForLargeDisplay
            default:
                return IPASymbols.numberOfRowsForRegularDisplay
            }
        }
    }
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Perform custom UI setup here
        
        func addHostingController<T>(_ controllerToAdd: UIHostingController<T>) {
            self.view.addSubview(controllerToAdd.view)
            self.addChild(controllerToAdd)
            controllerToAdd.view.backgroundColor = .clear
            controllerToAdd.view.sizeToFit()
            controllerToAdd.view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.toolbarRow = UIHostingController(rootView: ToolbarRow(inputViewController: self))
        addHostingController(self.toolbarRow)
        
        self.bottomRow = UIHostingController(rootView: BottomRow(inputViewController: self, dataSource: self.bottomBarDataSource))
        addHostingController(self.bottomRow)
        
        // MARK: - Set up constraints
        
        self.toolbarRow.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.toolbarRow.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.toolbarRow.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
        self.bottomRow.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.bottomRow.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // MARK: - Set up the collection view
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionHeadersPinToVisibleBounds = true
        
        self.keyCollection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        self.keyCollection.backgroundColor = .clearInteractable
        self.keyCollection.register(KeyButtonCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
        self.keyCollection.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.reuseIdentifier)
        
        self.keyCollection.isDirectionalLockEnabled = false
        self.keyCollection.isPrefetchingEnabled = true // this doesn't fix the scroll update delay problem
        
        self.view.addSubview(self.keyCollection)
        
        self.keyCollection.translatesAutoresizingMaskIntoConstraints = false
        self.keyCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.keyCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.keyCollection.topAnchor.constraint(equalTo: toolbarRow.view.bottomAnchor).isActive = true
        self.keyCollection.bottomAnchor.constraint(equalTo: bottomRow.view.topAnchor).isActive = true
        
        let insetsTotalHeight = topInset + bottomInset
        let cellTotalHeight = CGFloat(cellsPerColumn) * cellSize
        let spacingTotalHeight = CGFloat(cellsPerColumn - 1) * minimumInteritemSpacing
        let keyCollectionHeight = insetsTotalHeight + cellTotalHeight + spacingTotalHeight
        self.keyCollection.heightAnchor.constraint(equalToConstant: keyCollectionHeight).isActive = true
        
        // MARK: - Set up input mode switch button if needed
        
        if self.needsInputModeSwitchKey {
            self.nextKeyboardButton = UIButton(type: .system)
            
            self.view.addSubview(self.nextKeyboardButton)
            
            self.nextKeyboardButton.setImage(UIImage(systemName: "globe"), for: [])
            self.nextKeyboardButton.tintColor = .label
            
            self.nextKeyboardButton.sizeToFit()
            self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
            
            self.nextKeyboardButton.layer.cornerRadius = 4
            self.nextKeyboardButton.backgroundColor = .clearInteractable
                
            self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allEvents)
            
            self.nextKeyboardButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12).isActive = true
            self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -14).isActive = true
            self.bottomRow.view.leadingAnchor.constraint(equalTo: self.nextKeyboardButton.trailingAnchor, constant: 12).isActive = true
        } else {
            self.bottomRow.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        }
        
        // MARK: - Set up the expanded key overlay
        
        self.expandedKeyOverlay = ExpandedKeyOverlay()
        self.view.addSubview(self.expandedKeyOverlay)
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
    
    /**
    Update the colors of all section header text, based on the system keyboard color.
    - Parameters:
       - header: the `SectionHeader` to set up
    */
    func setSectionHeaderColor(_ header: SectionHeader) {
        header.label.textColor = .secondaryLabel
    }
    
    // MARK: - Button Actions
    
    @objc func keyButtonExpand(from button: UIButton, with event: UIEvent) {
        if let keyButtonCell = button.superview?.superview as? KeyButtonCell {
            keyButtonCell.delegate.isPressed = true
            
            let originalRect = self.keyCollection.convert(keyButtonCell.frame, to: self.expandedKeyOverlay.superview)
            
            self.expandedKeyOverlay.show(
                title: keyButtonCell.delegate.title,
                frame: CGRect(x: originalRect.midX, y: originalRect.midY, width: originalRect.width, height: originalRect.height)
            )
        } else {
            fatalError("Incorrect button setup.")
        }
    }
    
    @objc func keyButtonRetract(from button: UIButton, with event: UIEvent) {
        if let keyButtonCell = button.superview?.superview as? KeyButtonCell {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                keyButtonCell.delegate.isPressed = false
                self.expandedKeyOverlay.hide()
            }
        } else {
            fatalError("Incorrect button setup.")
        }
    }
}
