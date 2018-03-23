//
//  LevelPopUpViewController.swift
//  FYP
//
//  Created by Tiffany Li on 17/3/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit
class LevelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var levelLbl: UILabel!
    @IBOutlet weak var lblBkground: UIView!
    var number_ID : Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

struct ques : Decodable{
    var initial: [String]
    var nextNum: [Int]
    var hint: String
    var id: Int
}

class LevelPopUpViewController: UITableViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet var levelView: UITableView!
    var descriptionBoxBGColor : UIColor!
    var descriptionBGColor : UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.levelView.delegate = self
        self.levelView.dataSource = self
        levelView.tableFooterView = UIView()
        levelView.separatorStyle = .none
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.levelView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.navigationItem.title = "Select Level"

    }
    @IBAction func CloseButtonTapped(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 1
        let path = Bundle.main.path(forResource: "MakeItZeroJSON", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf:url)
            let questionList = try JSONDecoder().decode([ques].self, from: data)
            num = questionList.count
        }
        catch{
            print("Failed to load Question List - Make It Zero")
        }
        
        return num
    }
    // configre row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = levelView.dequeueReusableCell(withIdentifier: "levelCell") as! LevelTableViewCell
        cell.levelLbl.text = "Level " + String(indexPath.row + 1)
        cell.number_ID = indexPath.row
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showPuzzleByLevel"){
            
            let seletedCell = sender as! LevelTableViewCell
            if let makeItZeroController = segue.destination as? MakeItZeroViewController{
               makeItZeroController.question_ID = seletedCell.number_ID
                makeItZeroController.descriptionBGColor = descriptionBGColor
                makeItZeroController.descriptionBoxBGColor = descriptionBoxBGColor
            }
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                    performSegue(withIdentifier: "showPuzzleByLevel", sender: tableView.cellForRow(at: indexPath)  )
        
        
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.view.removeFromSuperview()
        
    }
    
}

