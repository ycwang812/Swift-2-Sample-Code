//
//  Student+CoreDataProperties.swift
//  CoreDataModify
//
//  Created by eHappyMac1 on 2016/3/3.
//  Copyright © 2016年 ehappy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Student {

    @NSManaged var name: String?
    @NSManaged var chinese: NSNumber?
    @NSManaged var math: NSNumber?

}
