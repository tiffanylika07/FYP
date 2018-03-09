//
//  ContentViewController.swift
//  FYP
//
//  Created by Tiffany Li on 27/1/2018.
//  Copyright © 2018 Tiffany Li. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var mainView: UIView!
    var bgColor : UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.backgroundColor = bgColor
        mainView.backgroundColor = bgColor
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 780)
        let tapGesture_P = UITapGestureRecognizer(target: self, action: #selector(tapAction(sender:)))
        tapGesture_P.numberOfTapsRequired = 1
        tapGesture_P.numberOfTouchesRequired = 1
        self.view.addSubview(scrollView)
//        playPuzzleBtn.isUserInteractionEnabled = true
//        playPuzzleBtn.addGestureRecognizer(tapGesture_P)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func tapAction(sender:UITapGestureRecognizer){
        //        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PuzzleTableViewID") as! PuzzleTableViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
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
