//
//  RealmSwift.swift
//  PurchaseList
//
//  Created by Cesar Brenes on 10/28/16.
//  Copyright © 2016 Cesar Brenes. All rights reserved.
//

import UIKit
import RealmSwift
class RealmItem: Object {
    dynamic var name = ""
    dynamic var quantity = 0
    dynamic var id = 0
    override class func primaryKey() -> String? {
        return "id"
    }
}
