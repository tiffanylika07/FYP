//
//  MenuTableViewCell.swift
//  FYP
//
//  Created by Tiffany Li on 6/1/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var menuLbl: UILabel!
    @IBOutlet weak var menuIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
