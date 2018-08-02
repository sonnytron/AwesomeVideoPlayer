//
//  UIButton+CALayer.swift
//  AwesomeVideoPlayer
//
//  Created by Sonny on 2018/08/02.
//  Copyright © 2018 Sonny. All rights reserved.
//

import UIKit

class InsetButton: UIButton {
    let contentInset = UIEdgeInsets(top: 3, left: 4, bottom: 3, right: 4)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect.inset(by: contentInset))
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicContentSize = super.intrinsicContentSize
        intrinsicContentSize.width += contentInset.left + contentInset.right
        intrinsicContentSize.height += contentInset.top + contentInset.bottom
        return intrinsicContentSize
    }
}
