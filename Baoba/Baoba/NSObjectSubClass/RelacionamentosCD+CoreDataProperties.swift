//
//  RelacionamentosCD+CoreDataProperties.swift
//  Baoba
//
//  Created by Fábio França on 30/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//
//

import Foundation
import CoreData


extension RelacionamentosCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RelacionamentosCD> {
        return NSFetchRequest<RelacionamentosCD>(entityName: "RelacionamentosCD")
    }

    @NSManaged public var id_person_1: URL?
    @NSManaged public var id_person_2: URL?
    @NSManaged public var parentesco: Int16

}
