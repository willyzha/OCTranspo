//
//  TableViewCell.swift
//  OCTranspoV5
//
//  Created by Willy Zhang on 2014-12-22.
//  Copyright (c) 2014 Willy Zhang. All rights reserved.
//

import UIKit

class StopTableViewCell: UITableViewCell {

    @IBOutlet weak var stopName: UILabel!
    @IBOutlet weak var stopCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
