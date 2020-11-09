//
//  CustomAlertView.swift
//  CustomComponents
//
//  Created by Sagar Ranshur on 14/04/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

protocol CustomAlertDelegate {
    func okButtonClicked()
    func cancelButtonClicked()
    func centeredButtonClicked()
}

class CustomAlertView: UIView {
    @IBOutlet weak var customAlertBaseView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var centeredOkBtn: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    
    var delegate : CustomAlertDelegate?
    
    let nibName = "CustomAlertView"
    var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        guard let view = loadViewFromNib() else {return}
        setUpCustomAlertView()
        view.frame = self.bounds
        self.addSubview(view)
        self.contentView = view
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setUpCustomAlertView() {
        customAlertBaseView.layer.cornerRadius = 15
    
        okButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        centeredOkBtn.layer.cornerRadius = 10

        customAlertBaseView.layer.shadowColor = UIColor.black.cgColor
        customAlertBaseView.layer.shadowOffset = CGSize.init(width: 0, height: 2)
        customAlertBaseView.layer.shadowRadius = 4
        customAlertBaseView.layer.shadowOpacity = 0.6
    }
    
    func setupAlertWith(isSingle: Bool, isSuccess: Bool, title: String, message: String, image: String) {
        
        iconImage.image = UIImage.init(named: image)

        if isSingle {
            okButton.isHidden = true
            cancelButton.isHidden = true
            centeredOkBtn.isHidden = false
            titleLabel.text = title
            messageLabel.text = message
            
        }else {
            if isSuccess {
                okButton.isHidden = false
                cancelButton.isHidden = false
                centeredOkBtn.isHidden = true
                titleLabel.text = title
                messageLabel.text = message
            }else {
                okButton.isHidden = false
                cancelButton.isHidden = false
                centeredOkBtn.isHidden = true
                titleLabel.text = title
                messageLabel.text = message
            }
        }
    }
    
    func showAlert(view: UIView) {
        let windows = UIApplication.shared.windows
        
        let lastWindow = windows.last
        contentView?.frame = UIScreen.main.bounds
        lastWindow?.addSubview(contentView!)
    }

    func removeAlert(view: UIView) {
        view.removeFromSuperview()
    }
    
    @IBAction func okButtonClicked(_ sender: UIButton) {
        delegate?.okButtonClicked()
    }
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        delegate?.cancelButtonClicked()
    }
    
    @IBAction func centeredOkClickEvent(_ sender: UIButton) {
        delegate?.centeredButtonClicked()
    }
}
