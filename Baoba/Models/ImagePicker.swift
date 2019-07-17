//
//  ImagePicker.swift
//  Baoba
//
//  Created by Fábio França on 09/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

enum MenuOpcoes{
    case camera
    case biblioteca
}

protocol imagePickerFotoSelecionada {
    func imagePickerFotoSelecionada(image: UIImage)
}

class ImagePicker: NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var delegate: imagePickerFotoSelecionada?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let foto = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        delegate?.imagePickerFotoSelecionada(image: foto)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func menuDeOpcao(completion:@escaping(_ opcao:MenuOpcoes) -> Void) -> UIAlertController{
        let menu = UIAlertController(title: "Atençāo", message: "escolha uma das opções abaixo", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "tirar foto", style: .default) { (acao) in
            completion(.camera)
        }
        menu.addAction(camera)
        let biblioteca = UIAlertAction(title: "biblioteca", style: .default) { (acao) in
            completion(.biblioteca)
        }
        menu.addAction(biblioteca)
        let cancelar = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        
        return menu
    }
}
