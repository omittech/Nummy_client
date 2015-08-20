//
//  ItemModel.swift
//  Nummy
//
//  Created by Cheng Sun on 2015-08-10.
//  Copyright (c) 2015 Cheng Sun. All rights reserved.
//

import UIKit
import CoreData

@objc(ItemModel)
class ItemModel: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var amount: NSNumber
    @NSManaged var price: String?
}
