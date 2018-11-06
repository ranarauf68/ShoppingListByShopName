//
//  SectionsViewCell.swift
//  Multi Section Table View
//
//  Created by Rana Rauf on 2/17/16.
//  Copyright © 2016 Faisal's Swift. All rights reserved.
//

//import Cocoa

import UIKit

extension Date
{
    func hour() -> Int
    {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.hour, from: self)
        let hour = components.hour
        
        return hour!
    }
    
    
    func minute() -> Int
    {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.minute, from: self)
        let minute = components.minute
        
        return minute!
    }
    
    func second() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.second, from: self)
        let second = components.second
        
        return second!
    }
    
    func year() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.year, from: self)
        let year = components.year
        
        return year!
    }
    
    func month() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.month, from: self)
        let month = components.month
        
        return month!
    }
    
    func day() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let day = components.day
        
        return day!
    }
    
    
    func formattedDate() -> String {
        let DT = Date()
        var strDate = ""
        
        strDate += String(format: "%02d", DT.month()) + "-"
        strDate += String(format: "%02d", DT.day()) + "-"
        strDate += String(format: "%04d", DT.year()) + " "
        
        strDate += String(format: "%02d", DT.hour()) + ":"
        strDate += String(format: "%02d", DT.minute()) + ":"
        strDate += String(format: "%02d", DT.second())
        
        return strDate
    }
    
    func sortDate() -> String {
        let DT = Date()
        var strDate = ""
        
        strDate += String(format: "%04d", DT.year()) + "-"
        strDate += String(format: "%02d", DT.month()) + "-"
        strDate += String(format: "%02d", DT.day()) + " "
        
        strDate += String(format: "%02d", DT.hour()) + ":"
        strDate += String(format: "%02d", DT.minute()) + ":"
        strDate += String(format: "%02d", DT.second())
        
        return strDate
    }
}

class SectionsViewCell: UITableViewCell {

    @IBOutlet weak var itemCell: UILabel!
    @IBOutlet weak var qtyCell: UILabel!
    @IBOutlet weak var uomCell: UILabel!
    @IBOutlet weak var pickedSwitch: UISwitch!

    var DT = Date()
    
    @IBAction func pickedSwitchChanged(_ sender: UISwitch) {
        
        var secIndex: Int = 0
        var itemIndex: Int = 0
        
        var sections: [Section] = SectionsData().getSectionsFromDefaults()
        
        
        //Extracts secIndex and itemIndex from the combined value of the tag set by the SectionsViewController.
        secIndex = pickedSwitch.tag / 1000
        itemIndex = pickedSwitch.tag - 1000*(pickedSwitch.tag / 1000)
        
        
        //Build the new item string based on modified value of the itemPicked switch
        let modifiedItem = SectionsData().setItemPicked(sections[secIndex].items[itemIndex], boolPicked: pickedSwitch.isOn)
        sections[secIndex].items[itemIndex] = modifiedItem

        //Save the modified value of the item string to defaults
        SectionsData().saveSectionsToDefaults(sections, sortOption: false)
        
        let DT = Date()
        
        if pickedSwitch.isOn == false {
            var itemHist = [ItemHistory]()
            
            
            let strItemName = SectionsData().extractItemName(sections[secIndex].items[itemIndex])
            let strShopName = SectionsData().extractShopName(sections[secIndex].heading)
            let strDateTime = DT.formattedDate()
            let strQuantity = String(SectionsData().extractItemQuantity(sections[secIndex].items[itemIndex]))
            let strUOM = String(SectionsData().extractItemUOM(sections[secIndex].items[itemIndex]))
            
            
            itemHist = ItemHistoryData().additemHistory(itemHist, pItem: strItemName, pShop: strShopName, pDateTime: strDateTime, pQuantity: strQuantity, pUOM: strUOM!)
            
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }

}
