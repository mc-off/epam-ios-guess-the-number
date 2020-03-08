//
//  HistoryTableViewCell.swift
//  epam-ios-guess-the-number
//
//  Created by Артем Маков on 08/03/2020.
//  Copyright © 2020 Артем Маков. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var imagineLabel: UILabel!
    @IBOutlet weak var numberHint: UILabel!
    @IBOutlet weak var countHint: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}
}
