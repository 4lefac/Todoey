//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Forlefac Fontem on 6/25/18.
//  Copyright © 2018 Forlefac Fontem. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    var categoryArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        tableView.rowHeight = 80

    }
     //MARK: - Table View Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ??  "No Categories added yet"
 
        return cell
    }
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add A New Category", message: "", preferredStyle: .alert)
        
        //Basically the action of hitting submit.
        let action = UIAlertAction(title: "submit", style: .default) { (action) in
            let textField = alert.textFields![0] as UITextField
            
            //adding the users new category to core data
            let category = Category()
            category.name = textField.text!
            self.save(category: category)
            self.loadCategories()
        }
        
        //adding a text field for the UI alert
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Category Name"
        }
        
        //actino properties to the alert
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
      //MARK: - Data Manipulation Methods
    
    func save(category: Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving the category \(error)")
        }
    }
    
    func loadCategories() {
        
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
        
        if let categoryForDeletion = self.categoryArray?[indexPath.row]{
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
}
