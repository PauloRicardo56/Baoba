//
//  FirstViewController.swift
//  Baoba
//
//  Created by Fábio França on 09/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

//class FirstViewController: UIViewController,imagePickerFotoSelecionada {
//
//    //@IBOutlet weak var newUsrData: FirstFormController!
//    @IBOutlet weak var newUsrData: UIView!
//    @IBOutlet weak var addBtn: UIButton!
//    @IBOutlet weak var personImageView: UIImageView!
//
//    @IBOutlet weak var addFotoBtn: UIButton!
//    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var sexoSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var descriptionTextView: UITextView!
//    @IBOutlet weak var addBtn2: UIButton!
//
//    let imagePicker = ImagePicker()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.arredondaButton(button: addBtn, multiplicador: 0.5)
//        self.imagePicker.delegate = self
//    }
//
//
//    @IBAction func addPerson(_ sender: Any) {
//
//        //        newUsrData.isHidden = false
//        newUsrData.isHidden = false
//        newUsrData.alpha = 1.0
//        usrViewBounds()
//
//        newUsrData.transform = CGAffineTransform(scaleX: 0.3, y: 2)
//        //        newUsrData.transform = CGAffineTransform(rotationAngle: 0.5)
//
//        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
//            self.newUsrData.transform = .identity
//        }) { (_) in
//            print("oi")
//        }
//
//        self.arredondaView(view: personImageView, multiplicador: 0.5)
//       self.arredondaView(view: descriptionTextView, multiplicador: 0.09)
//        self.arredondaButton(button: addFotoBtn, multiplicador: 0.5)
//        self.arredondaButton(button: addBtn2, multiplicador: 0.2)
//
//    }
//
//    func mostrarMultimidia(opcao:MenuOpcoes){
//        let multimidia = UIImagePickerController()
//        multimidia.delegate = self.imagePicker
//
//        if opcao == .camera && UIImagePickerController.isSourceTypeAvailable(.camera){
//            multimidia.sourceType = .camera
//        }else{
//            multimidia.sourceType = .photoLibrary
//        }
//        self.present(multimidia, animated: true, completion: nil)
//    }
//
//    // delegate
//    func imagePickerFotoSelecionada(image: UIImage) {
//        self.personImageView.image = image
//    }
//
//
//    @IBAction func addImage(_ sender: Any) {
//        let menu = ImagePicker().menuDeOpcao { (opcao) in
//            self.mostrarMultimidia(opcao: opcao)
//        }
//        present(menu,animated: true,completion: nil)
//    }
//
//    func arredondaView(view: UIView, multiplicador: CGFloat) {
//        view.layer.cornerRadius = view.frame.width * multiplicador
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.lightGray.cgColor
//    }
//
//    func arredondaButton(button: UIButton, multiplicador: CGFloat) {
//        button.layer.cornerRadius = button.frame.width * multiplicador
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.lightGray.cgColor
//    }
//
//    func usrViewBounds(){
//        self.newUsrData.layer.cornerRadius = self.newUsrData.frame.width * 0.05
//        self.newUsrData.layer.borderWidth = 1
//    }
//
//
//    @IBAction func usrConfirm(_ sender: Any) {
//        UIView.transition(with: newUsrData, duration: 0.5, options: .transitionCrossDissolve, animations: {
//            self.newUsrData.alpha = 0.0
//        }, completion: nil)
//
//    }
//
//}
