//
//  addItemViewController.swift
//  Multi Section Table View
//
//  Created by Rana Rauf on 2/11/16.
//  Copyright © 2016 Faisal's Swift. All rights reserved.
//

import UIKit


class addItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {


    var sections: [Section] = SectionsData().getSectionsFromDefaults()
    var indexRow: Int!

    //var sectionTitles = [String]()

    
    @IBOutlet weak var sectionNameLabel: UILabel!
    @IBOutlet weak var sectionPicker: UIPickerView!
    @IBOutlet weak var itemNameText: UITextField!
    @IBAction func addSectionButton(_ sender: AnyObject) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add section", message: "Section Name. Leave empty to cancel.", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            //print("Text field: \(textField.text)")
            
            if textField.text != "" {
                SectionsData().addSection(self.sections, addTitle: (textField.text)!)
                self.sections = SectionsData().getSectionsFromDefaults()
                //print(self.sections)
                self.sectionPicker.delegate = self
                self.sectionPicker.dataSource = self
                
                self.sectionPicker.reloadAllComponents()
                
                if self.sections.count == 1 {
                    self.indexRow = 1
                    self.sectionNameLabel.text = textField.text
                }
            }
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func addItemButton(_ sender: AnyObject) {
        
        if sections.count == 0 {
            displayAlert("Error", txtMessage: "Add section first.", txtButtonTitle: "OK")
        } else {
        
            if itemNameText.text == "" {
                displayAlert("Error", txtMessage: "Must enter item", txtButtonTitle: "OK")
            } else {
                print(indexRow, terminator: "")
                if sections.count == 1 {
                    indexRow = 0 
                }
                SectionsData().addItem(sections, sectionIndex: indexRow, addItemName: itemNameText.text!)
                sections = SectionsData().getSectionsFromDefaults()
                itemNameText.text = ""
            }
        }
    }

    @IBAction func deleteSectionButton(_ sender: AnyObject) {
        
        if sections.count == 0 {
            displayAlert("Error", txtMessage: "Add section first.", txtButtonTitle: "OK")

        } else {
        
            let refreshAlert = UIAlertController(title: "Delete Section", message: "Are you sure you want to delete " + sectionNameLabel.text! + "?", preferredStyle: UIAlertControllerStyle.alert)
        
            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction) in
                print(self.indexRow, terminator: "")
                if self.sections.count == 1 {
                    self.indexRow = 0
                }
                SectionsData().deleteSection(self.indexRow, delSec: self.sections)
                self.sections = SectionsData().getSectionsFromDefaults()
                self.sectionPicker.reloadAllComponents()
                print("Section deleted", terminator: "")
                if self.indexRow > 0 {
                    self.indexRow! = self.indexRow! - 1
                }
                print(self.indexRow, terminator: "")
                if self.indexRow! == 0 {
                    self.sectionNameLabel.text = ""
                }
                //            self.navigationController?.popToRootViewControllerAnimated(true)
            }))
        
            refreshAlert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction) in
            
//            refreshAlert .dismissViewControllerAnimated(true, completion: nil)
            print("Section not deleted", terminator: "")
            
            
            }))
        
        
            present(refreshAlert, animated: true, completion: nil)
        
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sections.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sectionNameLabel.text = sections[row].heading
        indexRow = row
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sections[row].heading
    }


    override func viewDidAppear(_ animated: Bool) {
        if sections.count > 0 {
            sectionNameLabel.text = sections[0].heading
            indexRow = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sectionPicker.delegate = self
        self.sectionPicker.dataSource = self
        
    }
    
    func displayAlert (_ txtTitle: String, txtMessage: String, txtButtonTitle: String) {
        let alertController = UIAlertController(title: txtTitle, message: txtMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: txtButtonTitle, style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }

    
}
