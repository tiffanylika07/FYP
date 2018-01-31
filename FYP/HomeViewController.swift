//
//  ViewController.swift
//  FYP
//
//  Created by Tiffany Li on 3/1/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeScreen: UIImageView!
    
    @IBOutlet weak var CategoryButton: UIImageView!
    @IBOutlet weak var PuzzleButton: UIImageView!
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
        InitializeView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func InitializeView(){
        let tapGesture_C = UITapGestureRecognizer(target: self, action: #selector(tapAction_Category(sender:)))
        tapGesture_C.numberOfTapsRequired = 1
        tapGesture_C.numberOfTouchesRequired = 1
        
        let tapGesture_P = UITapGestureRecognizer(target: self, action: #selector(tapAction_Puzzle(sender:)))
        
        tapGesture_P.numberOfTapsRequired = 1
        tapGesture_P.numberOfTouchesRequired = 1
        
        CategoryButton.addGestureRecognizer(tapGesture_C)
        PuzzleButton.addGestureRecognizer(tapGesture_P)
        
    }
    
    @objc func tapAction_Category(sender:UITapGestureRecognizer){
        performSegue(withIdentifier: "showCategory", sender: self)
        
    }
    @objc func tapAction_Puzzle(sender:UITapGestureRecognizer){
        performSegue(withIdentifier: "showPuzzle", sender: self)
        
        
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


