//
//  MenuTableViewController.swift
//  FYP
//
//  Created by Tiffany Li on 6/1/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit
class MenuCell {
    var name: String
    var photo: UIImage?
    
    init (name: String, photo: UIImage?) {
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        
    }
}
class MenuTableViewController: UITableViewController {
    @IBOutlet weak var menuView: UITableView!

    var elements = [MenuCell]()
    
    private func lodadTableData(){
        //table icon list
        let icon1 = UIImage(named: "icon_1")
        let icon2 = UIImage(named: "icon_2")
        
        //cell list
        let cell1 = MenuCell(name: "Cell 1", photo: icon1)
        let cell2 = MenuCell(name: "Cell 2", photo: icon2)
        elements += [cell1,cell2]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lodadTableData()
        tableView.tableFooterView = UIView()
        
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
        // #warning Incomplete implementation, return the number of rows
        return elements.count
    }
    // configre row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = menuView.dequeueReusableCell(withIdentifier: "tableCell") as! MenuTableViewCell
        
        let element = elements[indexPath.row]
        
        cell.menuIcon.image = element.photo
        cell.menuLbl.text = element.name
        
        return cell
    }


}
