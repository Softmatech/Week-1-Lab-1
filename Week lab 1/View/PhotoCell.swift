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
    let placeholderURL = URL(string: "https://httpbin.org/image/png")!
    let placeholderImage = UIImage(named: "placeholder")
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageCellView.af_setImage(withURL: placeholderURL,placeholderImage: placeholderImage)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
