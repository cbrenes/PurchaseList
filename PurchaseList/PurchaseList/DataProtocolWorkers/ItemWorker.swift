//
//  ItemWorker.swift
//  PurchaseList
//
//  Created by Cesar Brenes on 10/31/16.
//  Copyright © 2016 Cesar Brenes. All rights reserved.
//

import Foundation

class ItemWorker {
    
    var itemStore: ItemStoreProtocol
    
    init(itemStore: ItemStoreProtocol) {
        self.itemStore = itemStore
    }
    
    func fetchAllItems(completionHandler: (_ itemArray:[Item]) -> Void){
        itemStore.fetchAllItems(completionHandler: {itemsArray, error in
            if error != nil {
                completionHandler([])
            }
            else{
                completionHandler(itemsArray)
            }
        })
    }
    
    func fetchItem(id: NSNumber, completionHandler: (_ item:Item?, _ error: ItemStoreError?) -> Void){
        itemStore.fetchItem(id: id, completionHandler: {(item, error) in
            completionHandler(item, error)
        })
    }
    
    func deleteItem(id: NSNumber, completionHandler: (_ error: ItemStoreError?) -> Void){
        itemStore.deleteItem(id: id, completionHandler: {(error) in
            completionHandler(error)
        })
    }
    
    func createItem(item: Item, completionHandler: (_ error: ItemStoreError?) -> Void){
        itemStore.createItem(item: item, completionHandler: {(error) in
            completionHandler(error)
        })
    }
    
    func updateItem(item: Item, completionHandler: (_ error: ItemStoreError?) -> Void){
        itemStore.updateItem(item: item, completionHandler:{(error) in
            completionHandler(error)
        })
    }

}


protocol ItemStoreProtocol{
     func fetchAllItems(completionHandler:  (_ itemsArray: [Item], _ error: ItemStoreError?) -> Void)
     func fetchItem(id: NSNumber, completionHandler:  (_ item: Item?, _ error: ItemStoreError?) -> Void)
     func deleteItem(id: NSNumber, completionHandler: (_ error: ItemStoreError?) -> Void)
     func createItem(item: Item,  completionHandler:  (_ error: ItemStoreError?) -> Void)
     func updateItem(item: Item,  completionHandler:  (_ error: ItemStoreError?) -> Void)
}

enum ItemStoreError: Equatable, Error{
    case CannotFetch(String)
    case CannotDelete(String)
    case CannotCreate(String)
    case CannotUpdate(String)
}

func ==(lhs: ItemStoreError, rhs: ItemStoreError) -> Bool {
    switch (lhs, rhs) {
    case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
    case (.CannotDelete(let a), .CannotDelete(let b)) where a == b: return true
    case (.CannotCreate(let a), .CannotCreate(let b)) where a == b: return true
    case (.CannotUpdate(let a), .CannotUpdate(let b)) where a == b: return true
    default: return false
    }
}
