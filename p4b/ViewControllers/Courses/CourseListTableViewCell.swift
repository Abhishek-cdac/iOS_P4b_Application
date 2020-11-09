//
//  CourseListTableViewCell.swift
//  p4b
//
//  Created by Sagar Ranshur on 15/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

protocol CourseProtocol {
    func enrollNowBtnClicked()
}

class CourseListTableViewCell: UITableViewCell {

    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseDurationLabel: UILabel!
    @IBOutlet weak var courseStartDateLabel: UILabel!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var applicantsLable: UILabel!
    
    var delegate: CourseProtocol? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    @IBAction func enrollNowBtnClicked(_ sender: UIButton) {
        if delegate != nil {
            delegate?.enrollNowBtnClicked()
        }
    }
}


