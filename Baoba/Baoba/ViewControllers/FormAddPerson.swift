//
//  FormAddPerson.swift
//  Baoba
//
//  Created by Fábio França on 11/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit
import CoreData

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
        
        let personCD = NSEntityDescription.insertNewObject(forEntityName: "PersonCD", into: context) as! PersonCD
        personCD.nome = nome
        personCD.sexo = sexo
        personCD.descricao = description
        personCD.image = image.pngData() as NSData? //converter UIImage para NSData
        let idAtual: Int16!
        if UserDefaults.standard.object(forKey: "idAtual") == nil {
            idAtual = 0
            UserDefaults.standard.set(idAtual+1, forKey: "idAtual")
        }else {
            idAtual = UserDefaults.standard.object(forKey: "idAtual") as! Int16
            UserDefaults.standard.set(idAtual+1, forKey: "idAtual")
        }

        personCD.id = UserDefaults.standard.object(forKey: "idAtual") as! Int16

        recuperarMainPerson()
        print("indexPath = \(indexPathRow)")
        switch self.indexPathRow {
        case 0:
            mainPerson?.mae = personCD
        case 1:
            mainPerson?.conjuge = personCD
        case 2:
            mainPerson?.pai = personCD
        case 4:
            mainPerson = personCD
            UserDefaults.standard.set(personCD.id, forKey: "mainPerson")
        default:
            let relacionamentoCD = NSEntityDescription.insertNewObject(forEntityName: "RelacionamentosCD", into: context) as! RelacionamentosCD
            relacionamentoCD.id_person_1 = mainPerson?.objectID.uriRepresentation()
            relacionamentoCD.id_person_2 = personCD.objectID.uriRepresentation()
            
            if self.indexPathRow! % 3 == 0 || self.indexPathRow! % 3 == 2{
                relacionamentoCD.parentesco = 1 //irmao
            }else{
                relacionamentoCD.parentesco = 2 //filho
            }
            recuperarMainPerson()
        }
        
        
        do {
            try context.save()
            print("dados salvos corretamente!!!"  )
        } catch {
            print("erro ao salvar os dados")
        }
        
        self.resetarDados()
        
        self.collectionView.indexPathsForVisibleItems.forEach { (index) in
            self.collectionView.cellForItem(at: index)?.alpha = 1.0
        }

        collectionView.reloadData()
        
//        collectionView.indexPathsForVisibleItems.forEach { (index) in
//            collectionView.cellForItem(at: index)?.isHidden = false
//        }
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
    
    func recuperarMainPerson(){
        let request: NSFetchRequest<PersonCD> = PersonCD.fetchRequest()
        let id = UserDefaults.standard.object(forKey: "mainPerson") as! Int16
        print(id)
        let predicteEqual = NSPredicate(format: "id == %@", NSNumber(integerLiteral: Int(id)))
        request.predicate = predicteEqual
        
        let mainPersonRecuperado = try? context.fetch(request)
        mainPerson = mainPersonRecuperado![0]
    }


    // teste
}
