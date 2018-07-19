//
//  MyBusinessTableViewCell.swift
//  MAD App
//
//  Created by Nicholas Millard on 20/04/2018.
//  Copyright © 2018 Nicholas Millard. All rights reserved.
//

import UIKit

class MyBusinessTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessRating: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
