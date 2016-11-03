//
//  ItemMemoryStore.swift
//  PurchaseList
//
//  Created by Cesar Brenes on 11/1/16.
//  Copyright © 2016 Cesar Brenes. All rights reserved.
//

import UIKit

class ItemsSingleton: NSObject{
    static let sharedInstance = ItemsSingleton()
    var items = [Item(name:"Item 1", quantity: NSNumber(value: 2), id: NSNumber(value: 1)),
                 Item(name:"Item 2", quantity: NSNumber(value: 3), id: NSNumber(value: 2)),
                 Item(name:"Item 3", quantity: NSNumber(value: 5), id: NSNumber(value: 3)),
                 Item(name:"Item 4", quantity: NSNumber(value: 8), id: NSNumber(value: 4)),
                 Item(name:"Item 5", quantity: NSNumber(value: 10), id: NSNumber(value: 5)),
                 Item(name:"Item 6", quantity: NSNumber(value: 3), id: NSNumber(value: 6)),
                 Item(name:"Item 7", quantity: NSNumber(value: 1), id: NSNumber(value: 7)),
                 Item(name:"Item 8", quantity: NSNumber(value: 2), id: NSNumber(value: 8))]
}


class ItemMemoryStore: ItemStoreProtocol {
    

    var items: [Item] =  ItemsSingleton.sharedInstance.items
    
    func fetchAllItems(completionHandler:  (_ itemsArray: [Item], _ error: ItemStoreError?) -> Void){
        completionHandler(ItemsSingleton.sharedInstance.items, nil)
       
    }
    
    func fetchItem(id: NSNumber, completionHandler:  (_ item: Item?, _ error: ItemStoreError?) -> Void){
        let result = items.filter({$0.id == id})
        completionHandler(result.first, nil)
    }
    
    func deleteItem(id: NSNumber, completionHandler: (_ error: ItemStoreError?) -> Void){
        if let index = getObjectIndex(id: id){
            items.remove(at: index)
            ItemsSingleton.sharedInstance.items = items
            completionHandler(nil)
        }
        else{
            completionHandler(ItemStoreError.CannotDelete("The id doesn't exist"))
        }
    }
    
    func createItem(item: Item, completionHandler:  (_ error: ItemStoreError?) -> Void){
        ItemsSingleton.sharedInstance.items.append(item)
        items = ItemsSingleton.sharedInstance.items
        completionHandler(nil)
    }
    
    
    func updateItem(item: Item, completionHandler: (_ error: ItemStoreError?) -> Void){
        if let index = getObjectIndex(id: item.id){
            items[index] = item
            ItemsSingleton.sharedInstance.items = items
            completionHandler(nil)
        }
        else{
            completionHandler(ItemStoreError.CannotUpdate("The id doesn't exist"))
        }
    }
    
    private func getObjectIndex(id: NSNumber?) -> Int?{
        if let id = id{
            let result = items.filter({$0.id == id})
            if result.count == 0{
                return nil
            }
            let index = items.index(of: result.first!)
            return index
        }
        return nil
    }
    
    
    
    

}
