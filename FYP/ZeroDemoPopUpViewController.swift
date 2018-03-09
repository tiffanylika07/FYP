//
//  ZeroDemoPopUpViewController.swift
//  FYP
//
//  Created by Tiffany Li on 4/2/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit

class ZeroDemoPopUpViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        // Do any additional setup after loading the view.
    }

    @IBAction func closeBtnTapped(_ sender: Any) {
        self.view.removeFromSuperview()
        
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
