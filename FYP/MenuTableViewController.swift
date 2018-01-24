//
//  MenuTableViewController.swift
//  FYP
//
//  Created by Tiffany Li on 6/1/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit
class MenuCell {
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
class MenuTableViewController: UITableViewController {
    @IBOutlet weak var menuView: UITableView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    var elements = [MenuCell]()
    
    private func lodadTableData(){
        //table icon list
        let icon1 = UIImage(named: "icon_1")
        let icon2 = #imageLiteral(resourceName: "icon_direction")
        let icon3 = #imageLiteral(resourceName: "icon_algebra")
        let icon4 = #imageLiteral(resourceName: "icon_shape")
        let icon5 = #imageLiteral(resourceName: "icon_time")
        let icon6 = #imageLiteral(resourceName: "icon_fraction")
        
        //cell list
        let cell1 = MenuCell(id:"1",name: "Area and Volume", photo: icon1, color: UIColor(red: 77/255, green: 148/255, blue: 255/255, alpha: 1))
        let cell2 = MenuCell(id:"2",name: "Direction and Scale Drawing", photo: icon2, color: UIColor(red: 255/255, green: 77/255, blue: 136/255, alpha: 1))
        let cell3 = MenuCell(id:"3",name: "Basic Algebra", photo: icon3, color: UIColor(red: 255/255, green: 140/255, blue: 26/255, alpha: 1))
        let cell4 = MenuCell(id:"4",name: "Shape and Symmetry", photo: icon4, color: UIColor(red: 92/255, green: 214/255, blue: 92/255, alpha: 1))
        let cell5 = MenuCell(id:"5",name: "Time", photo: icon5, color: UIColor(red: 255/255, green: 255/255, blue: 51/255, alpha: 1))
        let cell6 = MenuCell(id:"6",name: "Fraction", photo: icon6, color: UIColor(red: 194/255, green: 102/255, blue: 255/255, alpha: 1))
        
        
        elements += [cell1,cell2,cell3,cell4,cell5,cell6]
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
    func BackButtonTapped() {
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
        
        let cell = menuView.dequeueReusableCell(withIdentifier: "tableCell") as! MenuTableViewCell
        
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
        backItem.title = "Category"
        navigationItem.backBarButtonItem = backItem
        let seletedCell = sender as! MenuCell
        if let detailViewController = segue.destination as? DetailConceptViewController{
            detailViewController.selectedCellName = seletedCell.name
            detailViewController.bgColor = seletedCell.bgColor
            if(segue.identifier == "showConcept1"){
                
                detailViewController.selectedCellID = 1
            }
            else if(segue.identifier == "showConcept2"){
                detailViewController.selectedCellID = 2
            }
            else if(segue.identifier == "showConcept3"){
                detailViewController.selectedCellID = 3
            }
            else if(segue.identifier == "showConcept4"){
                detailViewController.selectedCellID = 4
            }
            else if(segue.identifier == "showConcept5"){
                detailViewController.selectedCellID = 5
            }
            else if(segue.identifier == "showConcept6"){
                detailViewController.selectedCellID = 6
            }
        }
        

        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Show Detail concept with different segue
        let identifier = "showConcept" + String(indexPath.row + 1)
        print(identifier)
            //performSegue(withIdentifier: identifier, sender: elements[indexPath.row])
            performSegue(withIdentifier: "showConcept1", sender: elements[indexPath.row])
    }


}
