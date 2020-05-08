//
//  KeyButtonCell.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 2018/9/11.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import UIKit

class KeyButtonCell: UICollectionViewCell {
    
    // MARK: - Constants and Variables
    
    let button = UIButton(type: .system)
    let altLabel = UILabel()
    
    private let cornerRadius: CGFloat = 4
    private let expansionConstant: CGFloat = -64
    
    private var topConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    
    var topExpandedConstraint: NSLayoutConstraint!
    
    private var isExpandedInternal = false
    var isExpanded: Bool {
        get {
            return isExpandedInternal
        }
    }
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(button)
        self.contentView.addSubview(altLabel)
        
        self.button.sizeToFit()
        self.altLabel.sizeToFit()
        self.button.titleLabel?.lineBreakMode = .byClipping // to make sure overflow is not hidden by ellipsis
        self.altLabel.lineBreakMode = .byClipping
        
        self.altLabel.font = self.altLabel.font.withSize(32)
        self.altLabel.textAlignment = .center
        
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.altLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.topConstraint = self.button.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        self.bottomConstraint = self.button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        self.leadingConstraint = self.button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        self.trailingConstraint = self.button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        
        self.topExpandedConstraint = self.button.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: expansionConstant)
        
        self.addConstraint(self.bottomConstraint)
        self.addConstraint(self.leadingConstraint)
        self.addConstraint(self.trailingConstraint)
        
        self.altLabel.topAnchor.constraint(equalTo: self.button.topAnchor, constant: 2).isActive = true
        self.altLabel.widthAnchor.constraint(equalTo: self.button.widthAnchor).isActive = true
        self.altLabel.centerXAnchor.constraint(equalTo: self.button.centerXAnchor).isActive = true
        
        self.button.layer.cornerRadius = self.cornerRadius
        self.button.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.masksToBounds = false
        
        self.contentView.clipsToBounds = false
        
        self.keyRetract()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func keyExpand() {
        self.isExpandedInternal = true
        self.removeConstraint(self.topConstraint)
        self.addConstraint(self.topExpandedConstraint)
        self.altLabel.isHidden = false
        
        self.altLabel.textColor = self.button.titleColor(for: .normal)
        
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: self.bounds.minX, y: self.bounds.minY + expansionConstant + 1, width: self.bounds.width, height: self.bounds.height - expansionConstant + 1), cornerRadius: self.button.layer.cornerRadius).cgPath
    }
    
    func keyRetract() {
        self.isExpandedInternal = false
        self.removeConstraint(self.topExpandedConstraint)
        self.addConstraint(self.topConstraint)
        self.altLabel.isHidden = true
        
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0.25
        self.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: self.bounds.minX, y: self.bounds.minY, width: self.bounds.width, height: self.bounds.height + 1), cornerRadius: self.button.layer.cornerRadius).cgPath
    }
}
