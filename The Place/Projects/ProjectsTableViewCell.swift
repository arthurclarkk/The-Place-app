//
//  ProjectsTableViewCell.swift
//  The Place
//
//  Created by Arthur Daniyarov on 17.02.2020.
//  Copyright © 2020 Arthur Daniyarov. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var upDateLabel: UILabel!
    
    @IBOutlet weak var expDateLabel: UILabel!
    
    @IBOutlet weak var hashtagLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
