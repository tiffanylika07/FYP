//
//  JSONParseTest.swift
//  FYPTests
//
//  Created by Tiffany Li on 3/2/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import XCTest
@testable import FYP


class JSONParseTest: XCTestCase {
    
    var menuTableVC : MenuTableViewController!
    
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name:"Main",bundle : nil)
        
         menuTableVC = storyBoard.instantiateViewController(withIdentifier: "MenuTableViewController") as! MenuTableViewController
        _ = menuTableVC.view
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    //Test for existence of Category table view
    func testTableViewExistence(){
        XCTAssertNotNil(menuTableVC.menuView)
    }

    //Test for the dataSource of Category table View
    struct Cell : Decodable{
        var id: String
        var name: String
        var image: String
        var color: [CGFloat]
    }
    func testJSONMapping() throws {

        let path = Bundle.main.path(forResource: "MenuCellJSON", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try Data(contentsOf: url)
        let cell: [Cell] = try JSONDecoder().decode([Cell].self, from: data)
        XCTAssertEqual(cell[0].name, "Area")
        XCTAssertEqual(cell[0].id, "1")
        XCTAssertEqual(cell[0].color, [77,148,255,1])
        XCTAssertEqual(cell[0].image, "icon_shape")
    }
}
