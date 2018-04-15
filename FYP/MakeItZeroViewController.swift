//
//  MakeItZeroViewController.swift
//  FYP
//
//  Created by Tiffany Li on 3/2/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit

extension UIView{
    var globalPoint :CGPoint! {
        return self.superview?.convert(self.frame.origin, to: nil)
    }
    
    var globalFrame :CGRect! {
        return self.superview?.convert(self.frame, to: nil)
    }
}

class MakeItZeroViewController: UIViewController{
    
    var question_ID = 0

    //Description Box
    @IBOutlet weak var DescriptionBoxView: UIView!
    @IBOutlet weak var DescriptionView: UITextView!
    var descriptionBoxBGColor: UIColor?
    var descriptionBGColor: UIColor?

    //Puzzle Area
    @IBOutlet weak var PuzzleAreaView: UIView!
    @IBOutlet weak var demoBtn: UIButton!
    @IBOutlet weak var hintBtn: UIButton!
    
    //Board
    @IBOutlet weak var number_I: UILabel!
    @IBOutlet weak var number_II: UILabel!
    @IBOutlet weak var number_III: UILabel!
    
    @IBOutlet weak var boardView: UIView!
    //Frame
    @IBOutlet weak var frame_A: UIView!
    @IBOutlet weak var frame_B: UIView!
    @IBOutlet weak var frame_C: UIView!
    @IBOutlet weak var frame_D: UIView!
    @IBOutlet weak var label_A: UILabel!
    @IBOutlet weak var label_B: UILabel!
    @IBOutlet weak var label_C: UILabel!
    @IBOutlet weak var label_D: UILabel!
    
    var location_A : CGPoint!
    var location_B : CGPoint!
    var location_C : CGPoint!
    var location_D : CGPoint!
    var location_Next : CGPoint!
    var ori_location_A: CGPoint!
    var ori_location_B: CGPoint!
    var ori_location_C: CGPoint!
    var length_H: CGFloat!
    var length_V: CGFloat!
    
    var num_A : Int!
    var num_B : Int!
    var num_C : Int!
    var num_D : Int!
    
