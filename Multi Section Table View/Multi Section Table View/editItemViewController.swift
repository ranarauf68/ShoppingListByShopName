//
//  editItemViewController.swift
//  Multi Section Table View
//
//  Created by Rana Rauf on 2/22/16.
//  Copyright © 2016 Faisal's Swift. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class editItemViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var editMode: String = ""
    var storeIndex: Int = 0
    var itemIndex: Int = 0
    var itemPicked: Bool = false
    var indexRow: Int = 0
    var storeRow: Int = 0
    var arrUOM = ["Bag", "Bottle", "Box", "Can", "DZ", "EA", "PK"]
    var arrStore = [String]()
    var pickerToolbar: UIToolbar!
    var shopToolbar: UIToolbar!
    var shopPickerView: UIPickerView!
    
//    var itemUOMpickerView: UIPickerView!
//    @IBOutlet weak var itemUOMPickerViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var itemUOMpickerView: UIPickerView!
//    @IBOutlet weak var storeNameLabel: UILabel!
    
    @IBOutlet weak var storeText: UITextField!
    @IBOutlet weak var itemNameText: UITextField!
    @IBOutlet weak var itemQuantityText: UITextField!
    @IBOutlet weak var quantityIncButton: UIButton!
    @IBOutlet weak var itemUOMText: UITextField!
    @IBOutlet weak var itemUOMPickerHeight: NSLayoutConstraint!
    @IBOutlet weak var itemUOMPickerBottom: NSLayoutConstraint!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var bottomBar: UINavigationBar!
//    @IBOutlet weak var itemUOMPickerBottomConstraint: NSLayoutConstraint!
    
//    @IBAction func itemUOMEditBegin(sender: UITextField) {
//        itemUOMpickerView.selectRow(indexRow, inComponent: 0, animated: true)
//    }
    
    @IBAction func storeTextEditBegin(_ sender: UITextField) {
        shopPickerView.isHidden = false
        shopToolbar.isHidden = false
        shopPickerView.selectRow(0, inComponent: 0, animated: true)
    }
    

    @IBAction func itemUOMEditBegin(_ sender: UITextField) {
        itemUOMpickerView.isHidden = false
        pickerToolbar.isHidden = false
        itemUOMpickerView.selectRow(indexRow, inComponent: 0, animated: true)
        itemUOMText.text = arrUOM[indexRow]
    }
    @IBAction func itemUOMEditingEnd(_ sender: UITextField) {
//        self.donePicker()
    }
    
    @IBAction func quantityPlusButton(_ sender: AnyObject) {
        
        if Int(itemQuantityText.text!)! <= 999 {
        
            itemQuantityText.text = String(Int(itemQuantityText.text!)! + 1)
        }
    }
    
    @IBAction func quantityMinusButton(_ sender: AnyObject) {
        
        if Int(itemQuantityText.text!)! > 1 {
            itemQuantityText.text = String(Int(itemQuantityText.text!)! - 1)
        }
    }
    
    @IBAction func undoButton(_ sender: AnyObject) {
        
        undoToolbar()
        
//        if editMode == "Edit"    {
//            loadDataFromDefaults()
//        } else {
//            
//            
//            var rtnVl: Int = -1
//            rtnVl = setupItemUOM("EA")
//            
//            if rtnVl != -1 && editMode == "Add" {
//                indexRow = rtnVl
//                itemUOMText.text = arrUOM[indexRow]
//            }
//            itemNameText.text = ""
//            itemQuantityText.text = "1"
//        }
//        //itemUOMPicker.selectRow(indexRow, inComponent: 0, animated: true)

        
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        saveDataToolbar()
//        if validateData() == true {
//            saveData()
//            
//            if editMode == "Edit" {
//                self.navigationController?.popViewControllerAnimated(true)
//            } else if editMode == "Add" {
//                initItems()
//            }
//            
//        } else {
//            
//        }
        
    }
    
    
    @IBAction func showItemHist(_ sender: AnyObject) {
        performSegue(withIdentifier: "itemHistSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemHistSegue" && editMode == "Edit" {

            let destinationVC: ItemHistCocoa = segue.destination as! ItemHistCocoa
            destinationVC.itemName = itemNameText.text!

        }
    }
    
    var sections: [Section] = SectionsData().getSectionsFromDefaults()

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
//            itemUOMPickerViewConstraint.constant = 100
            itemUOMPickerHeight.constant = 100
//            itemUOMPickerBottom.constant = 20
            bottomBar.bringSubviewToFront(bottomBar)
//            if shopPickerView.hidden == false {
//                var pickerRect = shopPickerView.frame
//                pickerRect.size.height = 100
//                pickerRect.size.width = 100
//                shopPickerView.frame = pickerRect
//            }
            print("Landscape", terminator: "")
        } else if UIDevice.current.orientation.isPortrait {
            itemUOMPickerHeight.constant = 200
//            itemUOMPickerBottom.constant = 50
//            itemUOMPickerViewConstraint.constant = 200
//            itemUOMPickerBottomConstraint.constant = 50
//            if shopPickerView.hidden == false {
//                var pickerRect = shopPickerView.frame
//                pickerRect.size.height = 150
//                pickerRect.size.width = 150
//                shopPickerView.frame = pickerRect
//
//            
//            }
            bottomBar.bringSubviewToFront(bottomBar)

            print("Portrait", terminator: "")
        }
    }
    
    func setupShopPickerView() {
        shopPickerView = UIPickerView(frame: CGRect(x: 0,y: 150,width: view.frame.width,height: 150))
        shopPickerView.tag = 2
        shopPickerView.backgroundColor = .white
        shopToolbar = UIToolbar()
        shopToolbar.barStyle = UIBarStyle.default
        shopToolbar.isTranslucent = true
        shopToolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        shopToolbar.sizeToFit()
        
        let doneShopButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(editItemViewController.doneShopPicker))
        shopToolbar.setItems([doneShopButton], animated: true)
        shopToolbar.isUserInteractionEnabled = true
        
        shopPickerView.delegate = self
        shopPickerView.dataSource = self
        storeText.delegate = self
        
        storeText.inputView = shopPickerView
