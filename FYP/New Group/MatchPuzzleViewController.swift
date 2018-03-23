//
//  MatchPuzzleViewController.swift
//  FYP
//
//  Created by Tiffany Li on 31/1/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit

class MatchPuzzleViewController: UIViewController {
    
    @IBOutlet weak var DescriptionBoxView: UIView!
    @IBOutlet weak var PuzzleAreaView: UIView!
    @IBOutlet weak var PuzzleTitle: UILabel!
    
    @IBOutlet weak var DescriptionView: UITextView!
    @IBOutlet weak var SubmitButton: UIImageView!
    
    @IBOutlet weak var MatchAreaView: UIView!
    //Matches
    @IBOutlet weak var match_V_1: UIImageView!
    @IBOutlet weak var match_V_2: UIImageView!
    @IBOutlet weak var match_V_3: UIImageView!
    @IBOutlet weak var match_V_4: UIImageView!
    @IBOutlet weak var match_V_5: UIImageView!
    @IBOutlet weak var match_V_6: UIImageView!
    @IBOutlet weak var match_V_7: UIImageView!
    @IBOutlet weak var match_V_8: UIImageView!
    @IBOutlet weak var match_V_9: UIImageView!
    @IBOutlet weak var match_V_10: UIImageView!
    @IBOutlet weak var match_V_11: UIImageView!
    @IBOutlet weak var match_V_12: UIImageView!
    
    @IBOutlet weak var match_H_1: UIImageView!
    @IBOutlet weak var match_H_2: UIImageView!
    @IBOutlet weak var match_H_3: UIImageView!
    @IBOutlet weak var match_H_4: UIImageView!
    @IBOutlet weak var match_H_5: UIImageView!
    @IBOutlet weak var match_H_6: UIImageView!
    @IBOutlet weak var match_H_7: UIImageView!
    @IBOutlet weak var match_H_8: UIImageView!
    @IBOutlet weak var match_H_9: UIImageView!
    @IBOutlet weak var match_H_10: UIImageView!
    @IBOutlet weak var match_H_11: UIImageView!
    @IBOutlet weak var match_H_12: UIImageView!
    @IBOutlet weak var reStartBtn: UIButton!
     var ori = CGPoint()
    
    var descriptionBoxBGColor : UIColor?
    var descriptionBGColor : UIColor?
 override func viewDidLoad() {
        super.viewDidLoad()
        InitializeView()
        
    }
    var matches_V = [UIImageView](repeating: UIImageView(), count: 64)
    var matches_H = [UIImageView](repeating: UIImageView(), count: 64)
    
