//
//  TableViewCell4.swift
//  TestApp
//
//  Created by Андрей Ушаков on 03.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import UIKit

class SelectDurationTableViewCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
