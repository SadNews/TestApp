//
//  TableViewCell2.swift
//  TestApp
//
//  Created by Андрей Ушаков on 03.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import UIKit

class ChooseInterestsTableViewCell: UITableViewCell {

    @IBOutlet weak var interest: UILabel!
    @IBOutlet weak var chooseInterestLabes: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}