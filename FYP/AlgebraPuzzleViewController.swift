//
//  AlgebraPuzzleViewController.swift
//  FYP
//
//  Created by Tiffany Li on 6/4/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit

class AlgebraPuzzleViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var DescriptionBoxView: UIView!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var DescriptionView: UITextView!
    
    @IBOutlet weak var PuzzleTitle: UILabel!
    @IBOutlet weak var PuzzleAreaView: UIView!
    @IBOutlet weak var SubmitButton: UIButton!
    

    var descriptionBoxBGColor : UIColor!
    var descriptionBGColor : UIColor!
    
    @IBOutlet weak var questionPic: UIImageView!
    @IBOutlet weak var ansField: UITextField!
    
    var quesAns : String!
    var quesID : Int! = 1
    var listCount : Int!
    struct question_A : Decodable{
        var q_id : Int!
        var ans : Int!
        var pic : String!
    }
    
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
        
        ansField.delegate = self as! UITextFieldDelegate
        ansField.keyboardType = .numberPad
        
        self.hideKeyboardWhenTappedAround()
        
        LoadQuestionData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
        
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
        
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextFieldUp(textField: ansField, moveDistance: -200, up: true)
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        moveTextFieldUp(textField: ansField, moveDistance: -200, up: false)
        return true
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        ansField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    func moveTextFieldUp(textField: UITextField, moveDistance: Int,up: Bool){
        let moveDuration = 0.3
        let movement : CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0,dy: movement)
        UIView.commitAnimations()
        
    }
    
    func LoadQuestionData(){
        let path = Bundle.main.path(forResource: "AlgebraQuestionList", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf:url)
            let questionList = try JSONDecoder().decode([question_A].self, from: data)
            listCount = questionList.count
            var filter = questionList.filter { $0.q_id == quesID }
            if(filter != nil){
                let data = filter.first!
                quesAns = String(data.ans!)
                self.questionPic.image = UIImage(named: (filter.first?.pic)!)
            }
        }
        catch{
            
        }
    }
    
    @IBAction func SubmitButtonTApped(_ sender: Any) {
        print(ansField.text!)
        print(quesAns)
        if(ansField.text! == quesAns!){
            let alert = UIAlertController(title: "Correct!", message: "You solved this puzzle!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in self.nextQuestion()}))
            
            self.present(alert, animated: true)
        }
        else{
            let alert = UIAlertController(title: "Wrong", message: "Opps! Please try again.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Return", style: .default))
            
            self.present(alert, animated: true)
        }
    }
    
    func nextQuestion(){
        ansField.endEditing(true)
        if(listCount >= quesID + 1){
            quesID = quesID + 1
            LoadQuestionData()
            ansField.text = ""
        }
    }
    

    @IBAction func BackTapped(_ sender: Any) {
        ansField.endEditing(true)
        if(quesID - 1 >= 1){
            quesID = quesID - 1
            LoadQuestionData()
        }
    }
    
    @IBAction func NextTapped(_ sender: Any) {
        nextQuestion()
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
