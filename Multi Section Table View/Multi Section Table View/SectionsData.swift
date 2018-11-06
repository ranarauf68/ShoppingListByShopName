//
//  SectionsData.swift
//  Multi Section Table View
//
//  Created by Rana Rauf on 2/9/16.
//  Copyright © 2016 Faisal's Swift. All rights reserved.
//

//import Foundation
import UIKit

class SectionsData {

    
    
    
    func addSection(_ addSec: [Section], addTitle: String) -> [Section] {
        var addSec = addSec
    
        
        let addItemArray = [String]()
        let addItems = Section(title: addTitle, objects: addItemArray)
        
        addSec.append(addItems)
        saveSectionsToDefaults(addSec, sortOption: false)
        
        return addSec
    }
    
    func addItem(_ addItemSec: [Section], sectionIndex: Int, addItemName: String) -> [Section] {
        var addItemSec = addItemSec
        
//        print(sectionIndex, terminator: "")
        addItemSec[sectionIndex].items.append(addItemName)
        
        
        saveSectionsToDefaults(addItemSec, sortOption: true)
        
        return addItemSec
    }
    
    
    func deleteSection(_ secIndex: Int, delSec: [Section]) {
        var delSec = delSec
        delSec.remove(at: secIndex)
        saveSectionsToDefaults(delSec, sortOption: true)
    }
    
    func deleteItem(_ delSec: [Section], sectionIndex: Int, itemIndex: Int) {
        var delSec = delSec
        delSec[sectionIndex].items.remove(at: itemIndex)
        saveSectionsToDefaults(delSec, sortOption: true)
    }
    
    func getSectionsFromDefaults() -> [Section] {
        var secArray = [Section]()
        secArray.removeAll()

        
        
//        let secNSArray = NSUserDefaults.standardUserDefaults().objectForKey("sections")! as! NSArray

//        do {
        
        if let secTempArray =  UserDefaults.standard.object(forKey: "sections") {
            
            let secNSArray =   UserDefaults.standard.object(forKey: "sections")! as! NSArray
        
            var secName:String!

        
        //Read sections from default Array
            for i in 0 ..< secNSArray.count {
                secName = secNSArray[i] as! String

                let itemNSArray = UserDefaults.standard.object(forKey: secName) as! NSArray

                var itemsArray = [String]()

                //Read items from default Array
                for j in 0 ..< itemNSArray.count {
                
                    itemsArray.append(itemNSArray[j] as! String)
                }

                let items = Section(title: secName, objects: itemsArray)
                itemsArray.removeAll()
            
                secArray.append(items)
            
            }
//        } catch {
//            print("failed")
//        }
        }
        
        return secArray
    }
    
    func extractItemName(_ sItemName: String) ->String {
        var strItemName: String = ""
        var intCnt: Int = 0
        
        for i in sItemName.characters {
            if i == "|" {
                intCnt += 1
            }
            
            if intCnt == 0 && i != "|" {
                strItemName += String(i)
            }
        }
        
        return strItemName
    }
    
    func extractItemUOM(_ shopItemUOM: String) ->String {
        var strItemUOM: String = ""
        var intCnt: Int = 0
        
        for i in shopItemUOM.characters {
            if i == "|" {
                intCnt += 1
            }
            
            if intCnt == 2 && i != "|" {
                strItemUOM += String(i)
            }
        }
        
        return strItemUOM
    }
    
    
    func extractItemQuantity(_ shopItemQuantity: String) ->Int {
        var strItemQuantity: String = ""
        var intItemQuantity: Int = 0
        var intCnt: Int = 0
        
        for i in shopItemQuantity.characters {
            if i == "|" {
                intCnt += 1
            }
            
            if intCnt == 1 && i != "|" {
                strItemQuantity += String(i)
            }
        }
        
        intItemQuantity = Int(strItemQuantity)!
        
        return intItemQuantity
    }

