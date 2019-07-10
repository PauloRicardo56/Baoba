//
//  FirstViewController.swift
//  Baoba
//
//  Created by Fábio França on 09/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var newUsrData: FirstFormController!
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.arredondaButton()
    }
    
    
//    func arredondaButton() {
//        self.addBtn.layer.cornerRadius = self.addBtn.frame.width * 0.5
//        self.addBtn.layer.borderWidth = 1
//        self.addBtn.layer.borderColor = UIColor.lightGray.cgColor
//    }
    @IBAction func addPerson(_ sender: Any) {
        
        newUsrData.isHidden = false
        newUsrData.viewDidLoad()
        
    }
    
}
