//
//  GraphViewController.swift
//  Visual_Money_Distribution
//
//  Created by Rory Ellis on 17/04/2022.
//

import UIKit
import RealmSwift

class GraphViewController: UIViewController {
    
    let realm = try! Realm()
    let brain = Brain()
    
    @IBOutlet weak var stocksView: UIView!
    @IBOutlet weak var assetsView: UIView!
    @IBOutlet weak var cashView: UIView!
    @IBOutlet weak var highestLabel: UILabel!
    @IBOutlet weak var halfWayLabel: UILabel!
    @IBOutlet weak var zeroLabel: UILabel!
    @IBOutlet weak var axisView: UIView!
    @IBOutlet weak var unitsLabel: UILabel!
    
    var stockValue: Double = 0.0
    var assetValue: Double = 0.0
    var cashValue: Double = 0.0
    var stockProportion: Double = 0.0 {
        didSet {
            brain.animateUp(bar: stocksView, proportion: stockProportion)
        }
    }
    var assetProportion: Double = 0.0 {
        didSet {
            brain.animateUp(bar: assetsView, proportion: assetProportion)
        }
    }
    var cashProportion: Double = 0.0 {
        didSet {
            brain.animateUp(bar: cashView, proportion: cashProportion)
        }
    }
    var highestValue: Double? = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getProportion()
        checkUnits()
        
    }
    
    func getProportion() {
        let categories = brain.getProportion(stock: stockValue, asset: assetValue, cash: cashValue, multiplier: 400)
        stockProportion = categories[0]
        assetProportion = categories[1]
        cashProportion = categories[2]
    }
    
    func checkUnits() {
                
        let results = brain.checkUnits(stock: stockValue, asset: assetValue, cash: cashValue)
        
        unitsLabel.text = (results[1] as! String)
        highestLabel.text = String(format: "£%.\(results[0])f", results[2] as! CVarArg)
        halfWayLabel.text = String(format: "£%.\(results[0])f", results[3] as! CVarArg)
        
    }

    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy   hh:mm:ss"
        let date = dateFormatter.string(from: Date())
        
        let newSavedGraph = GraphModel()
        newSavedGraph.stockValue = stockValue
        newSavedGraph.assetValue = assetValue
        newSavedGraph.cashValue = cashValue
        newSavedGraph.graphDate = date
        save(graph: newSavedGraph)
        
    }
    
    func save(graph: GraphModel) {
        do {
            try realm.write {
                realm.add(graph)
            }
        } catch {
            print(error)
        }
    }
}
