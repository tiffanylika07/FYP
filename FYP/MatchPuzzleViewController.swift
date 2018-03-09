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
    
    @IBOutlet weak var match_1: UIImageView!
    @IBOutlet weak var match_2: UIImageView!
    @IBOutlet weak var match_3: UIImageView!
    @IBOutlet weak var match_4: UIImageView!
    @IBOutlet weak var match_5: UIImageView!
    @IBOutlet weak var match_6: UIImageView!
    @IBOutlet weak var match_7: UIImageView!
    @IBOutlet weak var match_8: UIImageView!
    @IBOutlet weak var match_9: UIImageView!
    @IBOutlet weak var match_10: UIImageView!
    @IBOutlet weak var match_11: UIImageView!
    @IBOutlet weak var match_12: UIImageView!
    @IBOutlet weak var match_13: UIImageView!
    @IBOutlet weak var match_14: UIImageView!
    @IBOutlet weak var match_15: UIImageView!
    @IBOutlet weak var match_16: UIImageView!
    @IBOutlet weak var match_17: UIImageView!
    @IBOutlet weak var match_18: UIImageView!
    @IBOutlet weak var match_19: UIImageView!
    @IBOutlet weak var match_20: UIImageView!
    
    @IBOutlet weak var SubmitButton: UIImageView!
    
    var descriptionBoxBGColor : UIColor?
    var descriptionBGColor : UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        InitializeView()
        
    }
    
    func InitializeView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(sender:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        SubmitButton.addGestureRecognizer(tapGesture)
    
        let panGesture = UIPanGestureRecognizer(target: self, action:  #selector(wasDragged(_:)))
        match_1.isUserInteractionEnabled = true
        match_1.addGestureRecognizer(panGesture)
        
        
        DescriptionBoxView.layer.borderColor = UIColor.black.cgColor
        //DescriptionBoxView.layer.borderWidth = 1
        DescriptionBoxView.layer.cornerRadius = 20
        DescriptionView.layer.cornerRadius = 20
        DescriptionView.isEditable = false
        DescriptionBoxView.backgroundColor = descriptionBoxBGColor
        DescriptionView.backgroundColor = descriptionBGColor

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func wasDragged(_ dragGestureRecognizer: UIPanGestureRecognizer)
    {
       let translate = dragGestureRecognizer.translation(in: self.view)
        let temp = dragGestureRecognizer.view!
        
        temp.center = CGPoint(x: temp.center.x + translate.x, y: temp.center.y+translate.y)
        dragGestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
    }

    @objc func tapAction(sender:UITapGestureRecognizer){
//        match_1.transform = match_1.transform.rotated(by: CGFloat.pi/2)
        print("Submit is Tapped")
        let alertView = UIAlertController(title: "Correct!", message: "Congradualations! You're correct!", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        let next = UIAlertAction(title: "Next", style: .default, handler: goToNextQuestion)
        alertView.addAction(cancel)
        alertView.addAction(next)
        
        present(alertView, animated: true, completion: nil)
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
}
