//
//  addEditShop.swift
//  Multi Section Table View
//
//  Created by Rana Rauf on 2/29/16.
//  Copyright © 2016 Faisal's Swift. All rights reserved.
//

import UIKit

class addEditShop: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var sections: [Section] = SectionsData().getSectionsFromDefaults()
    var shopPickerView: UIPickerView!
    var arrShop = [String]()
    var storeRow: Int = 0
    var storeIndex: Int = 0
    var editMode = "Edit"
    var shopPickerViewSetup: Bool = false
    var initialStatusLabelX: CGFloat!
    
    var parentEditMode = ""
    
    

    @IBOutlet weak var shopNameText: UITextField!
    @IBOutlet weak var shopAddress1Text: UITextField!
    @IBOutlet weak var shopAddress2Text: UITextField!
    @IBOutlet weak var shopCityText: UITextField!
    @IBOutlet weak var shopStateText: UITextField!
    @IBOutlet weak var shopCountryText: UITextField!
    @IBOutlet weak var shopZipText: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func deleteButton(_ sender: AnyObject) {
        
        if sections.count > 0 {
            let messageAlert: String = "This will delete the shop: " + SectionsData().extractShopName(sections[storeRow].heading) + " and all it's items. Are you sure?"
            let refreshAlert = UIAlertController(title: "Warning", message: messageAlert, preferredStyle: UIAlertController.Style.alert)
        
            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction) in
                print("Handle Ok logic here", terminator: "")
                SectionsData().deleteSection(self.storeIndex, delSec: self.sections)
                self.sections = SectionsData().getSectionsFromDefaults()
                
                if self.sections.count > 0 {
                    self.setupEditMode()
                    self.fillArray()
                    self.populateFirstShop()
                    self.shopAddress1Text.becomeFirstResponder()
                
                    self.displayStatusMessage("Shop deleted!")
                    self.removeStatusMessage()
                    self.storeRow = 0
                    self.storeIndex = 0
                    self.hideKeyboard()
                    
                } else if self.sections.count == 0 {
                    self.displayStatusMessage("Shop deleted!")
                    self.removeStatusMessage()
                    self.setupAddMode()
                    self.shopNameText.becomeFirstResponder()

                }
            
            }))
        
            refreshAlert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction) in
                print("Handle Cancel Logic here", terminator: "")
            
                self.populateCurrentShop()
                self.setupEditMode()
                self.shopAddress1Text.becomeFirstResponder()
            }))
        
        
            present(refreshAlert, animated: true, completion: nil)
        } else {
            displayAlert("Error", txtMessage: "Nothing to delete!", txtButtonTitle: "OK")
        }
    
    
    }
  
    
    @IBAction func saveBarButton(_ sender: AnyObject) {
        saveDataToolbar()
        
//        if editMode == "Edit" {
//            
//            if sections.count > 0 {
//                sections[storeRow].heading = shopNameText.text! + "|" + shopAddress1Text.text! + "|" + shopAddress2Text.text! + "|" + shopCityText.text! + "|" + shopStateText.text! + "|" + shopCountryText.text! + "|" + shopZipText.text!
//        
////                print(sections[storeRow].heading)
////                print(storeRow)
//        
//                SectionsData().saveSectionsToDefaults(sections, sortOption: false)
//                displayStatusMessage("Shop Saved!")
//                removeStatusMessage()
//            }
//        } else if editMode == "Add" {
//            
//            if validateData() == true {
//            
//                let appendString = shopNameText.text! + "|" + shopAddress1Text.text! + "|" + shopAddress2Text.text! + "|" + shopCityText.text! + "|" + shopStateText.text! + "|" + shopCountryText.text! + "|" + shopZipText.text!
//            
//            
//                SectionsData().addSection(sections, addTitle: appendString)
//                sections = SectionsData().getSectionsFromDefaults()
//                if shopPickerViewSetup != true {
//                    setupShopPickerView()
//                }
//                setupEditMode()
//                fillArray()
//                
//                displayStatusMessage("Shop added!")
//                removeStatusMessage()
//            }
//        }
        
    }
    
    func displayStatusMessage(_ strMessage: String) {
        statusLabel.text = strMessage
        statusLabel.isHidden = false
        statusLabel.alpha = 1.0
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
//            self.statusLabel.center = CGPointMake(self.statusLabel.center.x + 400, self.statusLabel.center.y)
//            self.statusLabel.center = CGPointMake(0.0, self.statusLabel.center.y)
            
            self.statusLabel.center = CGPoint(x: (self.view.frame.size.width - self.statusLabel.frame.size.width)/2 , y: self.statusLabel.center.y)
            
            print("First block \(self.statusLabel.center.x)", terminator: "")
            
            
        })
        
