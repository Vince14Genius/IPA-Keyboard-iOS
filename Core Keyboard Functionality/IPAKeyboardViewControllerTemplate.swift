//
//  IPAKeyboardViewControllerTemplate.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 2019/7/25.
//  Copyright © 2019 Vince14Genius. All rights reserved.
//

import UIKit
import SwiftUI

class IPAKeyboardViewControllerTemplate: UIInputViewController, UICollectionViewDelegateFlowLayout, LayoutSwitcherDelegate {
    
    // MARK: - UI Elements
    
    @IBOutlet var keyCollection: UICollectionView!
    @IBOutlet var bottomStack: UIStackView!
    
    var toolbarRow: UIHostingController<ToolbarRow>!
    var bottomRow: UIHostingController<BottomRow>!
    
    var expandedKeyOverlay: ExpandedKeyOverlay!
    var fakeKeyCollection: UIHostingController<FakeKeyCollection>!
    
    @IBOutlet var nextKeyboardButton: InputSwitchButton?
    
    // MARK: - States
    
    let bottomBarDataSource = BottomRowDataSource()
    let cursorGestureState = CursorGestureState()
    let layoutSwitcherState = LayoutSwitcherState()
    
    var currentLayout: KeyboardLayout.Type = IPASymbols.self {
        didSet {
            keyCollection.reloadData()
            refreshBottomBarDataSource()
            scrollTo(section: 0, fraction: 0)
        }
    }
    
    func refreshBottomBarDataSource() {
        bottomBarDataSource.sectionGlyphs = currentLayout.sectionNames.map {
            currentLayout.sectionData[$0]!.sectionGlyph
        }
    }
    
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
        
        toolbarRow = UIHostingController(rootView: ToolbarRow(
            cursorGestureState: cursorGestureState,
            layoutSwitcherState: layoutSwitcherState,
            inputViewController: self
        ))
        addHostingController(toolbarRow)
        
        bottomRow = UIHostingController(rootView: BottomRow(
            inputViewController: self,
            dataSource: bottomBarDataSource,
            cursorGestureState: cursorGestureState,
            layoutSwitcherState: layoutSwitcherState
        ))
        addHostingController(bottomRow)
        
        fakeKeyCollection = UIHostingController(rootView: FakeKeyCollection(cursorGestureState: cursorGestureState))
        addHostingController(fakeKeyCollection)
        fakeKeyCollection.view?.layer.zPosition = -1
        
        layoutSwitcherState.controller = self
        
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
        
        // setup show/hide for the cursor gesture
        cursorGestureState.showKeyCollection = { [weak self] in
            self?.keyCollection.isHidden = false
        }
        cursorGestureState.hideKeyCollection = { [weak self] in
            self?.keyCollection.isHidden = true
        }
        
        // MARK: - Set up constraints
        
        keyCollection.heightAnchor.constraint(equalToConstant: Layout.keyCollectionHeight).isActive = true
        
        Constraints.applyEqual(hPairs: [
            (toolbarRow.view.leadingAnchor, view.leadingAnchor),
            (toolbarRow.view.trailingAnchor, view.trailingAnchor),
            (bottomRow.view.trailingAnchor, view.trailingAnchor),
            (keyCollection.leadingAnchor, view.leadingAnchor),
            (keyCollection.trailingAnchor, view.trailingAnchor),
            (fakeKeyCollection.view.leadingAnchor, keyCollection.leadingAnchor),
            (fakeKeyCollection.view.trailingAnchor, keyCollection.trailingAnchor),
        ], vPairs: [
            (toolbarRow.view.topAnchor, view.topAnchor),
            // bottom row constant will depend on
            // whether input switch button is needed
            (keyCollection.topAnchor, toolbarRow.view.bottomAnchor),
            (keyCollection.bottomAnchor, bottomRow.view.topAnchor),
            (fakeKeyCollection.view.topAnchor, keyCollection.topAnchor),
            (fakeKeyCollection.view.bottomAnchor, keyCollection.bottomAnchor),
        ])
        
