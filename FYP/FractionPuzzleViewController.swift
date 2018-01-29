//
//  FractionPuzzleViewController.swift
//  FYP
//
//  Created by Tiffany Li on 30/1/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit

class FractionPuzzleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateQuestion()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    struct question : Decodable{
        var distance: String
        var answer: [String]
        var others: [String]
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
                    print(String(i)+": ")
                    print(StringToFloat(aString: ans))
                    print(",")
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