//        UIView.animateWithDuration(0.75, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction , animations: { () -> Void in
//            self.statusLabel.hidden = false
//            self.statusLabel.alpha = 1.0
//            print("First block \(self.statusLabel.center.x)")
//
//            self.statusLabel.center = CGPointMake(self.statusLabel.center.x - 100, self.statusLabel.center.y)
//            }, completion: { (Bool) -> Void in
//                dispatch_async(dispatch_get_main_queue(),{
//                    print("Second block \(self.statusLabel.center.x)")
//                    self.statusLabel.hidden = false
//                    self.statusLabel.alpha = 1.0
//                    self.statusLabel.center = CGPointMake(self.statusLabel.center.x - 100, self.statusLabel.center.y)
//                })
//        })
        // Following block of code is used to add a second's delay
    }

    func removeStatusMessage() {
        let seconds = 1.0
    
        let delay = seconds * Double(NSEC_PER_SEC)
    
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
    
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
    
            self.statusLabel.isHidden = true
            self.statusLabel.alpha = 1.0
            self.statusLabel.center = CGPoint(x: -500, y: self.statusLabel.center.y)
//            self.statusLabel.center = CGPointMake(self.initialStatusLabelX, self.statusLabel.center.y)
//            self.statusLabel.center = CGPointMake(self.statusLabel.center.x - 400 , self.statusLabel.center.y)
            print("Remove block \(self.statusLabel.center.x)", terminator: "")
   
        })
    }

    
    func validateData()->Bool {

        var rtnVal: Bool = true
        var errMsg: String = ""
        
        if shopNameText.text?.characters.count == 0 {
            errMsg += "Shop name cannot be empty. "
            rtnVal = false
        }
        
        if shopNameText.text!.range(of: "|") != nil {
            errMsg += "Shop name cannot contain | . "
            rtnVal = false
        }
//
        if shopAddress1Text.text!.range(of: "|") != nil {
            errMsg += "Address 1 cannot contain | . "
            rtnVal = false
        }

        if shopAddress2Text.text!.range(of: "|") != nil {
            errMsg += "Address 2 cannot contain | . "
            rtnVal = false
        }
        
        if shopCityText.text!.range(of: "|") != nil {
            errMsg += "City cannot contain | . "
            rtnVal = false
        }




        if shopCountryText.text!.range(of: "|") != nil {
            errMsg += "Country cannot contain | . "
            rtnVal = false
        }
        
        if shopStateText.text!.range(of: "|") != nil {
            errMsg += "State cannot contain | . "
            rtnVal = false
        }
        
        if shopZipText.text!.range(of: "|") != nil {
            errMsg += "Zip cannot contain | . "
            rtnVal = false
        }
        
        if rtnVal == false {
            displayAlert("Error", txtMessage: errMsg, txtButtonTitle: "OK")
        }
        
        return rtnVal
    }
    
    @IBAction func undoBarButton(_ sender: AnyObject) {
        populateShopDetail()
    }
    
    @IBOutlet weak var undoBarButton: UIBarButtonItem!
    
    @IBAction func shopNameTextEditBegin(_ sender: AnyObject) {
        if sections.count > 0 {
            shopPickerView.isHidden = false
            shopPickerView.selectRow(storeRow, inComponent: 0, animated: true)
        }
    }

    @IBAction func shopNameTextEditEnd(_ sender: AnyObject) {
//        if sections.count > 0 {
//            shopPickerView.hidden = true
//        }
    }
    
    
    override func viewDidLoad() {
        

        
        print("Before ViewDidLoad block \(self.statusLabel.center.x)", terminator: "")
        statusLabel.isHidden = true
//        statusLabel.center = CGPointMake(statusLabel.center.x - 500, statusLabel.center.y)
        statusLabel.center = CGPoint(x: -500, y: statusLabel.center.y)
        initialStatusLabelX = statusLabel.center.x
        print("ViewDidLoad block \(self.statusLabel.center.x)", terminator: "")

        
        if sections.count > 0 {
//            shopNameText.text =  SectionsData().extractShopName(sections[1].heading)
//            shopAddress1Text.text = SectionsData().extractShopAddr1(sections[1].heading)
//            shopAddress2Text.text = SectionsData().extractShopAddr2(sections[1].heading)
//            shopCityText.text = SectionsData().extractShopCity(sections[1].heading)
//            shopStateText.text = SectionsData().extractShopState(sections[1].heading)
//            shopCountryText.text = SectionsData().extractShopCountry(sections[1].heading)
//            shopZipText.text = SectionsData().extractShopZip(sections[1].heading)

            shopNameText.text = SectionsData().extractShopName(sections[0].heading)
            setupShopPickerView()
            populateShopDetail()
        } else {
            addShopButton(self)
        }
        
        setupKeyboardToolbar()
        
    }
    
    @IBAction func addShopButton(_ sender: AnyObject) {
        setupAddMode()
        shopNameText.becomeFirstResponder()
    }
    
    func setupAddMode() {
        setupAddKeyboardToolbar()
        editMode = "Add"
        if sections.count > 0 {
            shopPickerView.isHidden = true
        }
        shopNameText.inputView = nil
        initFields()
        
    }
    
    func setupEditMode() {
        editMode = "Edit"
        shopNameText.inputAccessoryView = nil
        shopNameText.inputView = shopPickerView
        if shopPickerView.isHidden == true {
            shopPickerView.isHidden = false
        }
    }
    
    func setupShopPickerView() {
        shopPickerView = UIPickerView(frame: CGRect(x: 0,y: 150,width: view.frame.width,height: 150))
        shopPickerView.tag = 1
        shopPickerView.backgroundColor = .white
        
        shopPickerView.delegate = self
        shopPickerView.dataSource = self
//        shopNameText.delegate = self
        
        fillArray()
        
        shopNameText.inputView = shopPickerView
        //        storeText.inputAccessoryView = shopToolbar
        
        shopPickerViewSetup = true
    }
    
    func fillArray() {
        arrShop.removeAll()
//        arrShop.append("New Shop")
        for i in 0 ..< sections.count {
            arrShop.append(SectionsData().extractShopName(sections[i].heading))
        }
        
        shopPickerView.reloadAllComponents()
    }

    
    override func viewDidDisappear(_ animated: Bool) {
//        print(shopNameText.text)
//        print(shopAddress1Text.text)
//        
//        sections[1].heading = shopNameText.text! + "|" + shopAddress1Text.text! + "|" + shopAddress2Text.text! + "|" + shopCityText.text! + "|" + shopStateText.text! + "|" + shopCountryText.text! + "|" + shopZipText.text!
//        
//        print(sections[1].heading)
//        
//        SectionsData().saveSectionsToDefaults(sections)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if shopPickerView.tag == 1 {
            return arrShop.count
        } else {
            return arrShop.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if shopPickerView.tag == 1 {
            shopNameText.text = arrShop[row]
            storeRow = row
            storeIndex = row
            
            populateShopDetail()
        }
    }

    
    func populateFirstShop() {
        if sections.count > 0 {
            shopNameText.text = SectionsData().extractShopName(sections[0].heading)
            shopAddress1Text.text = SectionsData().extractShopAddr1(sections[0].heading)
            shopAddress2Text.text = SectionsData().extractShopAddr2(sections[0].heading)
            shopCityText.text = SectionsData().extractShopCity(sections[0].heading)
            shopCountryText.text = SectionsData().extractShopCountry(sections[0].heading)
            shopStateText.text = SectionsData().extractShopState(sections[0].heading)
            shopZipText.text = SectionsData().extractShopZip(sections[0].heading)
        }
    }

    
    func populateCurrentShop() {
        if sections.count > 0 {
            shopNameText.text = SectionsData().extractShopName(sections[storeRow].heading)
            shopAddress1Text.text = SectionsData().extractShopAddr1(sections[storeRow].heading)
            shopAddress2Text.text = SectionsData().extractShopAddr2(sections[storeRow].heading)
            shopCityText.text = SectionsData().extractShopCity(sections[storeRow].heading)
            shopCountryText.text = SectionsData().extractShopCountry(sections[storeRow].heading)
            shopStateText.text = SectionsData().extractShopState(sections[storeRow].heading)
            shopZipText.text = SectionsData().extractShopZip(sections[storeRow].heading)
        }
    }

    
    func populateShopDetail() {
        for i in 0 ..< sections.count {
            if SectionsData().extractShopName(sections[i].heading) == shopNameText.text {
                shopAddress1Text.text = SectionsData().extractShopAddr1(sections[i].heading)
                shopAddress2Text.text = SectionsData().extractShopAddr2(sections[i].heading)
                shopCityText.text = SectionsData().extractShopCity(sections[i].heading)
                shopCountryText.text = SectionsData().extractShopCountry(sections[i].heading)
                shopStateText.text = SectionsData().extractShopState(sections[i].heading)
                shopZipText.text = SectionsData().extractShopZip(sections[i].heading)
                break
            }
        }
    }
    
