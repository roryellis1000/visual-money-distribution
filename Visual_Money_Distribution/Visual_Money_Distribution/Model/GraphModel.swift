//
//  GraphModel.swift
//  Visual_Money_Distribution
//
//  Created by Rory Ellis on 19/04/2022.
//

import Foundation
import RealmSwift

class GraphModel: Object {
    
    @objc dynamic var stockValue: Double = 0.0
    @objc dynamic var assetValue: Double = 0.0
    @objc dynamic var cashValue: Double = 0.0
    @objc dynamic var graphDate: String = ""
    
}
