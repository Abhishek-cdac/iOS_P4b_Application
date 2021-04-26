//
//  LatestNewsTableViewCell.swift
//  p4b
//
//  Created by Sagar Ranshur on 20/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

class LatestNewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
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
