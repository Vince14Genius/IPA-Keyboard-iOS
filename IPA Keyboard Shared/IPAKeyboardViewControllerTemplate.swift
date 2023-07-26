//
//  IPAKeyboardViewControllerTemplate.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 2019/7/25.
//  Copyright © 2019 Vince14Genius. All rights reserved.
//

import UIKit
import SwiftUI

class IPAKeyboardViewControllerTemplate: UIInputViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Constants
    
    @IBOutlet var keyCollection: UICollectionView!
    @IBOutlet var bottomStack: UIStackView!
    
    var toolbarRow: UIHostingController<ToolbarRow>!
    var bottomRow: UIHostingController<BottomRow>!
    
    var expandedKeyOverlay: ExpandedKeyOverlay!
    
    let bottomBarDataSource = BottomRowDataSource()
    
    // Bottom buttons
    @IBOutlet var nextKeyboardButton: UIButton!
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Set up hosting controllers
        
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
        
        // setup flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionHeadersPinToVisibleBounds = true
        
        // make UICollectionView
        keyCollection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        view.addSubview(keyCollection)
        keyCollection.translatesAutoresizingMaskIntoConstraints = false
        
        // UICollectionView settings
        keyCollection.backgroundColor = .clearInteractable
        keyCollection.isDirectionalLockEnabled = false
        keyCollection.isPrefetchingEnabled = true
        
        // register reusable views
        keyCollection.register(KeyButtonCell.self, forCellWithReuseIdentifier: CollectionViewConstants.reuseIdentifier)
        keyCollection.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewConstants.reuseIdentifier)
        
        // MARK: - Set up constraints
        
        keyCollection.heightAnchor.constraint(equalToConstant: Layout.keyCollectionHeight).isActive = true
        
        Constraints.applyEqual(hPairs: [
            (toolbarRow.view.leadingAnchor, view.leadingAnchor),
            (toolbarRow.view.trailingAnchor, view.trailingAnchor),
            (bottomRow.view.trailingAnchor, view.trailingAnchor),
            (keyCollection.leadingAnchor, view.leadingAnchor),
            (keyCollection.trailingAnchor, view.trailingAnchor),
        ], vPairs: [
            (toolbarRow.view.topAnchor, view.topAnchor),
            (bottomRow.view.bottomAnchor, view.bottomAnchor),
            (keyCollection.topAnchor, toolbarRow.view.bottomAnchor),
            (keyCollection.bottomAnchor, bottomRow.view.topAnchor),
        ])
        
        // MARK: - Set up input mode switch button if needed
        
        var shouldShowInputModeSwitchKey = false
        
        shouldShowInputModeSwitchKey ||= needsInputModeSwitchKey
        shouldShowInputModeSwitchKey ||= UIDevice.current.userInterfaceIdiom != .phone
        
        if let isInputSwitchKeyAlwaysOn = UserDefaults(suiteName: SharedIdentifiers.appGroup)?.bool(forKey: SettingsKey.isInputSwitchKeyAlwaysOn) {
            shouldShowInputModeSwitchKey ||= isInputSwitchKeyAlwaysOn
        }
        
        if shouldShowInputModeSwitchKey {
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
    
    // MARK: - Helper Methods
    
    /**
    Update the colors of all section header text, based on the system keyboard color.
    - Parameters:
       - header: the `SectionHeader` to set up
    */
    func setSectionHeaderColor(_ header: SectionHeader) {
        header.label.textColor = .secondaryLabel
    }
    
    func updateBottomButtons() {
        let visibleItems = keyCollection.indexPathsForVisibleItems.sorted {
            return $0.section < $1.section
        }
        
        let medianSectionIndex = visibleItems[visibleItems.count / 2].section
        bottomBarDataSource.highlightedSectionIndex = medianSectionIndex
    }
    
    func scrollToSection(index: Int, in keyboardLayout: KeyboardLayout.Type) {
        let middleIndex = (keyboardLayout.getKeySet(section: index)?.count ?? 0) / 2
        
        // Calculate columns on screen
        let visibleItemsCount = keyCollection.indexPathsForVisibleItems.count
        
        if middleIndex > visibleItemsCount / 2 + Layout.cellsPerColumn {
            // big section
            keyCollection.scrollToItem(at: [index, visibleItemsCount / 2 - Layout.cellsPerColumn], at: .centeredHorizontally, animated: true)
        } else {
            // small section
            keyCollection.scrollToItem(at: [index, middleIndex], at: .centeredHorizontally, animated: true)
        }
    }
}