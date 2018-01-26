//
//  ViewController.swift
//  FYP
//
//  Created by Tiffany Li on 3/1/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var homeScreen: UIImageView!
    override func viewDidLoad() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
             homeScreen.image = #imageLiteral(resourceName: "FYP_Main_Horizontal")
        }
        else if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            homeScreen.image = #imageLiteral(resourceName: "FYP_Main_Vertical")
        }
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            homeScreen.image = #imageLiteral(resourceName: "FYP_Main_Horizontal")
            
        }
        else {
            print("Portrait")
            homeScreen.image = #imageLiteral(resourceName: "FYP_Main_Vertical")
        }
    }
   

}