        // MARK: - Set up input mode switch button if needed
        
        var shouldShowInputModeSwitchKey = false
        
        shouldShowInputModeSwitchKey ||= needsInputModeSwitchKey
        shouldShowInputModeSwitchKey ||= UIDevice.current.userInterfaceIdiom != .phone
        
        // check isInputSwitchKeyAlwaysOn
        if let isInputSwitchKeyAlwaysOn = UserDefaults(suiteName: SharedIdentifiers.appGroup)?.bool(forKey: SettingsKey.isInputSwitchKeyAlwaysOn) {
            shouldShowInputModeSwitchKey ||= isInputSwitchKeyAlwaysOn
        }
        
        // bottom row bottom anchor constraint
        bottomRow.view.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: shouldShowInputModeSwitchKey ? -8 : 0
        ).isActive = true
        
        if shouldShowInputModeSwitchKey {
            nextKeyboardButton = .init()
            let button = nextKeyboardButton!
            
            view.addSubview(button)
            button.updateInsets(inputViewController: self)
                
            button.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allEvents) // cannot implement in SwiftUI
            
            Constraints.applyEqual(pairs: [
                (button.leadingAnchor, view.leadingAnchor),
                (bottomRow.view.leadingAnchor, button.trailingAnchor),
            ])
            
            Constraints.applyEqual(button.centerYAnchor, bottomRow.view.centerYAnchor)
        } else {
            Constraints.applyEqual(bottomRow.view.leadingAnchor, view.leadingAnchor)
        }
        
        // MARK: - Set up the expanded key overlay
        
        expandedKeyOverlay = ExpandedKeyOverlay()
        view.addSubview(expandedKeyOverlay)
    }
    
    // MARK: - re-render hosting controllers
    
    private func rerenderHostingControllers() {
        toolbarRow.rootView = ToolbarRow(
            cursorGestureState: cursorGestureState,
            layoutSwitcherState: layoutSwitcherState,
            inputViewController: self
        )
        
        bottomRow.rootView = BottomRow(
            inputViewController: self,
            dataSource: bottomBarDataSource,
            cursorGestureState: cursorGestureState,
            layoutSwitcherState: layoutSwitcherState
        )
        
        nextKeyboardButton?.updateInsets(inputViewController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        rerenderHostingControllers()
    }
    
    // MARK: - Other Boilerplate Code
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
        rerenderHostingControllers()
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
        
        let medianSectionIndex = visibleItems.count == 0 ? 0 : visibleItems[visibleItems.count / 2].section
        bottomBarDataSource.highlightedSectionIndex = medianSectionIndex
    }
    
    func scrollTo(section: Int, keyboardLayout: KeyboardLayout.Type) {
        let middleIndex = (keyboardLayout.getKeySet(section: section)?.count ?? 0) / 2
        
        // Calculate columns on screen
        let visibleItemsCount = keyCollection.indexPathsForVisibleItems.count
        
        if middleIndex > visibleItemsCount / 2 + Layout.cellsPerColumn {
            // big section
            keyCollection.scrollToItem(at: [section, visibleItemsCount / 2 - Layout.cellsPerColumn], at: .centeredHorizontally, animated: true)
        } else {
            // small section
            keyCollection.scrollToItem(at: [section, middleIndex], at: .centeredHorizontally, animated: true)
        }
    }
    
    func scrollTo(section: Int, fraction: Double) {
        guard
            0 <= section,
            section < keyCollection.numberOfSections,
            0 <= fraction,
            fraction < 1
        else {
            return
        }
        
        let fractionIndex = Double(keyCollection.numberOfItems(inSection: section)) * fraction
        
        keyCollection.scrollToItem(
            at: [section, Int(fractionIndex)],
            at: .left,
            animated: false
        )
    }
}
