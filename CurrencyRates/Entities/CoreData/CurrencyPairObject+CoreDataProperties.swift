//
//  CurrencyPairObject+CoreDataProperties.swift
//  Created by Alexander Antonov on 13/04/2019.
//
//

import Foundation
import CoreData


extension CurrencyPairObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyPairObject> {
        return NSFetchRequest<CurrencyPairObject>(entityName: "CurrencyPairObject")
    }

    @NSManaged public var rawValue: String
    @NSManaged public var dateAdded: NSDate

}
