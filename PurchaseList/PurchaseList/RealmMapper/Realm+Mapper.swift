//
//  Realm+Mapper.swift
//  PurchaseList
//
//  Created by Cesar Brenes on 10/31/16.
//  Copyright © 2016 Cesar Brenes. All rights reserved.
//


import Foundation

extension RealmItem{
    func toItem() -> Item{
        return Item(name: name, quantity: NSNumber(value: quantity), id: NSNumber(value: id))
    }
}
