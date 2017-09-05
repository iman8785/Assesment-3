//
//  PropertiesTableViewController.swift
//  Assessment 3
//
//  Created by Habib Zarrin Chang Fard on 29/08/2017.
//  Copyright © 2017 Habib Zahrrin Chang Fard. All rights reserved.
//

import UIKit
import CoreData

class PropertiesTableViewController: UIViewController {
    
    
    var nvColor: UIColor?
    var properties: [Property] = []
    var selectowner : Owner?
    let request = NSFetchRequest<Property>(entityName: "Property")
    var fetchResultController : NSFetchedResultsController<Property>!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addPropertyButton(_ sender: Any) {
        
        
        //        guard let desc = NSEntityDescription.entity(forEntityName: "Property", in: DataController.moc) else {return}
        //        let newProperty = Property(entity: desc, insertInto: DataController.moc)
        //        newProperty.owner = owner?.name
        //        DataController.saveContext()
        
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let targetVC = mainStoryBoard.instantiateViewController(withIdentifier: "AddPropertyViewController") as? AddPropertyViewController else { return }
        targetVC.selectedOwner = selectowner
        
        navigationController?.pushViewController(targetVC, animated: true)
        
    }
    
    func loadData() {
        do {
            let subjectFilter = NSPredicate(format: "owner = %@", (selectowner?.name)!)
            request.predicate = subjectFilter
            
            let data = try DataController.moc.fetch(request)
            properties = data
            tableView.reloadData()
        } catch {
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PropertiesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "property", for: indexPath)
        
        let property = properties[indexPath.row]
        
        cell.textLabel?.text = property.name
        cell.detailTextLabel?.text = "\(property.location ?? "Unknown location"), \(property.price)"
        
        return cell
        }

    }

extension PropertiesTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedProperty = properties[indexPath.row]
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destination = mainStoryBoard.instantiateViewController(withIdentifier: "AddPropertyViewController") as? AddPropertyViewController else { return }
        
        destination.selectedOwner = selectowner
        destination.selectedProperty = selectedProperty
       
        navigationController?.pushViewController(destination, animated: true)
        
    }
}


