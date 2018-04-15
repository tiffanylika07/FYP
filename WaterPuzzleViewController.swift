//
//  WaterPuzzleViewController.swift
//  FYP
//
//  Created by Tiffany Li on 22/3/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit

class WaterPuzzleViewController: UIViewController {

    @IBOutlet weak var DescriptionView: UITextView!
    @IBOutlet weak var DescriptionBoxView: UIView!
    @IBOutlet weak var PuzzleAreaView: UIView!
    
    @IBOutlet weak var PuzzleTitle: UILabel!
    @IBOutlet weak var cup_5: UIImageView!
    @IBOutlet weak var cup_8: UIImageView!
    @IBOutlet weak var cup_12: UIImageView!
    
    @IBOutlet weak var vol_12: UILabel!
    @IBOutlet weak var vol_8: UILabel!
    @IBOutlet weak var vol_5: UILabel!
    
    @IBOutlet weak var label_12: UILabel!
    @IBOutlet weak var label_8: UILabel!
    @IBOutlet weak var label_5: UILabel!
    var descriptionBoxBGColor : UIColor!
    var descriptionBGColor : UIColor!
    
    
    var ori_location_12: CGPoint!
    var ori_location_8: CGPoint!
    var ori_location_5: CGPoint!
    var location_Next: CGPoint!
    
    var num_12 : Int!
    var num_8 : Int!
    var num_5 : Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DescriptionBoxView.layer.borderColor = UIColor.black.cgColor
        //DescriptionBoxView.layer.borderWidth = 1
        DescriptionBoxView.layer.cornerRadius = 20
        DescriptionView.layer.cornerRadius = 20
        DescriptionView.isEditable = false
        DescriptionBoxView.backgroundColor = descriptionBoxBGColor
        DescriptionView.backgroundColor = descriptionBGColor
        // Do any additional setup after loading the view.
        
        InitLocationData()
        InitDragGesture()
    }
    func InitLocationData(){
        location_Next = cup_12.center
        ori_location_12 = cup_12.center
        ori_location_8 = cup_8.center
        ori_location_5 = cup_5.center
        
        num_12 = 12
        num_8 = 0
        num_5 = 0

    }

    func InitDragGesture(){
        let dragGR_12 =     UIPanGestureRecognizer(target: self, action:  #selector(handleDrag(_:)))
        cup_12.isUserInteractionEnabled = true
        cup_12.addGestureRecognizer(dragGR_12)
        let dragGR_8 =     UIPanGestureRecognizer(target: self, action:  #selector(handleDrag(_:)))
        cup_8.isUserInteractionEnabled = true
        cup_8.addGestureRecognizer(dragGR_8)
        let dragGR_5 =     UIPanGestureRecognizer(target: self, action:  #selector(handleDrag(_:)))
        cup_5.isUserInteractionEnabled = true
        cup_5.addGestureRecognizer(dragGR_5)
    }
     var initial_center = CGPoint()
    
    @objc func handleDrag(_ dragGR: UIPanGestureRecognizer)
    {
        let translate = dragGR.translation(in: self.view)
        let temp = dragGR.view!

        
        //Record Original Location
       
        if(dragGR.state == UIGestureRecognizerState.began){
            initial_center = dragGR.view!.center
        }
        if(dragGR.state == .changed){
            temp.center = CGPoint(x: temp.center.x + translate.x, y: temp.center.y+translate.y)
            dragGR.setTranslation(CGPoint.zero, in: self.view)
        }
        if dragGR.state == UIGestureRecognizerState.ended {
            
            if(dragGR.view! == cup_12){
                if(cup_12.frame.intersects(cup_8.frame)){
                    cup_8.image = #imageLiteral(resourceName: "cup_filled")
                    if(num_8 != 8){
                        let temp = num_8!
                        print(temp)
                        num_8 = num_8 + num_12 > 8 ? 8 : num_8 + num_12
                        num_12 = num_12 + temp - 8 > 0 ?  num_12 + temp - 8 : 0
                    }
                }
                else if (cup_12.frame.intersects(cup_5.frame)){
                    cup_5.image = #imageLiteral(resourceName: "cup_filled")
                    if(num_5 != 5){
                        let temp = num_5!
                        num_5 = num_5 + num_12 > 5 ? 5 : num_5 + num_12
                        num_12 = num_12 + temp - 5 > 0 ?  num_12 + temp - 5 : 0
                    }
                }
            }
            else if (dragGR.view! == cup_8){
                if (cup_8.frame.intersects(cup_12.frame)){
                    cup_12.image = #imageLiteral(resourceName: "cup_filled")
                    if(num_12 != 12){
                        let temp = num_12!
                        num_12 = num_12 + num_8 > 12 ? 12 : num_8 + num_12
                        num_8 = num_8 + temp - 12 > 0 ? num_8 - temp > 0 ? num_8 - 12 : 0 : 0
                    }
                }
                else if (cup_8.frame.intersects(cup_5.frame)){
                    cup_5.image = #imageLiteral(resourceName: "cup_filled")
                    if(num_5 != 5){
                        let temp = num_5!
                        num_5 = num_5 + num_8 > 5 ? 5 : num_5 + num_8
                        num_8 = num_8 + temp - 5 > 0 ?  num_8 + temp - 5 : 0
                    }
                }
            }
            else if (dragGR.view! == cup_5){
                if (cup_5.frame.intersects(cup_12.frame)){
                    cup_12.image = #imageLiteral(resourceName: "cup_filled")
                    if(num_12 != 12){
                        let temp = num_12!
                        num_12 = num_12 + num_5 > 12 ? 12 : num_5 + num_12
                        num_5 = num_5 + temp - 12 > 0 ? num_5 - temp > 0 ? num_5 - 12 : 0 : 0
                    }
                }
                else if (cup_5.frame.intersects(cup_8.frame)){
                    cup_8.image = #imageLiteral(resourceName: "cup_filled")
                    if(num_8 != 8){
                        let temp = num_8!
                        num_8 = num_8 + num_5 > 8 ? 8 : num_8 + num_5
                        num_5 = num_5 + temp - 8 > 0 ? num_5 - temp > 0 ? num_5 - 8 : 0 : 0
                    }
                }
            }

            checkEmpty()
            vol_12.text = String(num_12)
            vol_8.text = String(num_8)
            vol_5.text = String(num_5)
            dragGR.view!.center = initial_center
            checkFinish()
        }
    }
    
    func checkEmpty(){
        if (num_12 == 0){
            cup_12.image = #imageLiteral(resourceName: "cup")
        }
        else if (num_8 == 0){
            cup_8.image = #imageLiteral(resourceName: "cup")
        }
        else if (num_5 == 0){
            cup_5.image = #imageLiteral(resourceName: "cup")
        }
    }
    @IBAction func reStart(_ sender: Any) {
        restart()
    }
    func restart(){
        num_12 = 12
        num_8 = 0
        num_5 = 0
        cup_12.image = #imageLiteral(resourceName: "cup_filled")
        cup_8.image = #imageLiteral(resourceName: "cup")
        cup_5.image = #imageLiteral(resourceName: "cup")
        vol_12.text = String(num_12)
        vol_8.text = String(num_8)
        vol_5.text = String(num_5)
    }
    
    func checkFinish(){
        if( (vol_5.text == "6" && vol_8.text == "6" ) ||
            (vol_8.text == "6" && vol_12.text == "6") ||
            (vol_5.text == "6" || vol_12.text == "6" ) ){
            let alert = UIAlertController(title: "Success", message: "You solve this puzzle!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in self.restart()}))
            
            self.present(alert, animated: true)
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
