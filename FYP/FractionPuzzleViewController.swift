//
//  FractionPuzzleViewController.swift
//  FYP
//
//  Created by Tiffany Li on 30/1/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit

struct question : Decodable{
    var distance: String
    var answer: [String]
    var others: [String]
}

class questionCell {
    var image : UIImage?
    var value : Double = 0.0
}
class FractionPuzzleViewController: UIViewController {

    @IBOutlet weak var DescriptionBoxView: UIView!
    @IBOutlet weak var PuzzleAreaView: UIView!
    @IBOutlet weak var PuzzleTitle: UILabel!
    
    @IBOutlet weak var DescriptionView: UITextView!
    
    var descriptionBoxBGColor: UIColor?
    var descriptionBGColor: UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        generateQuestion()
        InitializeView()
    }
    
    func InitializeView(){
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

    
    func generateQuestion(){
        let path = Bundle.main.path(forResource: "FractionPuzzleQuestion", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf:url)
            print(data)
            let menuCellList = try JSONDecoder().decode([question].self, from: data)
            print(menuCellList)
            for question in menuCellList{
                print("Distance")
                print(StringToFloat(aString: question.distance))
                for (i, ans) in question.answer.enumerated(){
                    print(String(i+1)+": ",StringToFloat(aString: ans))
                }
            }
        }
        catch{
            print("Failed to load Menu List")
        }
        
    }
    typealias Rational = (num : Int, den : Int)
    
    func rationalApproximation(of x0 : Double, withPrecision eps : Double = 1.0E-6) -> Rational {
        var x = x0
        var a = x.rounded(.down)
        var (h1, k1, h, k) = (1, 0, Int(a), 1)
        
        while x - a > eps * Double(k) * Double(k) {
            x = 1.0/(x - a)
            a = x.rounded(.down)
            (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
        }
        return (h, k)
    }
    
    func StringToFloat(aString : String) -> Float{
        
        var comps = aString.components(separatedBy: "/")
        var op1 = NSString(string: comps[0]).floatValue
        var op2 = NSString(string: comps[1]).floatValue
        
        return op1/op2
    }
   
    

}
