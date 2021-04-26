//
//  ProjectsTableCell.swift
//  p4b
//
//  Created by Govind on 02/12/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

class ProjectsTableCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblClient: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
