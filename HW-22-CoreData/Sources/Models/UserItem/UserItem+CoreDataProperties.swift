//
//  UserItem+CoreDataProperties.swift
//  HW-22-CoreData
//
//  Created by Gabriel Zdravkovici on 25.12.2023.
//
//

import Foundation
import CoreData


extension UserItem {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserItem> {
        return NSFetchRequest<UserItem>(entityName: "UserItem")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var dateOfBirth: Date?
    @NSManaged public var gender: String?
    
}

extension UserItem : Identifiable {
    
}
