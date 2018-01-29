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
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet var btnTouchRecognizer: UITapGestureRecognizer!
    
    var selectedCellName = ""
    var selectedCellID = 0
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conceptTitle.text = selectedCellName
        conceptTitle.font = UIFont(name: "Neucha", size: 40)
        conceptTitle.adjustsFontSizeToFitWidth = true
        titleView.backgroundColor = bgColor
        //titleView.layer.cornerRadius = 10.00
        containerView.backgroundColor = adjustColor(aColor: bgColor!,by: 30.0)
        buttonView.isUserInteractionEnabled = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //segueToContent
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
//            if let contentController = segue.destination as? ContentViewController{
//                contentController.bgColor = adjustColor(aColor: bgColor!, by: 30.0)
//            }
    }

    
    func buttonTapper(recognizer: UITapGestureRecognizer){
        print("Taooed")
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
