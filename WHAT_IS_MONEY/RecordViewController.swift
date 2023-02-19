//
//  RecordViewController.swift
//  WHAT_IS_MONEY
//
//  Created by 이예나 on 1/10/23.
//

import UIKit

/*struct recordData {
    var date = String()
    var records = [recordforaday]()
    
}
struct recordforaday {
    var sort = String()
    var category = String()
    var price = String()
}*/


struct recordresponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [resultone]
    
}

struct resultone: Codable {
    
    let records: [records]
    let date: String
}

struct records: Codable {
    let recordIdx: Int
    let type: Int
    let category: String
    let amount: Int
    
}



class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var goalIdx: Int?
    var type: Bool = false
    

    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var RecordTableView: UITableView!

    var recordViewData : [resultone] = []
    
   
    override func viewWillAppear(_ animated: Bool) {
        TokenClass.handlingToken()
        
        self.loadrecordlist()
        RecordTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadrecordlist()
        let recent = UIAction(title: "최신순", handler: { _ in
            self.type = false
            self.loadrecordlist()
            
        })
        let old = UIAction(title: "오랜순", handler: { _ in
            self.type = true
            self.loadrecordlist()
        })
        typeButton.menu = UIMenu(title: "title입니다",
                                 identifier: nil,
                                 options: .displayInline,
                                 children: [recent, old])
        
        let nib = UINib(nibName: "RecordTableViewCell", bundle: nil)
        RecordTableView.register(nib, forCellReuseIdentifier: "RecordTableViewCell")
        RecordTableView.delegate = self
        RecordTableView.dataSource = self
        
    }
    
    
    func loadrecordlist(){
       let useridx = UserDefaults.standard.integer(forKey: "userIdx")
        if let url = URL(string: "https://www.pigmoney.xyz/records/\(useridx)/\(goalIdx!)?type=\(type)"){
            
            var request = URLRequest.init(url: url)
            
            request.httpMethod = "GET"
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue( UserDefaults.standard.string(forKey: "accessToken") ?? "0", forHTTPHeaderField: "X-ACCESS-TOKEN")
            
            DispatchQueue.global().async {
                do {
                    
                    URLSession.shared.dataTask(with: request){ [self] (data, response, error) in
                        
                        guard let data = data else {
                            print("Error: Did not receive data")
                            return}
                        
                 
                        
                        
                    guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return}

                        let decoder = JSONDecoder()
                        if let json = try? decoder.decode(recordresponse.self, from: data) {
                            self.recordViewData =  json.result
                            DispatchQueue.main.async {
                                self.RecordTableView.reloadData()
                            }
                        }
                        
                    }.resume() //URLSession - end
                    
                }
            }
            
            
        }
        
    }
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as? RecordDetailViewController
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as! RecordTableViewCell
        let recorddata = self.recordViewData[indexPath.row]
        cell.DateCell.text = recorddata.date
        
        if recorddata.records.count == 3 {
            if recorddata.records[0].type == 0 {
                cell.firstSortLabel.text = "저축"
                cell.firstSortLabel.textColor = UIColor(red: 0.3255, green: 0.4667, blue: 0.9647, alpha: 1.0)
                cell.firstPriceLabel.textColor = UIColor(red: 0.3255, green: 0.4667, blue: 0.9647, alpha: 1.0)
            } else {
                cell.firstSortLabel.text = "지출"
                cell.firstSortLabel.textColor = UIColor(red: 0.92, green: 0.39, blue: 0.27, alpha: 1.00)
                cell.firstPriceLabel.textColor = UIColor(red: 0.92, green: 0.39, blue: 0.27, alpha: 1.00)
               
            }
            cell.firstCategoryLabel.text = recorddata.records[0].category
            cell.firstPriceLabel.text = String(recorddata.records[0].amount)
            
            if recorddata.records[1].type == 0 {
                cell.secondSortLabel.text = "저축"
                cell.secondSortLabel.textColor = UIColor(red: 0.3255, green: 0.4667, blue: 0.9647, alpha: 1.0)
                cell.secondPriceLabel.textColor = UIColor(red: 0.3255, green: 0.4667, blue: 0.9647, alpha: 1.0)
            } else {
                cell.secondSortLabel.text = "지출"
                cell.secondSortLabel.textColor = UIColor(red: 0.92, green: 0.39, blue: 0.27, alpha: 1.00)
                cell.secondPriceLabel.textColor = UIColor(red: 0.92, green: 0.39, blue: 0.27, alpha: 1.00)
                
            }
            cell.secondCategoryLabel.text = recorddata.records[1].category
            cell.secondPriceLabel.text = String(recorddata.records[1].amount)
            
            if recorddata.records[2].type == 0 {
                cell.thirdSortLabel.text = "저축"
                cell.thirdSortLabel.textColor = UIColor(red: 0.3255, green: 0.4667, blue: 0.9647, alpha: 1.0)
                cell.thirdPriceLabel.textColor = UIColor(red: 0.3255, green: 0.4667, blue: 0.9647, alpha: 1.0)
            } else {
                cell.thirdSortLabel.text = "지출"
                cell.thirdSortLabel.textColor = UIColor(red: 0.92, green: 0.39, blue: 0.27, alpha: 1.00)
                cell.thirdPriceLabel.textColor = UIColor(red: 0.92, green: 0.39, blue: 0.27, alpha: 1.00)
                
            }
            cell.thirdCategoryLabel.text = recorddata.records[2].category
            cell.thirdPriceLabel.text = String(recorddata.records[2].amount)
            
         
            
            return cell
            
        }
        
        else if recorddata.records.count == 2 {
            if recorddata.records[0].type == 0 {
                cell.firstSortLabel.text = "저축"
                cell.firstSortLabel.textColor = UIColor(red: 0.3255, green: 0.4667, blue: 0.9647, alpha: 1.0)
                cell.firstPriceLabel.textColor = UIColor(red: 0.3255, green: 0.4667, blue: 0.9647, alpha: 1.0)
            } else {
                cell.firstSortLabel.text = "지출"
                cell.firstSortLabel.textColor =  UIColor(red: 0.92, green: 0.39, blue: 0.27, alpha: 1.00)
                cell.firstPriceLabel.textColor =  UIColor(red: 0.92, green: 0.39, blue: 0.27, alpha: 1.00)
            }
            cell.firstCategoryLabel.text = recorddata.records[0].category
            cell.firstPriceLabel.text = String(recorddata.records[0].amount)
            if recorddata.records[1].type == 0 {
                cell.secondSortLabel.text = "저축"
                cell.secondSortLabel.textColor = UIColor(red: 0.3255, green: 0.4667, blue: 0.9647, alpha: 1.0)
                cell.secondPriceLabel.textColor = UIColor(red: 0.3255, green: 0.4667, blue: 0.9647, alpha: 1.0)
            } else {
                cell.secondSortLabel.text = "지출"
                cell.secondSortLabel.textColor = UIColor(red: 0.92, green: 0.39, blue: 0.27, alpha: 1.00)
                cell.secondPriceLabel.textColor = UIColor(red: 0.92, green: 0.39, blue: 0.27, alpha: 1.00)
                
                
            }
            cell.secondCategoryLabel.text = recorddata.records[1].category
            cell.secondPriceLabel.text = String(recorddata.records[1].amount)
            
            
            
                cell.thirdSortLabel.isHidden = true
                cell.thirdCategoryLabel.isHidden = true
                cell.thirdPriceLabel.isHidden = true
            
            return cell
            
        }
        
       else if recorddata.records.count == 1 {
            if recorddata.records[0].type == 0 {
                cell.firstSortLabel.text = "저축"
                cell.firstSortLabel.textColor = UIColor(red: 0.3255, green: 0.4667, blue: 0.9647, alpha: 1.0)
                cell.firstPriceLabel.textColor = UIColor(red: 0.3255, green: 0.4667, blue: 0.9647, alpha: 1.0)
            } else {
                cell.firstSortLabel.text = "지출"
                cell.firstSortLabel.textColor = UIColor(red: 0.92, green: 0.39, blue: 0.27, alpha: 1.00)
                cell.firstPriceLabel.textColor = UIColor(red: 0.92, green: 0.39, blue: 0.27, alpha: 1.00)
            }
            cell.firstCategoryLabel.text = recorddata.records[0].category
            cell.firstPriceLabel.text = String(recorddata.records[0].amount)
           

           
                   cell.secondSortLabel.isHidden = true
                cell.secondCategoryLabel.isHidden = true
                cell.secondPriceLabel.isHidden = true
                
                
                cell.thirdSortLabel.isHidden = true
                cell.thirdCategoryLabel.isHidden = true
                cell.thirdPriceLabel.isHidden = true
           
            
            
            return cell
            
        }
        
       else if recorddata.records.count == 0 {
            
               
           
            return cell
            
        }
        
        else { return cell }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            
         
        guard let recordDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecordDetailViewController") as? RecordDetailViewController else {return}
        let goalIdx = self.goalIdx
       recordDetailViewController.goalIdx = goalIdx
        recordDetailViewController.recordDate = recordViewData[indexPath.row].date
        self.navigationController?.pushViewController(recordDetailViewController, animated: true)

        }
   
    

    
    
}

