//
//  TableViewCell.swift
//  TestApp
//
//  Created by Андрей Ушаков on 31.07.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import UIKit

final class AddOrderTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
