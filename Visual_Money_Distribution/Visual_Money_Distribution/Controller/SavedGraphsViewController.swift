//
//  SavedGraphsTableViewController.swift
//  Visual_Money_Distribution
//
//  Created by Rory Ellis on 19/04/2022.
//

import UIKit
import RealmSwift

class SavedGraphsViewController: UITableViewController {

    let realm = try! Realm()

    var savedGraphs: Results<GraphModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGraphs()
        tableView.register(UINib(nibName: "SavedGraphCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.rowHeight = 52
        tableView.separatorStyle = .none
    }

    func loadGraphs() {
        savedGraphs = realm.objects(GraphModel.self)
    }
    
    // MARK: - Table view data source methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedGraphs?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let colourArray = [UIColor.systemOrange, UIColor.systemIndigo, UIColor.systemMint]
        let colour = colourArray.randomElement()!
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! SavedGraphCell
        cell.dateLabel.text = savedGraphs?[indexPath.row].graphDate
        cell.dateLabel.textColor = colour
        cell.backGroundView.backgroundColor = colour
        
        
        return cell
        
    }
    
    //MARK: Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSpecificGraph", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                try realm.write({
                    realm.delete(savedGraphs![indexPath.row])
                })
            } catch {
                print(error)
            }
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let destination = segue.destination as! OldGraphViewController
            destination.selectedGraph = savedGraphs?[indexPath.row]
        }
        
    }
    
}
