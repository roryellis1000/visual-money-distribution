//
//  ViewController.swift
//  Visual_Money_Distribution
//
//  Created by Rory Ellis on 17/04/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var indigoView: UIView!
    @IBOutlet weak var mintView: UIView!
    
    @IBOutlet weak var savedGraphsbutton: UIButton!
    @IBOutlet weak var graphButton: UIButton!
    
    @IBOutlet weak var stockTextField: UITextField!
    @IBOutlet weak var assetsTextField: UITextField!
    @IBOutlet weak var cashTextField: UITextField!
    
    var stockValue: Double = 0.0
    var assetsValue: Double = 0.0
    var cashValue: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphButton.layer.cornerRadius = 10
        savedGraphsbutton.layer.cornerRadius = 10
        stockTextField.delegate = self
        assetsTextField.delegate = self
        cashTextField.delegate = self
        orangeView.layer.cornerRadius = 10
        indigoView.layer.cornerRadius = 10
        mintView.layer.cornerRadius = 10
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    @IBAction func showGraphPressed(_ sender: UIButton) {
        
        let stock = stockTextField.text!
        let asset = assetsTextField.text!
        let cash = cashTextField.text!
        
        if stock.isNumeric && asset.isNumeric && cash.isNumeric {
            stockValue = Double(stock)!
            assetsValue = Double(asset)!
            cashValue = Double(cash)!
            performSegue(withIdentifier: "toGraph", sender: self)
        }
                    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toGraph" {
            let destination = segue.destination as! GraphViewController
            destination.stockValue = stockValue
            destination.assetValue = assetsValue
            destination.cashValue = cashValue
        }
        
    }
    
    @IBAction func viewSavedPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toSavedGraphs", sender: self)
    }
    
}



