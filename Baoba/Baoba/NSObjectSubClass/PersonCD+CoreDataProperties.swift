//
//  PersonCD+CoreDataProperties.swift
//  Baoba
//
//  Created by Fábio França on 31/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//
//

import Foundation
import CoreData


extension PersonCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonCD> {
        return NSFetchRequest<PersonCD>(entityName: "PersonCD")
    }

    @NSManaged public var descricao: String?
    @NSManaged public var image: NSData?
    @NSManaged public var nome: String?
    @NSManaged public var sexo: String?
    @NSManaged public var id: Int16
    @NSManaged public var conjuge: PersonCD?
    @NSManaged public var mae: PersonCD?
    @NSManaged public var pai: PersonCD?

}
