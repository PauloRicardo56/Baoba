//
//  Person+CoreDataProperties.swift
//  
//
//  Created by Fábio França on 30/07/19.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var nome: String?
    @NSManaged public var sexo: String?
    @NSManaged public var descricao: String?
    @NSManaged public var image: NSData?
    @NSManaged public var conjuge: Person?
    @NSManaged public var pai: Person?
    @NSManaged public var mae: Person?

}
