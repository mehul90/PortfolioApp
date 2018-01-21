//
//  InstrumentCellTableViewCell.swift
//  PortfolioApp
//
//  Created by Mehul Parmar on 1/20/18.
//  Copyright © 2018 mp. All rights reserved.
//

import UIKit

class InstrumentCellTableViewCell: UITableViewCell {

    @IBOutlet weak var instrumentCode: UILabel!
    @IBOutlet weak var instrumentName: UILabel!
    @IBOutlet weak var instrumentValue: UILabel!
    @IBOutlet weak var priceChange: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var reuseIdentifier: String? {
        return "reuseIdentifier"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
