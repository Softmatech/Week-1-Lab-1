//
//  TableViewCell.swift
//  Week lab 1
//
//  Created by Joseph Andy Feidje on 9/14/18.
//  Copyright © 2018 Softmatech. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var imageCellView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
