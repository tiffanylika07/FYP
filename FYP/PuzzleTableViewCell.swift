//
//  PuzzleTableViewCell.swift
//  FYP
//
//  Created by Tiffany Li on 30/1/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit

class PuzzleTableViewCell: UITableViewCell {

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
