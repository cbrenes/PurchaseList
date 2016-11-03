//
//  ItemRealmStore.swift
//  PurchaseList
//
//  Created by Cesar Brenes on 11/1/16.
//  Copyright © 2016 Cesar Brenes. All rights reserved.
//

import Foundation
import RealmSwift

class ItemRealmStore: ItemStoreProtocol {
    
    
    let EMPTY_ARRAY = 0
    
    func fetchAllItems(completionHandler:  (_ itemsArray: [Item], _ error: ItemStoreError?) -> Void){
        let realm = try! Realm()
        let itemEntities = realm.objects(RealmItem.self)
        if itemEntities.count==EMPTY_ARRAY{
            completionHandler([], nil)
        }
        else{
            completionHandler(itemEntities.map{$0.toItem()}, nil)
        }
    }
    
    func fetchItem(id: NSNumber, completionHandler:  (_ item: Item?, _ error: ItemStoreError?) -> Void){
        let itemsArray = fetchItemInRealm(id: id)
        if itemsArray.count == EMPTY_ARRAY{
            completionHandler(nil, ItemStoreError.CannotFetch("The id selected doesn't exist in Realm"))
        }
        else{
            completionHandler(itemsArray.first?.toItem(), nil)
        }
    }
    
    func deleteItem(id: NSNumber, completionHandler: (_ error: ItemStoreError?) -> Void){
        let itemsArray = fetchItemInRealm(id: id)
        if itemsArray.count == EMPTY_ARRAY{
            completionHandler(ItemStoreError.CannotDelete("The id selected doesn't exist in Realm"))
        }
        else{
            let realm = try! Realm()
            do{
                try realm.write( {
                    realm.delete(itemsArray.first!)
                    completionHandler(nil)
                })
            }
            catch{
                completionHandler(ItemStoreError.CannotDelete("The object couldn't be deleted"))
            }
        }
    }
    
    func createItem(item: Item, completionHandler:  (_ error: ItemStoreError?) -> Void){
        createItemInRealm(item: item, id: getIdForTheNewItemObject(), isUpdate: false, completionHandler: {(error) in
            completionHandler(error)
        })
    }
    
    
    func updateItem(item: Item, completionHandler: (_ error: ItemStoreError?) -> Void){
        if let id = item.id{
            createItemInRealm(item: item, id:id.intValue, isUpdate: false ,completionHandler: {(error) in
                completionHandler(error)
            })
        }
        else{
            completionHandler(ItemStoreError.CannotUpdate("The id doesn't exist"))
        }
    }
    
    private func createItemInRealm(item: Item, id: Int, isUpdate: Bool, completionHandler: (_ error: ItemStoreError?) -> Void){
        let realm = try! Realm()
        let realmItem = RealmItem()
        realmItem.id = id
        if let name = item.name{
            realmItem.name = name
        }
        if let quantity = item.quantity{
            realmItem.quantity = quantity.intValue
        }
        do{
            try realm.write( {
                realm.add(realmItem, update: true)
                completionHandler(nil)
            })
        }
        catch{
            if !isUpdate{
                 completionHandler(ItemStoreError.CannotCreate("The object couldn't be created"))
            }
            else{
                completionHandler(ItemStoreError.CannotUpdate("The object couldn't be updated"))
            }
        }
    }
    
    
    private func fetchItemInRealm(id: NSNumber) -> [RealmItem]{
        let realm = try! Realm()
        let itemsArray = realm.objects(RealmItem.self).filter("id = \(id.intValue)")
        return itemsArray.map{$0 as RealmItem}
    }
    
    private func getIdForTheNewItemObject() -> Int {
        let realm = try! Realm()
        let itemArray = realm.objects(RealmItem.self).sorted(byProperty: "id", ascending: false)
        if itemArray.count == EMPTY_ARRAY{
            return 1
        }
        return itemArray.first!.id + 1
    }
    
    
    
}
