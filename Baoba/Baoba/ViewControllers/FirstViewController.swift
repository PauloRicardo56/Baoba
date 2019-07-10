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

        self.arredondaButton()
    }
    
    
    func arredondaButton() {
        self.addBtn.layer.cornerRadius = self.addBtn.frame.width * 0.5
        self.addBtn.layer.borderWidth = 1
        self.addBtn.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func addPerson(_ sender: Any) {
        
//        newUsrData.isHidden = false
        newUsrData.viewDidLoad()
        newUsrData.isHidden = false
        usrViewBounds()
        
        newUsrData.transform = CGAffineTransform(scaleX: 0.3, y: 2)
//        newUsrData.transform = CGAffineTransform(rotationAngle: 0.5)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
            self.newUsrData.transform = .identity
        }) { (_) in
            print("oi")
        }
        
    }
    
    func usrViewBounds(){
        self.newUsrData.layer.cornerRadius = self.newUsrData.frame.width * 0.05
        self.newUsrData.layer.borderWidth = 1
    }
    
    
    @IBAction func usrConfirm(_ sender: Any) {
        newUsrData.isHidden = true
    }
    
}
