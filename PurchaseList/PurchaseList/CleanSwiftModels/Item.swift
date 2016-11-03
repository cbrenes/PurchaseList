//
//  Item.swift
//  PurchaseList
//
//  Created by Cesar Brenes on 10/31/16.
//  Copyright © 2016 Cesar Brenes. All rights reserved.
//

import Foundation

struct Item: Equatable {
    var name: String?
    var quantity: NSNumber?
    var id: NSNumber?
}

func ==(lhs: Item, rhs: Item) -> Bool {
    return lhs.name == rhs.name
        && lhs.quantity == rhs.quantity
        && lhs.id == rhs.id
}
