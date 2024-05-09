//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Aleksandra Sobot on 12.8.22..
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {
 
        
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
     
    guard let navBar = navigationController?.navigationBar else {
    fatalError("Navigation controller does not exist")
    }
     
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor(hexString:"1D9BF6")
    appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(contrastingBlackOrWhiteColorOn: appearance.backgroundColor!, isFlat: true)]
    navBar.standardAppearance = appearance;
    navBar.scrollEdgeAppearance = navBar.standardAppearance
     
     
    }

    
    
    
    //MARK: - TableView Datasource Methods
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let categoryName = categories?[indexPath.row].name ?? "No categories added yet"

        var content = cell.defaultContentConfiguration()
             
             content.text = categoryName
             
             cell.backgroundColor = UIColor(hexString: (categories?[indexPath.row].categoryColor) ?? "1D9BF6")
         
             content.textProperties.color = UIColor(contrastingBlackOrWhiteColorOn: cell.backgroundColor!, isFlat: true)
       
             cell.contentConfiguration = content
     
         return cell
         
     }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    

    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategory(){
        
        categories = realm.objects(Category.self)
    
        tableView.reloadData()
    }
    
    //MARK: - Delete Data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryForDeletion = self.categories?[indexPath.row] {

            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
            }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
        
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
        
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.categoryColor = UIColor.randomFlat().hexValue()
            
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
   
    }
    
}
