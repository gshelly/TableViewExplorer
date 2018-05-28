//
//  Extensions.swift
//  NameList
//
//  Created by shelly.gupta on 5/24/18.
//  Copyright © 2018 shelly.gupta. All rights reserved.
//

import UIKit

@IBDesignable
class RoundableImageView: UIImageView {
    
    var maskImageView = UIImageView()
    
    @IBInspectable var cornerRadius : CGFloat = 0.0{
        didSet {
            self.applyCornerRadius()
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.clear{
        didSet {
            self.applyCornerRadius()
        }
    }
    
    @IBInspectable var borderWidth : Double = 0{
        didSet {
            self.applyCornerRadius()
        }
    }
    
    @IBInspectable var circular : Bool = false{
        didSet {
            self.applyCornerRadius()
        }
    }
    
    @IBInspectable var maskImage: UIImage? {
        didSet {
            maskImageView.image = maskImage
            maskImageView.frame = bounds
            mask = maskImageView
        }
    }
    
    func applyCornerRadius()
    {
        if(self.circular) {
            self.layer.cornerRadius = self.bounds.size.height/2
            self.layer.masksToBounds = true
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = CGFloat(self.borderWidth)
        }else {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = CGFloat(self.borderWidth)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyCornerRadius()
    }
    
}
@IBDesignable
class RoundableButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            circularButton()
        }
    }
    @IBInspectable var circular : Bool = false {
        didSet {
            circularButton()
        }
    }
    
    func circularButton() {
        if(circular) {
            self.layer.cornerRadius = self.bounds.size.height/2
            self.layer.masksToBounds = true
        }
        else {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circularButton()
    }
}
