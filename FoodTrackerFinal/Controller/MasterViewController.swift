//
//  ViewController.swift
//  FoodTrackerFinal
//
//  Created by Vu Ngoc Cong on 4/13/18.
//  Copyright © 2018 Vu Ngoc Cong. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var filtered: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filtered = DataServices.shared.meals
        tableView.reloadData()
    }
    
}


extension MasterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MealTableViewCell
        let meal = filtered[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            if searchBar.text != "" {
                if let index = DataServices.shared.meals.index(of: filtered[indexPath.row]) {
                    print(index)
                    DataServices.shared.meals.remove(at: index)
                    filtered.remove(at: indexPath.row)
                    tableView.reloadData()
                }
            } else {
                DataServices.shared.meals.remove(at: indexPath.row)
                filtered = DataServices.shared.meals
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .insert:
            print("insert")
        case .none:
            print("none")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let index = DataServices.shared.meals.index(of: filtered[indexPath.row]) {
                    detailViewController.index = index
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = searchText.isEmpty ? DataServices.shared.meals : DataServices.shared.meals.filter({ (text: Meal) -> Bool in
            return text.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    
}
