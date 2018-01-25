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
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var puzzleBtn: UIImageView!
    @IBOutlet weak var titleView: UIView!
    
    var selectedCellName = ""
    var selectedCellID = 0
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conceptTitle.text = selectedCellName
        conceptTitle.font = UIFont(name: "Neucha", size: 40)
        conceptTitle.adjustsFontSizeToFitWidth = true
        titleView.backgroundColor = bgColor
        titleView.layer.cornerRadius = 10.00
        contentView.backgroundColor = adjustColor(aColor: bgColor!,by: 30.0)
        print(selectedCellID)
        // Do any additional setup after loading the view.
        
        //self.puzzleBtn.frame.origin.y = self.puzzleBtn.frame.minY
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func adjustColor(aColor: UIColor,by percentage: CGFloat = 30.0 ) -> UIColor? {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
        if(aColor.getRed(&r, green: &g, blue: &b, alpha: &a)){
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        }else{
            return nil
        }
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
