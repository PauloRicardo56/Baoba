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
    
    let pai = Person()
    let mae = Person()
    let conjuge = Person()
    let irmaos = Array<Person>()
    let filhos = Array<Person>()
    
    init() {
    }
}