    func InitializeView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(sender:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        SubmitButton.addGestureRecognizer(tapGesture)
    
        
        
        DescriptionBoxView.layer.borderColor = UIColor.black.cgColor
        //DescriptionBoxView.layer.borderWidth = 1
        DescriptionBoxView.layer.cornerRadius = 20
        DescriptionView.layer.cornerRadius = 20
        DescriptionView.isEditable = false
 DescriptionBoxView.backgroundColor = descriptionBoxBGColor
        DescriptionView.backgroundColor = descriptionBGColor
        
        for match in MatchAreaView.subviews{
            match.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action:  #selector(wasDragged(_:)))
            match.addGestureRecognizer(panGesture)
        }
        
        initializeData()
        disableNil()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initializeData(){
        matches_V = [match_V_1,match_V_2,match_V_3,match_V_4,
                    match_V_5,match_V_6,match_V_7,match_V_8,
                    match_V_9,match_V_10,match_V_11,match_V_12]
        matches_H = [match_H_1,match_H_2,match_H_3,match_H_4,
        match_H_5,match_H_6,match_H_7,match_H_8,
        match_H_9,match_H_10,match_H_11,match_H_12]
        
        
    }
    
    var verticalArr = [ 2 ,3, 6, 7, 10, 11]
    var horArr = [ 4,5,6,7,8,9]
    

    @IBAction func ReStart(_ sender: Any) {
        for (i,match) in matches_V.enumerated(){
            if (verticalArr.contains(i+1)){
                match.image = #imageLiteral(resourceName: "match_V")
            }
            else{
                match.image = nil
            }
        }
        for (i,match) in matches_H.enumerated(){
            if (horArr.contains(i+1)){
                match.image = #imageLiteral(resourceName: "match_H")
            }
            else{
                match.image = nil
            }
        }
        disableNil()
    }
    @objc func wasDragged(_ dragGR: UIPanGestureRecognizer)
    {
       let translate = dragGR.translation(in: self.view)
        let temp = dragGR.view!
       
        if(dragGR.state == .began){
           print("ori", dragGR.view!.center)
            ori = dragGR.view!.center
        }
        if(dragGR.state == .changed){
            temp.center = CGPoint(x: temp.center.x + translate.x, y: temp.center.y+translate.y)
            dragGR.setTranslation(CGPoint.zero, in: self.view)
        }
        if(dragGR.state == .ended){
            if(matches_V.contains(dragGR.view! as! UIImageView)){
                for (i, match) in matches_V.enumerated(){
                    if match.frame.contains(dragGR.view!.center) {
                        print("match v ", i+1)
                        if(match.image == nil){
                            match.image = #imageLiteral(resourceName: "match_V")
                            (dragGR.view! as! UIImageView).image = nil
                        }
                    }
                }
            
            }
            else if (matches_H.contains(dragGR.view as! UIImageView)){
                for (i, match) in matches_H.enumerated(){
                    if match.frame.contains(dragGR.view!.center){
                        print("match H ", i+1)
                        if(match.image == nil){
                            match.image = #imageLiteral(resourceName: "match_H")
                            (dragGR.view! as! UIImageView).image = nil
                        }
                    }
                }
            }
            dragGR.view!.center = ori
            disableNil()
        }
    }
    
    func disableNil(){
        for match in MatchAreaView.subviews{
            if((match as! UIImageView).image == nil){
                match.isUserInteractionEnabled = false
            }
            else {
                match.isUserInteractionEnabled = true
            }
        }
    }

    @objc func tapAction(sender:UITapGestureRecognizer){
        if(match_H_2.image != nil && match_H_4.image != nil && match_H_5.image != nil &&
            match_H_7.image != nil && match_H_8.image != nil && match_H_11.image != nil &&
            match_V_2.image != nil && match_V_3.image != nil && match_V_5.image != nil &&
            match_V_6.image != nil && match_V_10.image != nil && match_V_11.image != nil){
            let alertView = UIAlertController(title: "Correct!", message: "Congradualations! You're correct!", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancel = UIAlertAction(title: "Cancel", style: .destructive)
            let next = UIAlertAction(title: "Next", style: .default, handler: goToNextQuestion)
            alertView.addAction(cancel)
            alertView.addAction(next)
            present(alertView, animated: true, completion: nil)
        }
        else{
            let alertView = UIAlertController(title: "Wrong!", message: "Sorry, you're wrong. Please try again. You can only move three matches.", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancel = UIAlertAction(title: "Try again", style: .default)
            alertView.addAction(cancel)
            present(alertView, animated: true, completion: nil)
        }
    }
    func goToNextQuestion(alert: UIAlertAction!) {
       // performSegue(withIdentifier: "nextQuestion", sender: self)
        print("Pressed Next")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Puzzle List"
        navigationItem.backBarButtonItem = backItem
        
        
    }
    
    func checkFinish(){
        if(match_H_2.image != nil && match_H_4.image != nil && match_H_5.image != nil &&
            match_H_7.image != nil && match_H_8.image != nil && match_H_11.image != nil &&
        match_V_2.image != nil && match_V_3.image != nil && match_V_5.image != nil &&
            match_V_6.image != nil && match_V_10.image != nil && match_V_11.image != nil){
            
        }
        
    }
}
