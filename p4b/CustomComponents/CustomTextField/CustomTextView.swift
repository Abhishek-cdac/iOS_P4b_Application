//
//  CustomTextField.swift
//  CustomField
//
//  Created by Sagar Ranshur on 21/04/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

class CustomTextView: UIView, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var placeHolderLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var textBaseView: UIView!
    @IBInspectable var placeHolder: String = "" {
        didSet {
            self.textView.text = placeHolder.localised()
        }
    }
 
    @IBInspectable var activeColor : CGColor = UIColor.lightGray.cgColor {
        didSet {
            underlineView.layer.borderColor = activeColor
        }
    }
 
    var selectionColor : UIColor?
    var underlineColor : UIColor?
    var errorColor : UIColor?
    var isMobile : Bool = false
    var extensionStr : String = ""
    var firstTimeEdit: Bool = false
    
    let nibName = "CustomTextView"
    
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
        placeHolderLabelWidth.constant = 0
        textView.text = placeHolder
        textView.delegate = self
        hideErrorMessage()

    }
    
    func changeTextProperties() {
        
        placeHolderLabel.text = NSLocalizedString(placeHolder, comment: "")
        underlineView.backgroundColor = UIColor.white
        placeHolderLabelWidth.constant = placeHolderLabel.getLabelWidth()
        underlineView.layer.borderColor = UIColor.init(hexString: Constants.HexColors.activeColor).cgColor

        hideErrorMessage()
    }
    
    func resetTextField() {
        
        placeHolderLabel.text = ""
        underlineView.backgroundColor = UIColor.white
        placeHolderLabelWidth.constant = 0
        self.underlineView.layer.borderColor = UIColor.lightGray.cgColor

        textView.text = placeHolder
        textView.textColor = UIColor.lightGray
        
        hideErrorMessage()
    }
    
    //MARK: - Show/Hide Error Message
    //MARK: -
    
    func showErrorMessage(errorMessage : String) {
        errorMsg.textColor = .red
        errorMsg.text = errorMessage
    }
    
    func hideErrorMessage() {
        errorMsg.textColor = .clear
        errorMsg.text = ""
    }

    //MARK: - Text View delegate methods
    //MARK: -
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {

            resetTextField()

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }

        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }

        // ...otherwise return false since the updates have already
        // been made
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count == 0 {
            resetTextField()
        }else {
            changeTextProperties()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .black
    }
    
}
