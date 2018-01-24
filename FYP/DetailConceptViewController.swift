//
//  DetailConceptViewController.swift
//  FYP
//
//  Created by Tiffany Li on 24/1/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit

class DetailConceptViewController: UIViewController {
    @IBOutlet weak var conceptTitle: UILabel!
    
    @IBOutlet weak var puzzleBtn: UIImageView!
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    var selectedCellName = ""
    var selectedCellID = 0
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conceptTitle.text = selectedCellName
        let preferredDescriptor = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        conceptTitle.font = UIFont(name: "Neucha", size: 40)
        conceptTitle.adjustsFontSizeToFitWidth = true
        titleView.backgroundColor = bgColor
        titleView.layer.cornerRadius = 10.00
        contentView.backgroundColor = bgColor?.withAlphaComponent(0.5)
        print(selectedCellID)
        // Do any additional setup after loading the view.
        
        self.puzzleBtn.frame.origin.y = self.puzzleBtn.frame.minY
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
