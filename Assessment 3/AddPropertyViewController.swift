//
//  AddPropertyViewController.swift
//  Assessment 3
//
//  Created by Habib Zarrin Chang Fard on 29/08/2017.
//  Copyright © 2017 Habib Zahrrin Chang Fard. All rights reserved.
//

import UIKit
import CoreData

class AddPropertyViewController: UIViewController {


    var nvColor: UIColor?
    var selectedOwner: Owner?
    var selectedProperty: Property?
    
    
    @IBOutlet weak var propertyNameTextField: UITextField!
    
    
    @IBOutlet weak var priceTextField: UITextField!
    
    
    @IBOutlet weak var locationTextField: UITextField!
    
    
    @IBAction func doneButton(_ sender: Any) {
        
        
        guard let property = propertyNameTextField.text else {return}
        if property == "" {
            return
        }
        
        guard let location = locationTextField.text else {return}
        if location == "" {
            return
        }
        
        guard let price = priceTextField.text
            else {return}
        if price == ""{
            return
        }
        guard let pri = Int16(price) else {
            return
        }
        
        if selectedProperty == nil {

        
        guard let desc = NSEntityDescription.entity(forEntityName: "Property", in: DataController.moc) else {return}
        let newProperty = Property(entity: desc, insertInto: DataController.moc)
        newProperty.name = property
        newProperty.location = location
        newProperty.price = pri
        newProperty.owner = selectedOwner?.name
       
        DataController.saveContext()
        
       
        DataController.saveContext()
        
        //dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
            
        } else {
            selectedProperty?.name = property
            selectedProperty?.name = property
            selectedProperty?.location = location
            selectedProperty?.price = pri
            DataController.saveContext()
            
            navigationController?.popViewController(animated: true)
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        propertyNameTextField.text = selectedProperty?.name
        
        locationTextField.text = selectedProperty?.location
        if let price = selectedProperty?.price {
            priceTextField.text = "\(price)"
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        DataController.saveContext()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
          self.navigationController?.navigationBar.barTintColor = nvColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
