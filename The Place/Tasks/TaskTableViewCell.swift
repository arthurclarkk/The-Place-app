//
//  TaskTableViewCell.swift
//  The Place
//
//  Created by Arthur Daniyarov on 09.02.2020.
//  Copyright © 2020 Arthur Daniyarov. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var cardLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
