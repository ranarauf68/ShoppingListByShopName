//
//  ItemHistoryData.swift
//  Multi Section Table View
//
//  Created by Rana Rauf on 4/5/16.
//  Copyright © 2016 Faisal's Swift. All rights reserved.
//

//import Foundation
import UIKit

class ItemHistoryData {

    func additemHistory(_ addHist: [ItemHistory], pItem:String, pShop: String, pDateTime: String, pQuantity: String, pUOM: String ) -> [ItemHistory] {
        
        let addHistElement = ItemHistory(itemTitle: pItem, shopTitle: pShop, dateTimeTitle: pDateTime, quantityTitle: pQuantity, UOMTitle: pUOM)
        var addHistV: [ItemHistory] = getItemHistoryFromDefaults()
        
        addHistV.append(addHistElement)
        
//        print(addHistElement.item)
//        print(addHistElement.shop)
//        print(addHist.count)
        
        saveItemHistoryToDefaults(addHistV)
        
        return addHist
    }
    
    
    func saveItemHistoryToDefaults(_ addHist: [ItemHistory]) {
        
//        var addHistArray = [ItemHistory]()
        
        var addHistItemArray = [String]()
        var addHistShopArray = [String]()
        var addHistQuantityArray = [String]()
        var addHistDateTimeArray = [String]()
        var addHistUOMArray = [String]()
        
        for i in 1...addHist.count  {
            addHistItemArray.append(addHist[i-1].item)
            addHistShopArray.append(addHist[i-1].shop)
            addHistDateTimeArray.append(addHist[i-1].dateTime)
            addHistQuantityArray.append(addHist[i-1].quantity)
            addHistUOMArray.append(addHist[i-1].UOM)
        }
        
//        print(addHistArray[0].item)
//        print(addHistArray[0].shop)
//        print(addHistArray[0].dateTime)
//        print(addHistArray.count)
        
        UserDefaults.standard.set(addHistItemArray, forKey: "ItemHistoryItem2")
        UserDefaults.standard.set(addHistShopArray, forKey: "ItemHistoryShop2")
        UserDefaults.standard.set(addHistDateTimeArray, forKey: "ItemHistoryDateTime2")
        UserDefaults.standard.set(addHistQuantityArray, forKey: "ItemHistoryQuantity2")
        UserDefaults.standard.set(addHistUOMArray, forKey: "ItemHistoryUOM2")

    }

    
    func deleteItemHistory(_ itemIndex: Int, delItemHist: [ItemHistory]) {
        
        var delItemHistV: [ItemHistory] = delItemHist
        
        delItemHistV.remove(at: itemIndex)
        saveItemHistoryToDefaults(delItemHistV)
    }

    
    func getItemHistoryFromDefaults() -> [ItemHistory] {
        
        var addHistItemArray = [String]()
        var addHistShopArray = [String]()
        var addHistQuantityArray = [String]()
        var addHistDateTimeArray = [String]()
        var addHistUOMArray = [String]()
        
        var itemHistArray = [ItemHistory]()
        
        itemHistArray.removeAll()
        
        //Build items array from user default
        if let ns = UserDefaults.standard.object(forKey: "ItemHistoryItem2") {
            
            let itemHistItemNSArray =   UserDefaults.standard.object(forKey: "ItemHistoryItem2")! as! NSArray
            
            for i in 1...itemHistItemNSArray.count {
                addHistItemArray.append(itemHistItemNSArray[i-1] as! String)
            }
        }
        
        //Build shop array from user defaults
        if UserDefaults.standard.object(forKey: "ItemHistoryShop2") != nil {
            
            let itemHistShopNSArray =   UserDefaults.standard.object(forKey: "ItemHistoryShop2")! as! NSArray
            
            for i in 1...itemHistShopNSArray.count {
                addHistShopArray.append(itemHistShopNSArray[i-1] as! String)
            }
        }
        
        //Build date time array from user defaults
        if UserDefaults.standard.object(forKey: "ItemHistoryDateTime2") != nil {
            
            let itemHistDateTimeNSArray = UserDefaults.standard.object(forKey: "ItemHistoryDateTime2")! as! NSArray
            
            for i in 1...itemHistDateTimeNSArray.count  {
                addHistDateTimeArray.append(itemHistDateTimeNSArray[i-1] as! String)
            }
        }
        
        //Build quantity array from user defaults
        if UserDefaults.standard.object(forKey: "ItemHistoryQuantity2") != nil {
            
            let itemHistQuantityNSArray =   UserDefaults.standard.object(forKey: "ItemHistoryQuantity2")! as! NSArray
            
            for i in 1...itemHistQuantityNSArray.count {
                addHistQuantityArray.append(itemHistQuantityNSArray[i-1] as! String)
            }
        }
        
        //Build UOM array from user defaults
        if UserDefaults.standard.object(forKey: "ItemHistoryUOM2") != nil {
            
            let itemHistUOMNSArray =   UserDefaults.standard.object(forKey: "ItemHistoryUOM2")! as! NSArray
            
            for i in 1...itemHistUOMNSArray.count {
                addHistUOMArray.append(itemHistUOMNSArray[i-1] as! String)
            }
        }
        
        //Build item history array from all of the above arrays
        //This is where I left
        
//        print(addHistQuantityArray.count)
        

        if addHistQuantityArray.count > 0 {
            for i in 1...addHistQuantityArray.count {
                let ItemHist = ItemHistory(itemTitle: addHistItemArray[i-1], shopTitle: addHistShopArray[i-1], dateTimeTitle: addHistDateTimeArray[i-1], quantityTitle: addHistQuantityArray[i-1], UOMTitle: addHistUOMArray[i-1])
            
                itemHistArray.append(ItemHist)
            }
        }
        
//        for itemEle in itemHistArray {
//            print(itemEle.item + "-" + itemEle.shop + "-" + itemEle.dateTime + "-" + itemEle.quantity )
//        }
        
        return itemHistArray
    }

    