//        storeText.inputAccessoryView = shopToolbar
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()

        statusLabel.isHidden = true
        statusLabel.center = CGPoint(x: -500, y: statusLabel.center.y)

        
        if editMode == "Add" {
            storeText.isUserInteractionEnabled = true
            setupShopPickerView()
            let rtnVl = -1
            setupItemUOM("EA")
            if rtnVl != -1 {
                indexRow = rtnVl
            }
        } else {
            storeText.isUserInteractionEnabled = false
        }
        
//        itemUOMpickerView = UIPickerView(frame: CGRectMake(0, 100, view.frame.width, 150))        
        itemUOMpickerView.backgroundColor = .white
        itemUOMpickerView.tag = 1
        
        pickerToolbar = UIToolbar()
        pickerToolbar.barStyle = UIBarStyle.default
        pickerToolbar.isTranslucent = true
        pickerToolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        pickerToolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(editItemViewController.donePicker))
//        var spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
//        var cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: "canclePicker")
        
//      pickerToolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)

        pickerToolbar.setItems([doneButton], animated: false)
        pickerToolbar.isUserInteractionEnabled = true
        
        
        
        itemUOMpickerView.showsSelectionIndicator = true
        
        
        self.itemUOMpickerView.dataSource = self
        self.itemUOMpickerView.delegate = self
        
        
        
        self.itemNameText.delegate = self
        self.itemQuantityText.delegate = self
        

        itemUOMpickerView.removeFromSuperview()
        
        itemUOMText.inputView = itemUOMpickerView
//        itemUOMText.inputAccessoryView = pickerToolbar
        
        
        self.navigationItem.hidesBackButton = true
        
        let newBackButton = UIBarButtonItem(title: "Shopping List", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(editItemViewController.back(_:)))
        
        
        self.navigationItem.leftBarButtonItem = newBackButton;

// Commented on 2016-03-09. Add Shop should only be available from the first screen.
//        if editMode == "Add" {
//            let newRightButton = UIBarButtonItem(title: "Add Shop", style: .Bordered, target: self, action: "addShop:")
//            self.navigationItem.rightBarButtonItem = newRightButton;
//        }
        

//        if editMode == "Edit" {
            loadDataFromDefaults()
