//
//  ItemHistCocoa.swift
//  Multi Section Table View
//
//  Created by Rana Rauf on 4/18/16.
//  Copyright © 2016 Faisal's Swift. All rights reserved.
//

import UIKit

class ItemHistCocoa: UITableViewController {
    
    var itemName: String = ""
    var itemNameHistArray = [ItemHistory]()
    
    override func viewDidLoad() {
        
        
        itemNameHistArray = ItemHistoryData().getItemHistoryItemFromDefaults(itemName)
//        UITableViewHeaderFooterView.header.color = UIColor.brownColor()
        
        
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemNameHistArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if itemNameHistArray.count > 0 {
            return itemNameHistArray[0].item + " from " + itemNameHistArray[0].shop
        } else {
            return "Please purchase some items first"
        }
    
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemHistCellCocoa
        
        if itemNameHistArray[indexPath.row].UOM != "EA" {
            cell.itemShopQuantityLabel.text = "  " + itemNameHistArray[indexPath.row].quantity + " " + itemNameHistArray[indexPath.row].UOM
        } else {
            cell.itemShopQuantityLabel.text = "  " + itemNameHistArray[indexPath.row].quantity
            
        }
        
        cell.dateTimeLabel.text = itemNameHistArray[indexPath.row].dateTime
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel!.textColor = UIColor.brown
        header.textLabel!.font = UIFont.boldSystemFont(ofSize: 20)
        let headerFrame = header.frame
        header.textLabel!.frame = headerFrame
        header.textLabel!.textAlignment = .left
    }
    

}
