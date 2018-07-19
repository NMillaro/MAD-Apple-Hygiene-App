//
//  SearchViewController.swift
//  MAD App
//
//  Created by Nicholas Millard on 20/04/2018.
//  Copyright © 2018 Nicholas Millard. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchPopup: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchPopup.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeSearch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
 

}
