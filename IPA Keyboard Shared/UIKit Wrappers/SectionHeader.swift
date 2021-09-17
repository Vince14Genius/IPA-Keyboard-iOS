//
//  SectionHeader.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 2018/9/9.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    let label = UILabel(frame: CGRect(x: 12, y: 0, width: 240, height: 24))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        self.layer.zPosition = -1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        self.layer.zPosition = -1
    }
}