    var ques : question!
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadQuestionData()
        InitializeView()
        InitLongPressGesture()
        InitDragGesture()
        InitLocationData()
    }
    
    func InitializeView(){
        DescriptionBoxView.layer.borderColor = UIColor.black.cgColor
        //DescriptionBoxView.layer.borderWidth = 1
        DescriptionBoxView.layer.cornerRadius = 20
        DescriptionView.layer.cornerRadius = 20
        DescriptionView.isEditable = false
        DescriptionBoxView.backgroundColor = descriptionBoxBGColor
        DescriptionView.backgroundColor = descriptionBGColor
        //PuzzleAreaView.backgroundColor = descriptionBGColor?.withAlphaComponent(0.8)
        
        //Puzzle
        PuzzleAreaView.bringSubview(toFront: number_I)
         PuzzleAreaView.bringSubview(toFront: number_II)
         PuzzleAreaView.bringSubview(toFront: number_III)
        PuzzleAreaView.sendSubview(toBack: boardView)
        
        
        //Navigation
        
        //Back buttion
        self.navigationItem.title = "Level " + String(question_ID + 1)
        let barButton = UIBarButtonItem(title: "< Puzzle List", style: .plain, target: self, action: #selector(back(sender:)))
        self.navigationItem.leftBarButtonItem = barButton
        
        for frameView in boardView.subviews{
            frameView.layer.borderWidth = 2
            frameView.layer.cornerRadius = 10
            frameView.backgroundColor = UIColor.white
        }
        
        num_A = Int(label_A.text!)!
        num_B = Int(label_B.text!)!
        num_C = Int(label_C.text!)!
        num_D = Int(label_D.text!)!
    
        
    }
    @objc func back(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "backToPuzzleList", sender: self)
    }
    
    
    @IBAction func demoBtnTapped(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "demoPopUp") as! ZeroDemoPopUpViewController
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    @IBAction func levelBtnTApped(_ sender: UIButton) {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "levelPopUp") as! LevelPopUpViewController
        popUpVC.descriptionBoxBGColor = descriptionBoxBGColor
        popUpVC.descriptionBGColor = descriptionBGColor
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)

    }
    
    func InitLocationData(){
        location_A =  frame_A.frame.origin
        location_B =  frame_B.frame.origin
        location_C =  frame_C.frame.origin
        location_D =  frame_D.frame.origin
        location_Next = number_I.center
        ori_location_A = number_I.center
        ori_location_B = number_II.center
        ori_location_C = number_III.center
        length_H = boardView.frame.size.width
        length_V = boardView.frame.size.height
    }
    
    struct question : Decodable{
        var initial: [String]
        var nextNum: [Int]
        var hint: String
        var id: Int
    }
    
    func LoadQuestionData(){
       
        let path = Bundle.main.path(forResource: "MakeItZeroJSON", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf:url)
            let questionList = try JSONDecoder().decode([question].self, from: data)
            print("GET")
            print("QuesID",question_ID)
            ques = questionList[question_ID]
            if(ques != nil){
                for point in ques.initial{
                    var temp =  point.components(separatedBy: "/")
                    switch temp[1]{
                        case "A":
                            label_A.text = temp.isEmpty ? "0" : temp[0]
                        case "B":
                            label_B.text = temp.isEmpty ? "0" : temp[0]
                        case "C":
                            label_C.text = temp.isEmpty ? "0" : temp[0]
                         case "D":
                            label_D.text = temp.isEmpty ? "0" : temp[0]
                        default:
                            return
                    }
                    
                }
                clearFrame()
                number_I.text = String(ques.nextNum[0])
                number_II.text = String(ques.nextNum[1])
                number_III.text = String(ques.nextNum[2])
            }
        }
        catch{
            print("Failed to load Question List - Make It Zero")
        }
    }
    

    func InitLongPressGesture(){
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        hintBtn.addGestureRecognizer(longPressGR)
    }
    
    func InitDragGesture(){
        let dragGR =     UIPanGestureRecognizer(target: self, action:  #selector(handleDrag(_:)))
        number_I.isUserInteractionEnabled = true
        number_I.addGestureRecognizer(dragGR)
        let dragGR_B =     UIPanGestureRecognizer(target: self, action:  #selector(handleDrag(_:)))
        number_II.isUserInteractionEnabled = true
        number_II.addGestureRecognizer(dragGR_B)
        let dragGR_C =     UIPanGestureRecognizer(target: self, action:  #selector(handleDrag(_:)))
        number_III.isUserInteractionEnabled = true
        number_III.addGestureRecognizer(dragGR_C)
    }
    
    func checkFinish(){
        var count = 0
        var full = 0
        for view in boardView.subviews {
            for label in view.subviews{
                
                if let number = label as? UILabel {
                    if number.text == "0" || number.text == nil{
                        count = count+1
                    }
                    else if number.text != "0"{
                        full = full + 1
                    }
                }
            }
        }
        if(count >= 4){
            let alert = UIAlertController(title: "Success", message: "You solve this puzzle!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Next Level", style: .default, handler: {action in self.LoadNextLevel()}))
            
            self.present(alert, animated: true)
        }
        else if (full >= 4){
            let alert = UIAlertController(title: "Full", message: "The board is full, you lose!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: {action in self.reloadPage()}))
            
            self.present(alert, animated: true)
        }
    }
    
    func reloadPage(){
        label_A.text = "0"
        label_B.text = "0"
        label_C.text = "0"
        label_D.text = "0"
        LoadQuestionData()
        number_I.isHidden = false
        number_II.isHidden = false
        number_III.isHidden = false
        
        num_A = Int(label_A.text!)!
        num_B = Int(label_B.text!)!
        num_C = Int(label_C.text!)!
        num_D = Int(label_D.text!)!
    }
    
    func LoadNextLevel(){
        question_ID = question_ID + 1
        self.navigationItem.title = "Level " + String(question_ID + 1)
        LoadQuestionData()
        number_I.isHidden = false
        number_II.isHidden = false
        number_III.isHidden = false
        
        num_A = Int(label_A.text!)!
        num_B = Int(label_B.text!)!
        num_C = Int(label_C.text!)!
        num_D = Int(label_D.text!)!
        print(num_A, num_B, num_C,num_D)
    }
    
    func clearBoard(){
        for frame in boardView.subviews{
            for label in frame.subviews{
                let boardNum = label as! UILabel
                    boardNum.text = "0"
                    boardNum.isHidden = true
                
            }
        }
        
    }
    
    func clearFrame(){
        for frame in boardView.subviews{
            for label in frame.subviews{
                let boardNum = label as! UILabel
                if(boardNum.text == "0"){
                    boardNum.isHidden = true
                }
                else{
                    boardNum.isHidden = false
                }
            }
        }
    }
    
    
    func checkIfZero(num: Int,frame:String){
        print("num",num)
        switch frame {
        case "A":
            let ans = (num - (num_B!+num_C!+num_D!)) % 10
            if( ans == 0){
                clearBoard()
            }
            else{
                label_A.text = String(num)
                num_A = num
                label_A.isHidden = false
            }
        case "B":
            let ans = num - (num_A!+num_C!+num_D!) % 10
            if( ans == 0){
                print("Success")
                clearBoard()
                
            }
            else{
                print("ans ", ans)
                label_B.text = String(num)
                num_B = num
                label_B.isHidden = false
            }
        case "C":
            let ans = num - (num_B!+num_A!+num_D!) % 10
            if( ans == 0){
                print("Success")
                clearBoard()
            }
            else{
                print("ans ", ans)
                label_C.text = String(num)
                num_C = num
                label_C.isHidden = false
            }
        case "D":
            let ans = num - (num_B!+num_C!+num_A!) % 10
            if( ans == 0){
                print("Success")
                clearBoard()
            }
            else{
                print("ans ", ans)
                label_D.text = String(num)
                num_D = num
                label_D.isHidden = false
            }
        default:
            return
        }
    }
    @objc func handleDrag(_ dragGR: UIPanGestureRecognizer)
    {
        let translate = dragGR.translation(in: self.view)
        let temp = dragGR.view!
        let selectedLbl = temp as! UILabel
        let selectedNum = Int(selectedLbl.text!)!

        //Record Original Location
        if(dragGR.state == UIGestureRecognizerState.began){
//            if(dragGR.view! == number_I){
//                location_Next = ori_location_A
//            }
//            else if(dragGR.view! == number_II){
//                location_Next = ori_location_B
//            }
//            else if(dragGR.view! == number_III){
//                location_Next = ori_location_C
//            }
            
            location_Next = dragGR.view!.center
        }
        //Overlay effect
        if (dragGR.state == UIGestureRecognizerState.changed){
            temp.center = CGPoint(x: temp.center.x + translate.x, y: temp.center.y+translate.y)
            dragGR.setTranslation(CGPoint.zero, in: self.view)
            
            let location_GR = dragGR.location(in: boardView)
            if(!(location_GR.x < 0 || location_GR.y < 0)){
                for view in boardView.subviews{
                    view.backgroundColor = UIColor.gray
                }
            }
            else{
                for view in boardView.subviews{
                    view.backgroundColor = UIColor.white
                }
            }
            
        }
        if dragGR.state == UIGestureRecognizerState.ended {
            let location_GR = dragGR.location(in: boardView)
            //In A
            if(location_GR.x > location_A.x && location_GR.x < location_B.x &&
                location_GR.y > location_A.y && location_GR.y < location_C.y && label_A.text! == "0"){
                checkIfZero(num:selectedNum,frame:"A")
                temp.isHidden = true
            }
            //In B
            else if(location_GR.x > location_B.x && location_GR.x < location_B.x + length_H/2 &&
                location_GR.y > location_B.y && location_GR.y < location_C.y &&
            label_B.text! == "0"){
                
                print("IN B")
                checkIfZero(num:selectedNum,frame:"B")
                temp.isHidden = true
            }
            //In C
            else if(location_GR.x > location_C.x && location_GR.x < location_D.x &&
                location_GR.y > location_C.y && location_GR.y < location_C.y + length_V/2 && label_C.text! == "0"){
                
                print("IN C")
                checkIfZero(num:selectedNum,frame:"C")
                temp.isHidden = true
            }
            //In D
            else if(location_GR.x > location_D.x && location_GR.x < location_D.x + length_H/2 &&
                location_GR.y > location_C.y && location_GR.y < location_D.y + length_V/2 && label_D.text! == "0"){
                
                print("IN D")
                checkIfZero(num:selectedNum,frame:"D")
                temp.isHidden = true
            }
            else{
                dragGR.view!.center = CGPoint(x: location_Next.x, y:location_Next.y)


            }
            for view in boardView.subviews{
                view.backgroundColor = UIColor.white
                checkFinish()
            }
            
           
        }
    }

    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if(gesture.state == .began){
            print("Start")
        }
        else if (gesture.state == .ended){
            print("Preszs ended")
        }
    }
    
    struct Item_4{
        var id: Int
        var initial: Board4?
        var nextNum: [Int]
        var hint: String
        var type: Int
        
        init (id:Int,ini:Board4,next:[Int],hint:String,type: Int) {
            self.id = id
            self.initial = ini
            self.nextNum = next
            self.hint = hint
            self.type = type
        }
        
    }
    struct Board4{
        var locationA:Int
        var locationB:Int
        var locationC:Int
        var locationD:Int
        
        init(location_a:Int,location_b:Int,location_c:Int,location_d:Int){
            self.locationA = location_a
            self.locationB = location_b
            self.locationC = location_c
            self.locationD = location_d
        }
    }



}

