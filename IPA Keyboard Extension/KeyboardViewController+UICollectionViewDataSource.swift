//
//  KeyboardViewController+UICollectionViewDataSource.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 5/24/22.
//  Copyright © 2022 Vince14Genius. All rights reserved.
//

import UIKit

extension KeyboardViewController: UICollectionViewDataSource {
    
    // MARK: - Collection View Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return IPASymbols.enabledSections.count
    }
    
    // numberOfItemsInSection:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numberOfItems = IPASymbols.getKeySet(section: section)?.count {
            return numberOfItems
        } else {
            fatalError("Section index overflow.")
        }
    }
    
    // cellForItemAt:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewConstants.reuseIdentifier, for: indexPath) as! KeyButtonCell
        cell.delegate.title = IPASymbols.getKeySet(section: indexPath.section)?[indexPath.item]
        initializeKeyButton(cell)
        return cell
    }
    
    // insetForSectionAt:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: Layout.topInset,
            left: Layout.leftInset(headerWidth: Layout.getHeaderWidth(keySet: IPASymbols.self, section: section)),
            bottom: Layout.bottomInset,
            right: Layout.rightInset
        )
    }
    
    // minimumLineSpacingForSectionAt:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.minimumLineSpacing
    }
    
    // minimumInteritemSpacingForSectionAt:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.minimumInteritemSpacing
    }
    
    // sizeForItemAt:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = Layout.topInset + Layout.bottomInset + collectionView.safeAreaInsets.top + collectionView.safeAreaInsets.bottom + Layout.minimumInteritemSpacing * CGFloat(Layout.cellsPerColumn - 1)
        let itemHeight = ((collectionView.bounds.size.height - marginsAndInsets) / CGFloat(Layout.cellsPerColumn)).rounded(.down)
        return CGSize(width: itemHeight, height: itemHeight)
    }
    
    // viewForSupplementaryElementOfKind:at:
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let element = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewConstants.reuseIdentifier, for: indexPath)
        if let header = element as? SectionHeader {
            // Pass touches to the views underneath
            header.isUserInteractionEnabled = false
            
            // Set the header title
            header.label.text = NSLocalizedString(IPASymbols.enabledSections[indexPath.section], comment: "Localized versions of the section names.")
            setSectionHeaderColor(header)
        }
        return element
    }
    
    // referenceSizeForHeaderInSection:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: Layout.getHeaderWidth(keySet: IPASymbols.self, section: section), height: 0)
    }
    
}
