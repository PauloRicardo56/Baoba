//
//  FormAddPerson.swift
//  Baoba
//
//  Created by Fábio França on 11/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

extension CollectionViewController: imagePickerFotoSelecionada{
    func mostrarMultimidia(opcao:MenuOpcoes){
        let multimidia = UIImagePickerController()
        multimidia.delegate = self.imagePicker
        
        if opcao == .camera && UIImagePickerController.isSourceTypeAvailable(.camera){
            multimidia.sourceType = .camera
        }else{
            multimidia.sourceType = .photoLibrary
        }
        self.present(multimidia, animated: true, completion: nil)
    }
    
    // delegate
    func imagePickerFotoSelecionada(image: UIImage) {
        self.personImageView.image = image
    }
    
    
    @IBAction func addImage(_ sender: Any) {
        let menu = ImagePicker().menuDeOpcao { (opcao) in
            self.mostrarMultimidia(opcao: opcao)
        }
        present(menu,animated: true,completion: nil)
    }
    
    func arredondaView(view: UIView, multiplicador: CGFloat) {
        view.layer.cornerRadius = view.frame.width * multiplicador
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func arredondaButton(button: UIButton, multiplicador: CGFloat) {
        button.layer.cornerRadius = button.frame.width * multiplicador
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func usrViewBounds(){
        self.newUsrData.layer.cornerRadius = self.newUsrData.frame.width * 0.05
        self.newUsrData.layer.borderWidth = 1
    }
    
    
    @IBAction func usrConfirm(_ sender: Any) {
        UIView.transition(with: newUsrData, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.newUsrData.alpha = 0.0
        }, completion: ({(acao) in
            self.cell.isHidden = false
        }))
        
        var sexo = String()
        if sexoSegmentedControl.selectedSegmentIndex == 0{
            sexo = "Masculino"
        }else{
            sexo = "Feminino"
        }
        
        guard let nome = self.nameTextField.text, let image = self.personImageView.image,let description = self.descriptionTextView.text else{
            return
        }
        
        let pessoa = Person(nome: nome, sexo: sexo, descricao: description, image: image,visivel: true)
        pessoa.pai = desconhecido
        pessoa.mae = desconhecido
        pessoa.conjuge = desconhecido
        
        persons.append(pessoa)
        
        switch self.indexPathRow {
        case 0:
            mainPerson?.mae = pessoa
        case 1:
            mainPerson?.conjuge = pessoa
        case 2:
            mainPerson?.pai = pessoa
        case 4:
            mainPerson = pessoa
        default:
            if self.indexPathRow! % 3 == 0 || self.indexPathRow! % 3 == 2{
                mainPerson?.irmaos.append(pessoa)
            }else{
                mainPerson?.filhos.append(pessoa)
            }
        }
        //mainPerson = pessoa
        
        self.resetarDados()
        
        
        self.collectionView.indexPathsForVisibleItems.forEach { (index) in
            self.collectionView.cellForItem(at: index)?.alpha = 1.0
        }
        
        collectionView.reloadData()
        collectionView.indexPathsForVisibleItems.forEach { (index) in
            collectionView.cellForItem(at: index)?.isHidden = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        newUsrData.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func resetarDados(){
        self.nameTextField.text = ""
        self.descriptionTextView.text = ""
        self.personImageView.isHidden = true
        self.addFotoBtn.isHidden = false
    }


}
