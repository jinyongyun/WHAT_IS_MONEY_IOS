//
//  RecordTableViewCell.swift
//  WHAT_IS_MONEY
//
//  Created by 이예나 on 1/10/23.
//

import UIKit

protocol ArrowClickedDelegate {
    func presentToRecordDetailViewController()
}
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
    @IBOutlet weak var arrowButton: UIButton!
    
    //public var delegate : ArrowClickedDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.arrowButton.addTarget(self, action: #selector(arrowClicked), for: .touchUpInside)
//    }
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }

    @objc func arrowClicked() {
        print("clicked")

        //self.delegate?.presentToRecordDetailViewController()

//        let vc = RecordDetailViewController(nibName: "RecordDetailViewController", bundle: nil)
//        vc.modalPresentationStyle = .fullScreen
        //self.present(vc, animated: true, completion: nil)
    }
}
