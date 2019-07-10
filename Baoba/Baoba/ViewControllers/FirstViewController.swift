//
//  FirstViewController.swift
//  Baoba
//
//  Created by Fábio França on 09/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.arredondaButton()
    }
    
    @IBAction func addPerson(_ sender: Any) {
    }
    
    func arredondaButton() {
        self.addBtn.layer.cornerRadius = self.addBtn.frame.width / 4
        self.addBtn.layer.borderWidth = 1
        self.addBtn.layer.borderColor = UIColor.lightGray.cgColor
    }

}
