//
//  bookTableViewCell.swift
//  bookFirebase
//
//  Created by Amos Gwa on 11/19/16.
//  Copyright © 2016 Amos Gwa. All rights reserved.
//

import UIKit

class bookTableViewCell:UITableViewCell{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
