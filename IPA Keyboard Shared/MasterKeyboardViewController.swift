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
            view.addSubview(controllerToAdd.view)
            addChild(controllerToAdd)
            controllerToAdd.view.backgroundColor = .clear
            controllerToAdd.view.sizeToFit()
            controllerToAdd.view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        toolbarRow = UIHostingController(rootView: ToolbarRow(inputViewController: self))
        addHostingController(toolbarRow)
        
        bottomRow = UIHostingController(rootView: BottomRow(inputViewController: self, dataSource: bottomBarDataSource))
        addHostingController(bottomRow)
        
        // MARK: - Set up the collection view
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionHeadersPinToVisibleBounds = true
        
        keyCollection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        keyCollection.backgroundColor = .clearInteractable
        keyCollection.register(KeyButtonCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        keyCollection.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifier)
        
        keyCollection.isDirectionalLockEnabled = false
        keyCollection.isPrefetchingEnabled = true // this doesn't fix the scroll update delay problem
        
        view.addSubview(keyCollection)
        
        keyCollection.translatesAutoresizingMaskIntoConstraints = false
        
        let insetsTotalHeight = topInset + bottomInset
        let cellTotalHeight = CGFloat(cellsPerColumn) * cellSize
        let spacingTotalHeight = CGFloat(cellsPerColumn - 1) * minimumInteritemSpacing
        let keyCollectionHeight = insetsTotalHeight + cellTotalHeight + spacingTotalHeight
        keyCollection.heightAnchor.constraint(equalToConstant: keyCollectionHeight).isActive = true
        
        // MARK: - Set up constraints
        
        Constraints.applyEqual(pairs: [
            (toolbarRow.view.leadingAnchor, view.leadingAnchor),
            (toolbarRow.view.trailingAnchor, view.trailingAnchor),
            (bottomRow.view.trailingAnchor, view.trailingAnchor),
            (keyCollection.leadingAnchor, view.leadingAnchor),
            (keyCollection.trailingAnchor, view.trailingAnchor),
        ])
        
        Constraints.applyEqual(pairs: [
            (toolbarRow.view.topAnchor, view.topAnchor),
            (bottomRow.view.bottomAnchor, view.bottomAnchor),
            (keyCollection.topAnchor, toolbarRow.view.bottomAnchor),
            (keyCollection.bottomAnchor, bottomRow.view.topAnchor),
        ])
        
        // MARK: - Set up input mode switch button if needed
        
        let actuallyNeedsInputModeSwitchKey = needsInputModeSwitchKey || UIDevice.current.userInterfaceIdiom != .phone
        
        if actuallyNeedsInputModeSwitchKey {
            nextKeyboardButton = UIKitComponents.inputSwitchButton()
            view.addSubview(nextKeyboardButton)
                
            nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allEvents) // cannot implement in SwiftUI
            
            Constraints.applyEqual(pairs: [
                (nextKeyboardButton.leadingAnchor, view.leadingAnchor),
                (bottomRow.view.leadingAnchor, nextKeyboardButton.trailingAnchor),
            ])
            
            Constraints.applyEqual(nextKeyboardButton.centerYAnchor, bottomRow.view.centerYAnchor)
        } else {
            Constraints.applyEqual(bottomRow.view.leadingAnchor, view.leadingAnchor)
        }
        
        // MARK: - Set up the expanded key overlay
        
        expandedKeyOverlay = ExpandedKeyOverlay()
        view.addSubview(expandedKeyOverlay)
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
            
            let originalRect = keyCollection.convert(keyButtonCell.frame, to: expandedKeyOverlay.superview)
            
            expandedKeyOverlay.show(
                title: keyButtonCell.delegate.title,
                frame: CGRect(x: originalRect.midX, y: originalRect.midY, width: originalRect.width, height: originalRect.height)
            )
        } else {
            fatalError("Incorrect button setup.")
        }
    }
    
    @objc func keyButtonRetract(from button: UIButton, with event: UIEvent) {
        if let keyButtonCell = button.superview?.superview as? KeyButtonCell {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { [weak self] _ in
                keyButtonCell.delegate.isPressed = false
                self?.expandedKeyOverlay.hide()
            }
        } else {
            fatalError("Incorrect button setup.")
        }
    }
}