    func getItemHistoryItemFromDefaults(_ pItemName: String) -> [ItemHistory] {
        
        var addHistItemArray = [String]()
        var addHistShopArray = [String]()
        var addHistQuantityArray = [String]()
        var addHistDateTimeArray = [String]()
        var addHistUOMArray = [String]()
        
        var itemHistArray = [ItemHistory]()
        
        itemHistArray.removeAll()
        
        //Build items array from user default
        if let ns = UserDefaults.standard.object(forKey: "ItemHistoryItem2") {
            
            let itemHistItemNSArray =   UserDefaults.standard.object(forKey: "ItemHistoryItem2")! as! NSArray
            
            for i in 1...itemHistItemNSArray.count {
                addHistItemArray.append(itemHistItemNSArray[i-1] as! String)
            }
        }
        
        //Build shop array from user defaults
        if UserDefaults.standard.object(forKey: "ItemHistoryShop2") != nil {
            
            let itemHistShopNSArray =   UserDefaults.standard.object(forKey: "ItemHistoryShop2")! as! NSArray
            
            for i in 1...itemHistShopNSArray.count {
                addHistShopArray.append(itemHistShopNSArray[i-1] as! String)
            }
        }
        
        //Build date time array from user defaults
        if UserDefaults.standard.object(forKey: "ItemHistoryDateTime2") != nil {
            
            let itemHistDateTimeNSArray = UserDefaults.standard.object(forKey: "ItemHistoryDateTime2")! as! NSArray
            
            for i in 1...itemHistDateTimeNSArray.count  {
                addHistDateTimeArray.append(itemHistDateTimeNSArray[i-1] as! String)
            }
        }
        
        //Build quantity array from user defaults
        if UserDefaults.standard.object(forKey: "ItemHistoryQuantity2") != nil {
            
            let itemHistQuantityNSArray =   UserDefaults.standard.object(forKey: "ItemHistoryQuantity2")! as! NSArray
            
            for i in 1...itemHistQuantityNSArray.count {
                addHistQuantityArray.append(itemHistQuantityNSArray[i-1] as! String)
            }
        }

        //Build UOM array from user defaults
        if UserDefaults.standard.object(forKey: "ItemHistoryUOM2") != nil {
            
            let itemHistUOMNSArray =   UserDefaults.standard.object(forKey: "ItemHistoryUOM2")! as! NSArray
            
            for i in 1...itemHistUOMNSArray.count {
                addHistUOMArray.append(itemHistUOMNSArray[i-1] as! String)
            }
        }

        
        //Build item history array from all of the above arrays
        //This is where I left
        
        //        print(addHistQuantityArray.count)
        
        
        if addHistQuantityArray.count > 0 {
            for i in 1...addHistQuantityArray.count {
                let ItemHist = ItemHistory(itemTitle: addHistItemArray[i-1], shopTitle: addHistShopArray[i-1], dateTimeTitle: addHistDateTimeArray[i-1], quantityTitle: addHistQuantityArray[i-1], UOMTitle: addHistUOMArray[i-1] )
                
                itemHistArray.append(ItemHist)
            }
        }
        
        //        for itemEle in itemHistArray {
        //            print(itemEle.item + "-" + itemEle.shop + "-" + itemEle.dateTime + "-" + itemEle.quantity )
        //        }
        
        
        var itemHistItemArray = [ItemHistory]()
        
        for itemHistItemElement in itemHistArray {
            if itemHistItemElement.item  == pItemName {
                print(itemHistItemElement.item) 
                itemHistItemArray.append(itemHistItemElement)
            }
        }
        
        print(itemHistItemArray.count)
        
        return itemHistItemArray
    }

    
    
    
}
