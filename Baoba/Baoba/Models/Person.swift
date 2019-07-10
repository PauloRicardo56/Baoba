//
//  Person.swift
//  Baoba
//
//  Created by Fábio França on 10/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class Person{
    let nome: String
    let sexo: Character
    let descricao: String
    let image: UIImage
    
    let pai: Person?
    let mae: Person?
    let conjuge: Person?
    let irmaos = Array<Person>()
    let filhos = Array<Person>()
    
    init(nome: String, sexo: Character, descricao: String,image: UIImage) {
        self.nome = nome
        self.sexo = sexo
        self.descricao = descricao
        self.image = image
    }
    
}
