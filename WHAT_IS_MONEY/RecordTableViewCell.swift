//
//  RecordTableViewCell.swift
//  WHAT_IS_MONEY
//
//  Created by 이예나 on 1/10/23.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var DateCell: UILabel!
    @IBOutlet weak var firstSortLabel: UILabel!
    @IBOutlet weak var firstCategoryLabel: UILabel!
    @IBOutlet weak var firstPriceLabel: UILabel!
    @IBOutlet weak var secondSortLabel: UILabel!
    @IBOutlet weak var secondCategoryLabel: UILabel!
    @IBOutlet weak var secondPriceLabel: UILabel!
    @IBOutlet weak var thirdSortLabel: UILabel!
    @IBOutlet weak var thirdCategoryLabel: UILabel!
    @IBOutlet weak var thirdPriceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func arrowClicked(_ sender: UIButton) {
        print("clicked")
    }
}
