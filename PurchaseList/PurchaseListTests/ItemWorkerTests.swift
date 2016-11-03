//
//  ItemWorkerTests.swift
//  PurchaseList
//
//  Created by Cesar Brenes on 11/2/16.
//  Copyright © 2016 Cesar Brenes. All rights reserved.
//

import XCTest

class ItemWorkerTests: XCTestCase {
    
    var itemWorker: ItemWorker!
    
    override func setUp() {
        super.setUp()
        setupItemsWorker()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func setupItemsWorker(){
        itemWorker = ItemWorker(itemStore: ItemMemoryStore())
    }
    
    func testFetchAll() {
        let itemWorker = ItemWorker(itemStore: ItemMemoryStore())
        let asyncExpectation = expectation(description: "fetchAllItems")
        var itemsCount = 0
        itemWorker.fetchAllItems(completionHandler: {(items) in
            itemsCount = items.count
             asyncExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 3.0, handler: {(error) in
           XCTAssertEqual(8, itemsCount)
        })
    }
    
    
    func testInsert(){
        let asyncExpectation = expectation(description: "createItem")
        let newItem = Item(name: "test", quantity: NSNumber(value: 10), id: NSNumber(value: 9))
        var itemsCount = 0
        itemWorker.createItem(item: newItem, completionHandler: {(error) in
            itemWorker.fetchAllItems(completionHandler: {(items) in
                itemsCount = items.count
                asyncExpectation.fulfill()
            })
        })
        self.waitForExpectations(timeout: 3.0, handler: {(error) in
            XCTAssertEqual(9, itemsCount)
        })
    }
    
    
    func testDelete(){
         let asyncExpectation = expectation(description: "deleteItem")
         var itemsCount = 0
         itemWorker.deleteItem(id: NSNumber(value: 2), completionHandler: {(error) in
            itemWorker.fetchAllItems(completionHandler: {(items) in
                itemsCount = items.count
                asyncExpectation.fulfill()
            })
        })
        self.waitForExpectations(timeout: 3.0, handler: {(error) in
            XCTAssertEqual(7, itemsCount)
        })
    }
    
    func testUpdate(){
        var nameUpdated = ""
         let asyncExpectation = expectation(description: "updateItem")
        itemWorker.fetchAllItems(completionHandler: {(items) in
            var firstItem = items.first
            firstItem!.name = "itemUpdated"
            itemWorker.updateItem(item: firstItem!, completionHandler: {(error) in
                itemWorker.fetchAllItems(completionHandler: {(items) in
                    let updatedIcon = items.first
                    nameUpdated = updatedIcon!.name!
                    asyncExpectation.fulfill()
                })
            })
        })
        self.waitForExpectations(timeout: 3.0, handler: {(error) in
            XCTAssertEqual(nameUpdated, "itemUpdated")
        })
    }
    
}
