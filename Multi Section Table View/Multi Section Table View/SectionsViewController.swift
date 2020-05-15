//
//  SectionsViewController.swift
//  Multi Section Table View
//
//  Created by Rana Rauf on 2/9/16.
//  Copyright © 2016 Faisal's Swift. All rights reserved.
//

import UIKit


class SectionsViewController: UITableViewController {
    
    var itemIndex: Int = 0
    var storeIndex: Int = 0
    var editMode: String = ""
    var statusLabel: UILabel!

    //var sections: [Section] = SectionsData().getSectionsFromData()
    var sections: [Section] = SectionsData().getSectionsFromDefaults()
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionsData().extractShopName(sections[section].heading)
    }
    
/*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sectionCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        
        return cell
    }
*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sections: [Section] = SectionsData().getSectionsFromDefaults()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! SectionsViewCell

        cell.itemCell.text = SectionsData().extractItemName(sections[indexPath.section].items[indexPath.row])
        cell.qtyCell.text = String(SectionsData().extractItemQuantity(sections[indexPath.section].items[indexPath.row]))
        cell.uomCell.text = SectionsData().extractItemUOM(sections[indexPath.section].items[indexPath.row])
        cell.pickedSwitch.isOn = SectionsData().extractItemPicked(sections[indexPath.section].items[indexPath.row])
        cell.pickedSwitch.tag = 1000*indexPath.section +  indexPath.row

        return cell

    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            
//            sections[indexPath.section].items.removeAtIndex(indexPath.row)
//            SectionsData().saveSectionsToDefaults(sections)
            
            SectionsData().deleteItem(sections, sectionIndex: indexPath.section, itemIndex: indexPath.row)
            sections = SectionsData().getSectionsFromDefaults()
            tableView.reloadData()
            
        }
        
        
        
    }

    /*
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("sectionCell", forIndexPath: indexPath) as! SectionsViewCell
        
        var cellText: String = ""
        print(indexPath)
        cellText = cell.itemCell.text! + "|" + cell.qtyCell.text! + "|" + cell.uomCell.text! + "|" + String(cell.pickedSwitch.on)
        print(cellText)
        sections[indexPath.section].items[indexPath.row] = cellText
    }
    */

    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addSegue" {
            var targetViewController = segue.destinationViewController as! UIViewController
            
            
        }
    }
    */
    
    
    override func viewDidAppear(_ animated: Bool) {
        //sections = SectionsData().getSectionsFromData()
        sections = SectionsData().getSectionsFromDefaults()
        tableView.reloadData()
        
        //SectionsData().saveSectionsToDefaults(sections)

    }

    
    override func viewDidLoad() {
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(SectionsViewController.longPress(_:)))
        self.view.addGestureRecognizer(longPressRecognizer)

        statusLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        statusLabel.center = CGPoint(x: -500, y: 0)
        statusLabel.textAlignment = .center
        statusLabel.text = "test"
        self.view.addSubview(statusLabel)
        
        displayStatusMessage("Test message")
        removeStatusMessage(2.0)
        
        
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0)
        
        if sections.count == 0 {
//            self.performSegueWithIdentifier("addShop2", sender: self)
            DispatchQueue.main.async {
                [unowned self] in
                self.performSegue(withIdentifier: "addShop2", sender: self)
            }
        }
    }
    
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
//                print(indexPath.section)
//                print(indexPath.row)
                
                itemIndex = indexPath.row
                storeIndex = indexPath.section
                
                
                performSegue(withIdentifier: "editSegue", sender: self)
                
                
                
                // your code here, get the row for the indexPath or do whatever you want
            } 
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            let destinationVC: editItemViewController = segue.destination as! editItemViewController
            destinationVC.editMode = "Edit"
            destinationVC.itemIndex = self.itemIndex
            destinationVC.storeIndex = self.storeIndex
            
        } else if segue.identifier == "addItemSegue" {
            let destinationVC: editItemViewController = segue.destination as! editItemViewController
            destinationVC.editMode = "Add"
            destinationVC.itemIndex = 0
            destinationVC.storeIndex = 0
            
        }
    }
    

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel!.textColor = UIColor.brown
        header.textLabel!.font = UIFont.boldSystemFont(ofSize: 20)
        let headerFrame = header.frame
        header.textLabel!.frame = headerFrame
        header.textLabel!.textAlignment = .left
    }
    
/*
    override func viewDidDisappear(animated: Bool) {
    }
*/
    
    /*
    func saveSections() {
        var sectionsArray = [String]()
        var itemsArray = [String()]
        
        for var i = 0; i < sections.count; i++ {
            sectionsArray.append(sections[i].heading)
            itemsArray.removeAll()
            
            for var j = 0; j < sections[i].items.count; j++ {
                
                var title = sections[i]
                let item = title.items[j]
                
                itemsArray.append(item)
                
                
            }
            
            NSUserDefaults.standardUserDefaults().setObject(itemsArray, forKey: sections[i].heading)
            
        }
        
        NSUserDefaults.standardUserDefaults().setObject(sectionsArray, forKey: "sections")

    }
    */
    
    
    func displayStatusMessage(_ strMessage: String) {
        print("label attempted")
        statusLabel.text = strMessage
        statusLabel.isHidden = false
        statusLabel.alpha = 1.0
        
        print("label setup")
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.statusLabel.center = CGPoint(x: (self.view.frame.size.width - self.statusLabel.frame.size.width)/2 , y: self.statusLabel.center.y)
            
            self.statusLabel.bringSubviewToFront(self.view)
            
            print("label displayed")
        })
        
    }

    func removeStatusMessage(_ dblSec: Double ) {
        //        let seconds = 1.0
        let seconds = dblSec
        
        let delay = seconds * Double(NSEC_PER_SEC)
        
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            
            self.statusLabel.isHidden = true
            self.statusLabel.alpha = 1.0
            self.statusLabel.center = CGPoint(x: -500, y: self.statusLabel.center.y)
            print("label removed")
            
        })
    }

    
}
