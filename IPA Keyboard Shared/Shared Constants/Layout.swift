//
//  Layout.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 5/24/22.
//  Copyright © 2022 Vince14Genius. All rights reserved.
//

import UIKit

enum Layout {
    public static let numberOfRowsForRegularDisplay = 4
    public static let numberOfRowsForLargeDisplay = 6
    
    public static let topInset: CGFloat = 24
    public static let bottomInset: CGFloat = 8
    public static let leftInsetRaw: CGFloat = 12
    public static func leftInset(headerWidth: CGFloat) -> CGFloat { return leftInsetRaw - headerWidth }
    public static let rightInset: CGFloat = 12
    public static let minimumLineSpacing: CGFloat = 4
    public static let minimumInteritemSpacing: CGFloat = 4
    
    public static var cellSize: CGFloat {
        get {
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                return 45
            default:
                return 38
            }
        }
    }
    
    public static var cellsPerColumn: Int {
        get {
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                return numberOfRowsForLargeDisplay
            default:
                return numberOfRowsForRegularDisplay
            }
        }
    }
    
    public static var keyCollectionHeight: CGFloat {
        let insetsTotalHeight = topInset + bottomInset
        let cellTotalHeight = CGFloat(cellsPerColumn) * cellSize
        let spacingTotalHeight = CGFloat(cellsPerColumn - 1) * minimumInteritemSpacing
        return insetsTotalHeight + cellTotalHeight + spacingTotalHeight
    }
    
    public static func getHeaderWidth(keySet: KeyboardLayout.Type, section: Int) -> CGFloat {
        guard section < keySet.enabledSections.count else {
            fatalError("Index out of range for section ID: \(section)")
        }
        
        // Calculate text width
        let sectionKey = keySet.enabledSections[section]
        let sectionHeaderText = NSLocalizedString(sectionKey, comment: "Localized versions of the section names.")
        let textSize = (sectionHeaderText as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)])
        let textWidth = textSize.width + leftInsetRaw + rightInset + minimumLineSpacing
        
        return textWidth
    }
}
