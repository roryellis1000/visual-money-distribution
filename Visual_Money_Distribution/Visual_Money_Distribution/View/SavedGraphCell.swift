//
//  TableViewCell.swift
//  Visual_Money_Distribution
//
//  Created by Rory Ellis on 20/04/2022.
//

import UIKit

class SavedGraphCell: UITableViewCell {

    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backGroundView.layer.cornerRadius = 5
        whiteView.layer.cornerRadius = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
