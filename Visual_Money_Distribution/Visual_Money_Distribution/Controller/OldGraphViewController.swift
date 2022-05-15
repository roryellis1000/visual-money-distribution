//
//  OldGraphViewController.swift
//  Visual_Money_Distribution
//
//  Created by Rory Ellis on 19/04/2022.
//

import UIKit

class OldGraphViewController: UIViewController {
    
    @IBOutlet weak var highestLabel: UILabel!
    @IBOutlet weak var halfWayLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cashValueLabel: UILabel!
    @IBOutlet weak var assetValueLabel: UILabel!
    @IBOutlet weak var stockValueLabel: UILabel!
    @IBOutlet weak var stocksView: UIView!
    @IBOutlet weak var cashView: UIView!
    @IBOutlet weak var assetsView: UIView!
    
    let brain = Brain()
    var selectedGraph: GraphModel?
    var stockProportion: Double = 0.0
    var assetProportion: Double = 0.0
    var cashProportion: Double = 0.0
    var highestValue: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getProportion()
        displayUI()
        checkUnits()
        
    }
    
    func getProportion() {
        let categories = brain.getProportion(stock: selectedGraph!.stockValue, asset: selectedGraph!.assetValue, cash: selectedGraph!.cashValue, multiplier: 300)
        stockProportion = categories[0]
        assetProportion = categories[1]
        cashProportion = categories[2]
    }
    
    func displayUI() {
        stocksView.frame = CGRect(origin: CGPoint(x: 120, y: 545 - stockProportion), size: CGSize(width: 40, height: stockProportion))
        assetsView.frame = CGRect(origin: CGPoint(x: 180, y: 545 - assetProportion), size: CGSize(width: 40, height: assetProportion))
        cashView.frame = CGRect(origin: CGPoint(x: 240, y: 545 - cashProportion), size: CGSize(width: 40, height: cashProportion))
        stocksView.layer.cornerRadius = 2
        assetsView.layer.cornerRadius = 2
        cashView.layer.cornerRadius = 2
        stockValueLabel.text = "£\(Int(selectedGraph!.stockValue)) in stocks"
        assetValueLabel.text = "£\(Int(selectedGraph!.assetValue)) in assets"
        cashValueLabel.text = "£\(Int(selectedGraph!.cashValue)) in cash"
        dateLabel.text = selectedGraph!.graphDate
    }
    
    func checkUnits() {
        
        let results = brain.checkUnits(stock: selectedGraph!.stockValue, asset: selectedGraph!.assetValue, cash: selectedGraph!.cashValue)
        
        unitsLabel.text = (results[1] as! String)
        highestLabel.text = String(format: "£%.\(results[0])f", results[2] as! CVarArg)
        halfWayLabel.text = String(format: "£%.\(results[0])f", results[3] as! CVarArg)
        
    }
    
}
