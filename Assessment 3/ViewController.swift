//
//  ViewController.swift
//  Assessment 3
//
//  Created by Habib Zarrin Chang Fard on 29/08/2017.
//  Copyright © 2017 Habib Zahrrin Chang Fard. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    
//    var owners : [String] = ["habib","ali", "hassan", "hussein","mahmod", "abod","jasem","hamdan","mihed","ahmad"]
//    
    var owners : [Owner] = []
    let request = NSFetchRequest<Owner>(entityName: "Owner")
    
    @IBOutlet weak var newOwnerTextField: UITextField!
    
    @IBAction func addOwnerButton(_ sender: Any) {
        
        guard let inputName = newOwnerTextField.text else {return}
        if inputName == "" {
            return
        }
        guard let desc = NSEntityDescription.entity(forEntityName: "Owner", in: DataController.moc) else {return}
        let newOwner = Owner(entity: desc, insertInto: DataController.moc)
        newOwner.name = inputName
        DataController.saveContext()
        dismiss(animated: true, completion: nil)
        
        loadData()
        
    }
    
    @IBOutlet weak var tableVIew: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
       
        
        let ownerNameAlphabetSort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [ownerNameAlphabetSort]
        do {
            let data = try DataController.moc.fetch(request)
            owners = data
            tableVIew.reloadData()
        } catch {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.dataSource = self
        tableVIew.delegate = self
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return owners.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let own = owners[indexPath.row]
        cell.textLabel?.text = own.name
      
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOwner = owners[indexPath.row]
        
        //dest.own
        
        //move to next ViewController
        //1. storyBoard
        //2. Instantiate target View Controller(withIdentifier)
        //3. Setup
        //4. Present
        
        
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let targetVC = mainStoryBoard.instantiateViewController(withIdentifier: "PropertiesTableViewController") as? PropertiesTableViewController else { return }
        targetVC.selectowner = selectedOwner
        
        navigationController?.pushViewController(targetVC, animated: true)
        
        
    }
}
