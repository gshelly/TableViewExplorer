//
//  DetailsViewController.swift
//  NameList
//
//  Created by shelly.gupta on 5/23/18.
//  Copyright © 2018 shelly.gupta. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    var passedName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = passedName
    }
    

    @IBAction func CloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
