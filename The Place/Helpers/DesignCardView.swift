//
//  DesignCardView.swift
//  The Place
//
//  Created by Arthur Daniyarov on 10.02.2020.
//  Copyright © 2020 Arthur Daniyarov. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable class DesignCardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    
    @IBInspectable var shadowOffSetWidth: Int = 0
    @IBInspectable var shadowOffSetHeight: Int = 2
    
    @IBInspectable var shadowOpacity: Float = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
    }
    
}