//    func populateFirstShop() {
//        if sections.count > 0 {
//            shopNameText.text = SectionsData().extractShopName(sections[0].heading)
//            shopAddress1Text.text = SectionsData().extractShopAddr1(sections[0].heading)
//            shopAddress2Text.text = SectionsData().extractShopAddr2(sections[0].heading)
//            shopCityText.text = SectionsData().extractShopCity(sections[0].heading)
//            shopCountryText.text = SectionsData().extractShopCountry(sections[0].heading)
//            shopStateText.text = SectionsData().extractShopState(sections[0].heading)
//            shopZipText.text = SectionsData().extractShopZip(sections[0].heading)
//        }
//    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if shopPickerView.tag == 1 {
            return arrShop[row]
        } else {
            return arrShop[row]
        }
    }
    
    
    func textFieldShouldReturn(_ userText: UITextField!) -> Bool {
        shopNameText.resignFirstResponder()
        shopAddress1Text.resignFirstResponder()
        shopAddress2Text.resignFirstResponder()
        shopCityText.resignFirstResponder()
        shopCountryText.resignFirstResponder()
        shopStateText.resignFirstResponder()
        shopZipText.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true )
    }

    func initFields() {
        shopNameText.text = ""
        shopAddress2Text.text = ""
        shopAddress1Text.text = ""
        shopCityText.text = ""
        shopCountryText.text = ""
        shopStateText.text = ""
        shopZipText.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addShop" {
            print("add Shop", terminator: "")
        }
    }
    
    func displayAlert (_ txtTitle: String, txtMessage: String, txtButtonTitle: String) {
        let alertController = UIAlertController(title: txtTitle, message: txtMessage, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: txtButtonTitle, style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupKeyboardToolbar() {
        let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        keyboardToolbar.barStyle = UIBarStyle.default
        
        keyboardToolbar.items = [
            UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addEditShop.saveDataToolbar)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Undo", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addEditShop.cancelToolbar))
        ]
        
        keyboardToolbar.sizeToFit()
//        shopNameText.inputAccessoryView = keyboardToolbar
        shopAddress1Text.inputAccessoryView = keyboardToolbar
        shopAddress2Text.inputAccessoryView = keyboardToolbar
        shopCityText.inputAccessoryView = keyboardToolbar
        shopCountryText.inputAccessoryView = keyboardToolbar
        shopStateText.inputAccessoryView = keyboardToolbar
        shopZipText.inputAccessoryView = keyboardToolbar
    }

    @objc func saveDataToolbar() {
        if editMode == "Edit" {
            
            if sections.count > 0 {
                sections[storeRow].heading = shopNameText.text! + "|" + shopAddress1Text.text! + "|" + shopAddress2Text.text! + "|" + shopCityText.text! + "|" + shopStateText.text! + "|" + shopCountryText.text! + "|" + shopZipText.text!
                
                //                print(sections[storeRow].heading)
                //                print(storeRow)
                
                SectionsData().saveSectionsToDefaults(sections, sortOption: false)
                displayStatusMessage("Shop Saved!")
                removeStatusMessage()
            }
        } else if editMode == "Add" {
            
            if validateData() == true {
                
                let appendString = shopNameText.text! + "|" + shopAddress1Text.text! + "|" + shopAddress2Text.text! + "|" + shopCityText.text! + "|" + shopStateText.text! + "|" + shopCountryText.text! + "|" + shopZipText.text!
                
                
                SectionsData().addSection(sections, addTitle: appendString)
                sections = SectionsData().getSectionsFromDefaults()
                if shopPickerViewSetup != true {
                    setupShopPickerView()
                }
                setupEditMode()
                fillArray()
                
                displayStatusMessage("Shop added!")
                removeStatusMessage()
                hideKeyboard()
            }
        }
    }
    
    @objc func cancelToolbar() {
        
        populateShopDetail()
        hideKeyboard()
        
        //        shopNameText.resignFirstResponder()
        //        shopAddress1Text.resignFirstResponder()
        //        shopAddress2Text.resignFirstResponder()
        //        shopCityText.resignFirstResponder()
        //        shopCountryText.resignFirstResponder()
        //        shopStateText.resignFirstResponder()
        //        shopZipText.resignFirstResponder()
        
    }

    @objc func cancelAddToolbar() {
        
        populateFirstShop()
        hideKeyboard()
        setupEditMode()
        
    }

    
    func hideKeyboard() {
        shopNameText.resignFirstResponder()
        shopAddress1Text.resignFirstResponder()
        shopAddress2Text.resignFirstResponder()
        shopCityText.resignFirstResponder()
        shopCountryText.resignFirstResponder()
        shopStateText.resignFirstResponder()
        shopZipText.resignFirstResponder()
    }
    
    func setupAddKeyboardToolbar() {
        let keyboardAddToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        keyboardAddToolbar.barStyle = UIBarStyle.default
        
        keyboardAddToolbar.items = [
            UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addEditShop.saveDataToolbar)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Undo", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addEditShop.cancelAddToolbar))
        ]
        
        keyboardAddToolbar.sizeToFit()
        shopNameText.inputAccessoryView = keyboardAddToolbar
    }

}
