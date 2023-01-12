//
//  RecordViewController.swift
//  WHAT_IS_MONEY
//
//  Created by 이예나 on 1/10/23.
//

import UIKit

struct recordData {
    var date = String()
    var records = [recordforaday]()
    
}
struct recordforaday {
    var sort = String()
    var category = String()
    var price = String()
}
class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var RecordTableView: UITableView!
    
   
    var recordViewData = [recordData(date: "2023.01.06", records: [recordforaday(sort: "지출", category: "쇼핑", price: "37,720"),recordforaday(sort: "지출", category: "교통", price: "17,720"),recordforaday(sort: "저축", category: "용돈", price: "15,020")]),recordData(date: "2023.01.07", records: [recordforaday(sort: "지출", category: "쇼핑", price: "37,720"),recordforaday(sort: "지출", category: "식비", price: "17,720"),recordforaday(sort: "저축", category: "용돈", price: "15,020")]),recordData(date: "2023.01.08", records: [recordforaday(sort: "지출", category: "쇼핑", price: "37,720"),recordforaday(sort: "지출", category: "식비", price: "17,720"),recordforaday(sort: "저축", category: "용돈", price: "15,020")]),recordData(date: "2023.01.10", records: [recordforaday(sort: "지출", category: "쇼핑", price: "37,720"),recordforaday(sort: "지출", category: "식비", price: "17,720"),recordforaday(sort: "저축", category: "용돈", price: "15,020")])]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "RecordTableViewCell", bundle: nil)
        RecordTableView.register(nib, forCellReuseIdentifier: "RecordTableViewCell")
        RecordTableView.delegate = self
        RecordTableView.dataSource = self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as! RecordTableViewCell
        
        cell.DateCell.text = recordViewData[indexPath.row].date
        cell.firstSortLabel.text = recordViewData[indexPath.row].records[0].sort
        cell.firstCategoryLabel.text = recordViewData[indexPath.row].records[0].category
        cell.firstPriceLabel.text = recordViewData[indexPath.row].records[0].price
        cell.secondSortLabel.text = recordViewData[indexPath.row].records[1].sort
        cell.secondCategoryLabel.text = recordViewData[indexPath.row].records[1].category
        cell.secondPriceLabel.text = recordViewData[indexPath.row].records[1].price
        cell.thirdSortLabel.text = recordViewData[indexPath.row].records[2].sort
        cell.thirdCategoryLabel.text = recordViewData[indexPath.row].records[2].category
        cell.thirdPriceLabel.text = recordViewData[indexPath.row].records[2].price
        return cell
    }
    
    

    
    
}
