//
//  ItemHistory.swift
//  Multi Section Table View
//
//  Created by Rana Rauf on 4/5/16.
//  Copyright © 2016 Faisal's Swift. All rights reserved.
//

//import Foundation


class ItemHistory {
    var item: String
    var shop:String
    var dateTime: String
    var quantity: String
    var UOM: String
    
    init(itemTitle: String, shopTitle: String, dateTimeTitle: String, quantityTitle: String, UOMTitle: String ) {
        item = itemTitle
        shop = shopTitle
        dateTime = dateTimeTitle
        quantity = quantityTitle
        UOM = UOMTitle
    }
}