//        }
        
        if sections.count == 0 {
            performSegue(withIdentifier: "addShop", sender: self)
        }
        
        setupKeyboardToolbar()

    }
    
    func addShop(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addShop", sender: self)
    }
    
    @objc func donePicker() {
        itemUOMpickerView.removeFromSuperview()
        itemUOMpickerView.isHidden = true
        pickerToolbar.isHidden =  true
        
    }

    @objc func doneShopPicker() {
        shopPickerView.removeFromSuperview()
        shopPickerView.isHidden = true
        shopToolbar.isHidden =  true
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        if editMode != "Add" {
            
            loadDataFromDefaults()
//            shopPickerView.reloadAllComponents()
            itemUOMpickerView.selectRow(indexRow, inComponent: 0, animated: true)
        }

    }
    
    func textFieldShouldReturn(_ userText: UITextField!) -> Bool {
        itemNameText.resignFirstResponder()
        itemQuantityText.resignFirstResponder()
        return true;
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true )
    }
    
    func validateData() -> Bool {
        var boolValidData: Bool = true
        var addMessage: String = ""
        
        if itemNameText.text?.characters.count > 40 {
            addMessage += "Item name cannot be more than 40 characters. "
            
            boolValidData = false
        }
        
        if itemNameText.text!.range(of: "|") != nil {
            addMessage += "Item Name cannot contain |. "
            boolValidData = false
        }
        
        if itemQuantityText.text?.characters.count > 2 {
            if editMode == "Edit" {
                displayAlert("Error", txtMessage: "Quantity cannot be more than 99.", txtButtonTitle: "OK")
            } else {
                addMessage += "Quantity is more than 99. "
            }
            boolValidData = false
        }
        
        if itemQuantityText.text == "0" {
            if editMode == "Edit" {
                displayAlert("Error", txtMessage: "Quantity cannot be 0.", txtButtonTitle: "OK")
            } else {
                addMessage += "Quantity is 0. "
            }
            boolValidData = false
        }
        
        if itemNameText.text?.characters.count == 0 {
            if editMode == "Edit" {
                displayAlert("Error", txtMessage: "Item name cannot be left blank. Enter item name or press Undo.", txtButtonTitle: "OK")
            } else {
                addMessage += "Item name empty. "
            }
            boolValidData = false
        }
        
        if itemQuantityText.text?.characters.count == 0 {
            if editMode == "Edit" {
                displayAlert("Error", txtMessage: "Item quantity cannot be left blank. Enter quantity or press Undo.", txtButtonTitle: "OK")
            } else {
                addMessage += "Quantity empty. "
            }
            boolValidData = false
        }
        
        if storeText.text?.characters.count == 0 {
            boolValidData = false
        }
        
        if itemUOMText.text?.characters.count == 0 {
            if editMode == "Edit" {
                displayAlert("Error", txtMessage: "Item UOM cannot be left blank. Enter item UOM or press Undo.", txtButtonTitle: "OK")
            } else {
                addMessage += "UOM empty. "
            }
            
            boolValidData = false
        }

        if boolValidData == false && editMode == "Add" {
            if itemNameText.text?.characters.count > 0 {
                displayAlert("Error", txtMessage: "Errors: " + addMessage, txtButtonTitle: "OK")
            }
        }
        
        if itemNameText.text?.range(of: "|") != nil {
            displayAlert("Error", txtMessage: "Item name cannot contain |", txtButtonTitle: "OK")
            boolValidData = false
        }
        
        return boolValidData
        
    }

    func saveData() {
        if editMode == "Edit" {
            var itemString: String = ""
            
            itemString = itemNameText.text! + "|"
            itemString += itemQuantityText.text! + "|"
            itemString += itemUOMText.text! + "|"
            itemString += String(itemPicked)
            
            sections[storeIndex].items[itemIndex] = itemString
            SectionsData().saveSectionsToDefaults(sections, sortOption: true)
//            displayStatusMessage("Item saved!")
//            removeStatusMessage(2.0)
            
//            self.navigationController?.popViewControllerAnimated(true)
//        } else if boolValidData == false && editMode == "Add" {
//            if itemNameText.text?.characters.count > 0 {
//                displayAlert("Error", txtMessage: "Errors: " + addMessage + "Either fix these errors or press undo and go back.", txtButtonTitle: "OK")
//            } else {
//                self.navigationController?.popViewControllerAnimated(true)
//            }
        } else if editMode == "Add" {
            var itemString: String = ""
            
            itemString = itemNameText.text! + "|"
            itemString += itemQuantityText.text! + "|"
            itemString += itemUOMText.text! + "|"
            itemString += "true"
            //            print(sections[storeIndex].heading)
            
            
            //            sections[storeIndex].heading = storeText.text!
            sections[storeIndex].items.append(itemString)
            SectionsData().saveSectionsToDefaults(sections, sortOption: true)
            
            print(sections[storeIndex].heading, terminator: "")
            print(itemString, terminator: "")
            displayStatusMessage("Item added!")
            removeStatusMessage(1.0)
            
//            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    
    @objc func back(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)

//        var boolValidData: Bool = true
//        var addMessage: String = ""
//        
//        if itemNameText.text?.characters.count > 40 {
//            addMessage += "Item name cannot be more than 40 characters. "
//            
//            boolValidData = false
//        }
//        
//        if itemNameText.text!.rangeOfString("|") != nil {
//            addMessage += "Item Name cannot contain |. "
//            boolValidData = false
//        }
//        
//        if itemQuantityText.text?.characters.count > 2 {
//            if editMode == "Edit" {
//                displayAlert("Error", txtMessage: "Quantity cannot be more than 99.", txtButtonTitle: "OK")
//            } else {
//                addMessage += "Quantity is more than 99. "
//            }
//            boolValidData = false
//        }
//        
//        if itemNameText.text?.characters.count == 0 {
//            if editMode == "Edit" {
//                displayAlert("Error", txtMessage: "Item name cannot be left blank. Enter item name or press Undo.", txtButtonTitle: "OK")
//            } else {
//                addMessage += "Item name empty. "
//            }
//            boolValidData = false
//        }
//        
//        if itemQuantityText.text?.characters.count == 0 {
//            if editMode == "Edit" {
//                displayAlert("Error", txtMessage: "Item quantity cannot be left blank. Enter item name or press Undo.", txtButtonTitle: "OK")
//            } else {
//                addMessage += "Quantity empty. "
//            }
//            boolValidData = false
//        }
//        
//        if storeText.text?.characters.count == 0 {
//            boolValidData = false
//        }
//        
//        if itemUOMText.text?.characters.count == 0 {
//            if editMode == "Edit" {
//                displayAlert("Error", txtMessage: "Item UOM cannot be left blank. Enter item UOM or press Undo.", txtButtonTitle: "OK")
//            } else {
//                addMessage += "UOM empty. "
//            }
//            
//            boolValidData = false
//        }
//        
//        
//        
//        if boolValidData == true && editMode == "Edit" {
//            var itemString: String = ""
//        
//            itemString = itemNameText.text! + "|"
//            itemString += itemQuantityText.text! + "|"
//            itemString += itemUOMText.text! + "|"
//            itemString += String(itemPicked)
//        
//            sections[storeIndex].items[itemIndex] = itemString
//            SectionsData().saveSectionsToDefaults(sections)
//        
//            self.navigationController?.popViewControllerAnimated(true)
//        } else if boolValidData == false && editMode == "Add" {
//            if itemNameText.text?.characters.count > 0 {
//                displayAlert("Error", txtMessage: "Errors: " + addMessage + "Either fix these errors or press undo and go back.", txtButtonTitle: "OK")
//            } else {
//                self.navigationController?.popViewControllerAnimated(true)
//            }
//        } else if boolValidData == true && editMode == "Add" {
//            var itemString: String = ""
//            
//            itemString = itemNameText.text! + "|"
//            itemString += itemQuantityText.text! + "|"
//            itemString += itemUOMText.text! + "|"
//            itemString += "true"
////            print(sections[storeIndex].heading)
//            
//            
////            sections[storeIndex].heading = storeText.text!
//            sections[storeIndex].items.append(itemString)
//            SectionsData().saveSectionsToDefaults(sections)
//            
//            print(sections[storeIndex].heading)
//            print(itemString)
//            
//            self.navigationController?.popViewControllerAnimated(true)
//        }
        
    }
    
    func displayAlert (_ txtTitle: String, txtMessage: String, txtButtonTitle: String) {
        let alertController = UIAlertController(title: txtTitle, message: txtMessage, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: txtButtonTitle, style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }

    func loadDataFromDefaults() {
        
        sections = SectionsData().getSectionsFromDefaults()
        if sections.count > 0 {
            storeText.text = SectionsData().extractShopName(sections[storeIndex].heading)
            itemQuantityText.text = "1"
            if editMode == "Add" {
                var rtnVl = -1
                rtnVl = setupItemUOM("EA")
                
                if rtnVl != -1 {
                    indexRow = rtnVl
                    itemUOMText.text = arrUOM[indexRow]
                }
            }
            
            if editMode == "Edit" {
                itemNameText.text = SectionsData().extractItemName(sections[storeIndex].items[itemIndex])
                itemQuantityText.text = String(SectionsData().extractItemQuantity(sections[storeIndex].items[itemIndex]))
                itemUOMText.text = SectionsData().extractItemUOM(sections[storeIndex].items[itemIndex])
                itemPicked = SectionsData().extractItemPicked(sections[storeIndex].items[itemIndex])
            
                for i in 0 ..< arrUOM.count {
                    if arrUOM[i] == itemUOMText.text {
                        indexRow = i
                    }
                }
                
            }
            
            arrStore.removeAll()    // Added later
            
            for i in 0 ..< sections.count {
                arrStore.append(SectionsData().extractShopName(sections[i].heading))
                
                if SectionsData().extractShopName(sections[i].heading) == storeText.text {
                    storeRow = i
                }
            }
        }
        
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return arrUOM.count
        } else if pickerView.tag == 2 {
            print(arrStore.count, terminator: "")
            return arrStore.count
        } else {
            return arrUOM.count
        }
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            itemUOMText.text = arrUOM[row]
            indexRow = row
        } else {
            storeText.text = arrStore[row]
            storeRow = row
            storeIndex = row
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return arrUOM[row]
        } else {
            return arrStore[row]
        }
    }

    
    func displayStatusMessage(_ strMessage: String) {
        statusLabel.text = strMessage
        statusLabel.isHidden = false
        statusLabel.alpha = 1.0
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.statusLabel.center = CGPoint(x: (self.view.frame.size.width - self.statusLabel.frame.size.width)/2 , y: self.statusLabel.center.y)
        })
        
    }
    
    func initItems() {
    
        itemNameText.text = ""
        itemQuantityText.text = "1"
        
        let rtnVl = setupItemUOM("EA")
        if rtnVl != -1 && editMode == "Add" {
            indexRow = rtnVl
            itemUOMText.text = arrUOM[indexRow]
        }
    
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
            
        })
    }
    
    func setupItemUOM(_ strUOM: String) -> Int {
        
        var rtnVal: Int = -1
        
        for i in 1 ..< arrUOM.count {
            if arrUOM[i] == strUOM {
                rtnVal = i
                break
            }
        }
        
        return rtnVal
    }
    
    
    func setupKeyboardToolbar() {
        let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        keyboardToolbar.barStyle = UIBarStyle.default
        
        keyboardToolbar.items = [
            UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editItemViewController.saveDataToolbar)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Undo", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editItemViewController.undoToolbar))
        ]
        
        keyboardToolbar.sizeToFit()
        itemNameText.inputAccessoryView = keyboardToolbar
        itemQuantityText.inputAccessoryView = keyboardToolbar
        itemUOMText.inputAccessoryView = keyboardToolbar
        storeText.inputAccessoryView = keyboardToolbar
        

    }
    
    @objc func saveDataToolbar() {
        if validateData() == true {
            saveData()
            
            if editMode == "Edit" {
                self.navigationController?.popViewController(animated: true)
            } else if editMode == "Add" {
                initItems()
            }
            
        } else {
            
        }

    }
    
    @objc func undoToolbar() {
        if editMode == "Edit"    {
            loadDataFromDefaults()
        } else {
            
            
            var rtnVl: Int = -1
            rtnVl = setupItemUOM("EA")
            
            if rtnVl != -1 && editMode == "Add" {
                indexRow = rtnVl
                itemUOMText.text = arrUOM[indexRow]
            }
            itemNameText.text = ""
            itemQuantityText.text = "1"
        }

        //itemUOMPicker.selectRow(indexRow, inComponent: 0, animated: true)
        itemNameText.resignFirstResponder()
        itemQuantityText.resignFirstResponder()
        
    }
    
    func cancelToolbar() {
        itemNameText.resignFirstResponder()
        itemQuantityText.resignFirstResponder()
        
    }

}
