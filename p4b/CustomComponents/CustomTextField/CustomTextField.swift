//
//  CustomTextField.swift
//  CustomField
//
//  Created by Sagar Ranshur on 21/04/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

class CustomTextField: UIView, UITextFieldDelegate {

    @IBOutlet weak var textBaseView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var baseWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var baseHeightView: NSLayoutConstraint!
    
    @IBInspectable var placeHolder: String = "" {
        didSet {
            
            self.textField.placeholder = NSLocalizedString(placeHolder, comment:"");

//            #if TARGET_INTERFACE_BUILDER
//            var bundle = NSBundle(forClass: type(of: self))
//                self.textField.placeholder = bundle.localizedStringForKey(placeHolder, value:"", table: nil)
//            #else
//                self.textField.placeholder = NSLocalizedString(placeHolder, comment:"");
//            #endif
            
        }
    }
        
    @IBInspectable var activeColor : CGColor = UIColor.lightGray.cgColor {
        didSet {
            underlineView.layer.borderColor = activeColor
        }
    }
    
    var selectionColor : UIColor?
    var underlineColor : UIColor?
    var isMobile : Bool = false
    var extensionStr : String = ""
    
    let nibName = "CustomTextField"
    
    var contentView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // When wants to load from UIView, then write into init with coder
        guard let view = loadFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        customSetUp()
    }
    
    //Loading From Nib
    func loadFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func customSetUp() {
    
        placeHolderLabel.text = ""
        underlineView.backgroundColor = UIColor.white
        baseWidthConstraint.constant = 0
        textField.placeholder = placeHolder
        textField.delegate = self
        hideErrorMessage()

        textField.addTarget(self, action: #selector(self.textDidChange(_:)), for: .editingChanged)
    }
    
    func changeTextProperties() {
        
        placeHolderLabel.text = NSLocalizedString(placeHolder, comment: "")
        underlineView.backgroundColor = UIColor.white
        baseWidthConstraint.constant = placeHolderLabel.getLabelWidth()
        underlineView.layer.borderColor = UIColor.init(hexString: Constants.HexColors.activeColor).cgColor
        placeHolderLabel.textColor = .black
        hideErrorMessage()
    }
    
    func resetTextField() {
        if isMobile {
            textField.text = ""
        }
        placeHolderLabel.text = ""
        underlineView.backgroundColor = UIColor.white
        baseWidthConstraint.constant = 0
        underlineView.layer.borderColor = activeColor

        textField.placeholder = placeHolder
        hideErrorMessage()
    }
    
    //MARK: - Show/Hide Error Message
    //MARK: -
    
    func showErrorMessage(errorMessage : String) {
        errorMsg.textColor = .red
        errorMsg.text = errorMessage
        placeHolderLabel.text = placeHolder
        placeHolderLabel.textColor = .lightGray
        baseWidthConstraint.constant = placeHolderLabel.getLabelWidth()
        underlineView.layer.borderColor = UIColor.red.cgColor
    }
    
    func hideErrorMessage() {
        errorMsg.textColor = .clear
        errorMsg.text = ""
    }

    //MARK: - Text field delegate methods
    //MARK: -
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if isMobile {
            if textField.text?.count == 0 {
                textField.text = extensionStr + " "
            }
        }

//        changeTextProperties()
    }
    
    @objc func textDidChange(_ textField: UITextField) {
        if textField.text?.count == 0 {
            resetTextField()
        }else {
            changeTextProperties()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if isMobile {
            if textField.text?.count == 0 {
                textField.text = extensionStr + " "
                return false
            }else if string == "" {
                if textField.text?.count == 5 {
                    return false
                }
            }else if textField.text!.count >= 14 {
                return false
            }
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        return true
    }
}
