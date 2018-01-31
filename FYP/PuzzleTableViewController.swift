//
//  MenuTableViewController.swift
//  FYP
//
//  Created by Tiffany Li on 6/1/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit
class PuzzleCell {
    var id: String
    var name: String
    var photo: UIImage?
    var bgColor: UIColor?
    
    init (id:String,name: String, photo: UIImage?, color: UIColor?) {
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.bgColor = color
        self.id = id
        
    }
}

struct puzzle : Decodable{
    var id: String
    var name: String
    var image: String
    var color: [CGFloat]
    
}

class PuzzleTableViewController: UITableViewController {
    @IBOutlet weak var menuView: UITableView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var elements = [PuzzleCell]()
    
    private func lodadTableData(){
        
        let path = Bundle.main.path(forResource: "PuzzleMenuJSON", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf:url)
            let menuCellList = try JSONDecoder().decode([puzzle].self, from: data)
            
            for aCell in menuCellList{
                //let icon = UIImage(named: aCell.image )
                let aColor =  UIColor(red: aCell.color[0]/255 , green: aCell.color[1]/255 , blue: aCell.color[2]/255 , alpha: aCell.color[3])
                let cell = PuzzleCell(id: aCell.id,name:  aCell.name, photo: UIImage(named: aCell.image), color: aColor)
                elements.append(cell)
            }
        }
        catch{
            print("Failed to load Menu List")
        }
        
        elements.sort { (first, second) -> Bool in
            if(first.name < second.name){
                return true
            }
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuView.delegate = self
        self.menuView.dataSource = self
        lodadTableData()
        //        navigationItem.rightBarButtonItem = nil
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(BackButtonTapped))
        backButton.target = self
        backButton.action = #selector(BackButtonTapped)
        tableView.tableFooterView = UIView()
    }
    @objc func BackButtonTapped() {
        print("TAPPED")
        self.dismiss(animated: true, completion: {});
        self.navigationController?.popViewController(animated: false);
    }
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(true)
    //        // Hide the Navigation Bar
    //        self.navigationController?.setNavigationBarHidden(false, animated: false)
    //    }
    
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
        // #warning Incomplete implementation, return the number of rows
        return elements.count
    }
    // configre row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = menuView.dequeueReusableCell(withIdentifier: "tableCell") as! PuzzleTableViewCell
        let element = elements[indexPath.row]
        cell.menuIcon.image = element.photo
        cell.menuLbl.text = element.name
        cell.menuLbl.font = UIFont(name: "Neucha", size: 36)
        cell.menuLbl.adjustsFontSizeToFitWidth = true
        cell.tableView.backgroundColor = element.bgColor
        cell.layer.cornerRadius = 30
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Puzzle List"
        navigationItem.backBarButtonItem = backItem
        let sender = sender as! PuzzleCell
        if(segue.identifier == "showFractionPuzzle"){
            if let fractionPuzzleViewController = segue.destination as? FractionPuzzleViewController{
                fractionPuzzleViewController.descriptionBoxBGColor = adjustColor(aColor: sender.bgColor!,by: 10.0)
                fractionPuzzleViewController.descriptionBGColor = adjustColor(aColor: sender.bgColor!,by: 20.0)
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Show Detail concept with different segue
        print(elements[indexPath.row].id)
        switch(elements[indexPath.row].id){
        case "1":
            performSegue(withIdentifier: "showFractionPuzzle", sender: elements[indexPath.row])
        case "2":
            performSegue(withIdentifier: "showMatchPuzzle", sender: elements[indexPath.row])
        case "3":
            performSegue(withIdentifier: "showFractionPuzzle", sender: elements[indexPath.row])
        case "4":
            performSegue(withIdentifier: "showFractionPuzzle", sender: elements[indexPath.row])
        case "5":
            performSegue(withIdentifier: "showFractionPuzzle", sender: elements[indexPath.row])
        case "6":
            performSegue(withIdentifier: "showFractionPuzzle", sender: elements[indexPath.row])
        default:
            print("Error")
        }
        
    }
    
    func adjustColor(aColor: UIColor,by percentage: CGFloat = 30.0 ) -> UIColor? {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
        if(aColor.getRed(&r, green: &g, blue: &b, alpha: &a)){
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        }else{
            return nil
        }
    }
    
}

