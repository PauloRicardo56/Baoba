//
//  Person.swift
//  Baoba
//
//  Created by Fábio França on 10/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class Person{
    
    var nome = String()
    var sexo = String()
    var descricao = String()
    var image = UIImage()
    
    weak var pai:Person?
    weak var mae:Person?
    weak var conjuge:Person?
    var irmaos = Array<Person>()
    var filhos = Array<Person>()
    
    init(nome: String, sexo: String, descricao: String, image: UIImage) {
        self.nome = nome
        self.sexo = sexo
        self.descricao = descricao
        self.image = image
        print("foi")
    }
    
    
}