    func extractItemPicked(_ shopItemPicked: String) -> Bool {
        var strItemPicked: String = ""
        var boolItemPicked: Bool = false
        var intCnt: Int = 0
        
        for i in shopItemPicked.characters {
            if i == "|" {
                intCnt += 1
            }
        
        
            if intCnt == 3 && i != "|" {
                strItemPicked += String(i)
            }
        }
        
        if strItemPicked == "true" {
            boolItemPicked = true
        } else {
            boolItemPicked = false
        }
        
        return boolItemPicked
    }
    
    func setItemPicked(_ strItem: String, boolPicked: Bool) -> String {
        var intCnt: Int = 0
        var strReturn: String = ""
        
        for i in strItem.characters {
            if i == "|" {
                intCnt += 1
            }
            
            if intCnt < 3 {
                strReturn += String(i)
            }
        }
        
        strReturn += "|" + String(boolPicked)
        
        return strReturn
    }
    
    func saveSectionsToDefaults(_ secs: [Section], sortOption: Bool) {
        var sectionsArray = [String]()
        var itemsArray = [String()]
        
        
//        var secs = [Section]()
        
//        var secs = SectionsData().getSectionsFromDefaults()

        
        for i in 0 ..< secs.count {
            sectionsArray.append(secs[i].heading)
            itemsArray.removeAll()
            
            for j in 0 ..< secs[i].items.count {
                
                var title = secs[i]
                let item = title.items[j]
                
                itemsArray.append(item)
                
                if sortOption == true {
                    itemsArray = itemsArray.sorted{$0 < $1}
                }
                
            }
            
            UserDefaults.standard.set(itemsArray, forKey: secs[i].heading)
            
        }
        
        UserDefaults.standard.set(sectionsArray, forKey: "sections")

    }
    
    
    func extractShopName(_ sShopName: String) ->String {
        var strShopName: String = ""
        var intCnt: Int = 0
        
        for i in sShopName.characters {
            if i == "|" {
                intCnt += 1
            }
            
            if intCnt == 0 && i != "|" {
                strShopName += String(i)
            }
        }
        
        return strShopName
    }

    func extractShopAddr1(_ sShopAddr1: String) ->String {
        var strShopAddr1: String = ""
        var intCnt: Int = 0
        
        for i in sShopAddr1.characters {
            if i == "|" {
                intCnt += 1
            }
            
            if intCnt == 1 && i != "|" {
                strShopAddr1 += String(i)
            }
        }
        
        return strShopAddr1
    }

    func extractShopAddr2(_ sShopAddr2: String) ->String {
        var strShopAddr2: String = ""
        var intCnt: Int = 0
        
        for i in sShopAddr2.characters {
            if i == "|" {
                intCnt += 1
            }
            
            if intCnt == 2 && i != "|" {
                strShopAddr2 += String(i)
            }
        }
        
        return strShopAddr2
    }

    func extractShopCity(_ sShopCity: String) ->String {
        var strShopCity: String = ""
        var intCnt: Int = 0
        
        for i in sShopCity.characters {
            if i == "|" {
                intCnt += 1
            }
            
            if intCnt == 3 && i != "|" {
                strShopCity += String(i)
            }
        }
        
        return strShopCity
    }
    
    func extractShopState(_ sShopState: String) ->String {
        var strShopState: String = ""
        var intCnt: Int = 0
        
        for i in sShopState.characters {
            if i == "|" {
                intCnt += 1
            }
            
            if intCnt == 4 && i != "|" {
                strShopState += String(i)
            }
        }
        
        return strShopState
    }

    func extractShopCountry (_ sShopCountry: String) ->String {
        var strShopCountry: String = ""
        var intCnt: Int = 0
        
        for i in sShopCountry.characters {
            if i == "|" {
                intCnt += 1
            }
            
            if intCnt == 5 && i != "|" {
                strShopCountry += String(i)
            }
        }
        
        return strShopCountry
    }

    
    func extractShopZip (_ sShopZip: String) ->String {
        var strShopZip: String = ""
        var intCnt: Int = 0
        
        for i in sShopZip.characters {
            if i == "|" {
                intCnt += 1
            }
            
            if intCnt == 6 && i != "|" {
                strShopZip += String(i)
            }
        }
        
        return strShopZip
    }

}
