//
//  TextFieldLabel.swift
//  p4b
//
//  Created by Sagar Ranshur on 17/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class DesignableLable: UILabel {
    @IBInspectable var stringLocalizationKey: String = ""{
        didSet{
            text = stringLocalizationKey.localized
            setup()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup(){
        textAlignment = NSTextAlignment.center
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        self.preferredMaxLayoutWidth = self.frame.size.width
        self.layoutIfNeeded()
    }

    override func prepareForInterfaceBuilder() {
        let bundle = Bundle(for: type(of: self))
        self.text = bundle.localizedString(forKey: self.stringLocalizationKey, value:"", table: nil)
    }
}
