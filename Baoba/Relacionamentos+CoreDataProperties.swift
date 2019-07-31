//
//  Relacionamentos+CoreDataProperties.swift
//  
//
//  Created by Fábio França on 30/07/19.
//
//

import Foundation
import CoreData


extension Relacionamentos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Relacionamentos> {
        return NSFetchRequest<Relacionamentos>(entityName: "Relacionamentos")
    }

    @NSManaged public var id_person_1: URL?
    @NSManaged public var id_person_2: URL?
    @NSManaged public var parentesco: Int16

}
