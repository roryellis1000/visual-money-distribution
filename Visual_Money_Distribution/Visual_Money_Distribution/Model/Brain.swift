//
//  Brain.swift
//  Visual_Money_Distribution
//
//  Created by Rory Ellis on 20/04/2022.
//

import UIKit

struct Brain {
    
    func getProportion(stock: Double, asset: Double, cash: Double, multiplier: Double) -> [Double] {
        
        var categories = [stock, asset, cash]
        if let highestValue = categories.max() {
            let stockProportion = (stock / highestValue) * multiplier
            let assetProportion = (asset / highestValue) * multiplier
            let cashProportion = (cash / highestValue) * multiplier
            categories.removeAll()
            categories.append(stockProportion)
            categories.append(assetProportion)
            categories.append(cashProportion)
        }
        return categories
    }
    
    func checkUnits(stock: Double, asset: Double, cash: Double) -> [Any] {
        
        let array = [stock, asset, cash]
        let highestValue = array.max()!
        let highestInHundreds = highestValue / 100
        let halfHundreds = highestInHundreds / 2
        let highestInThousands = highestValue / 1000
        let halfThousands = highestInThousands / 2
        let highestInMillions = highestValue / 1000000
        let halfMillions = highestInMillions / 2
        
        if stock < 1000 && asset < 1000 && cash < 1000 {
            return [halfHundreds.decimalPlaces(), "In hundreds", highestInHundreds, halfHundreds]
        } else if stock > 1000000 || asset > 1000000 || cash > 1000000 {
            return [halfMillions.decimalPlaces(), "In millions", highestInMillions, halfMillions]
        } else {
            if stock < 1000 || asset < 1000 || cash < 1000 {
                return [halfThousands.decimalPlaces(), "In thousands", highestInThousands, halfThousands]
            } else {
                return [halfThousands.decimalPlaces(), "In thousands", highestInThousands, halfThousands]
            }
        }
        
    }
    
    //MARK: Animation methods
    
    func animateUp(bar: UIView, proportion: Double) {
        
        var maxHeight = proportion
        bar.frame.size.height = 0
        bar.frame.origin.y = 600
        bar.layer.cornerRadius = 3
        
        Timer.scheduledTimer(withTimeInterval: 0.0075, repeats: true) { Timer in
            if maxHeight > 0 {
                bar.frame.origin.y -= 1
                bar.frame.size.height += 1
                maxHeight -= 1
            } else {
                Timer.invalidate()
            }
            
        }
        
    }
    
    func animateAcross(bar1: UIView, bar2: UIView, bar3: UIView) {
        
        var maxWidth = 40
        bar1.frame.size.width = 0
        bar2.frame.size.width = 0
        bar3.frame.size.width = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.015, repeats: true) { timer in
            if maxWidth > 0 {
                bar1.frame.size.width += 1
                maxWidth -= 1
            } else {
                timer.invalidate()
                maxWidth = 40
                Timer.scheduledTimer(withTimeInterval: 0.015, repeats: true) { timer1 in
                    if maxWidth > 0 {
                        bar2.frame.size.width += 1
                        maxWidth -= 1
                    } else {
                        timer1.invalidate()
                        maxWidth = 40
                        Timer.scheduledTimer(withTimeInterval: 0.015, repeats: true) { timer2 in
                            if maxWidth > 0 {
                                bar3.frame.size.width += 1
                                maxWidth -= 1
                            } else {
                                timer2.invalidate()
                            }
                        }
                    }
                }
            }
        }
    }
    
}

//MARK: Extension of type Double

extension Double {
    
    func decimalPlaces() -> Int {
        let times10 = self * 10
        if self == self.rounded() {
            return 0
        } else {
            if times10 == times10.rounded() {
                return 1
            } else {
                return 2
            }
        }
        
    }
    
}

//MARK: Extension of type String

extension String {
    
    var isNumeric: Bool {
        guard self.count > 0 else {
            return false
        }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
}
