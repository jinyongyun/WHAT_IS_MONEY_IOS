import UIKit
import Gifu

class ConsumeViewController: UIViewController {
    
    @IBOutlet weak var gifImageView: GIFImageView!
    
    @IBOutlet weak var WolfgifImageView: GIFImageView!
    
    @IBOutlet weak var crygifImageView: GIFImageView!
    
    @IBOutlet weak var goalImageView: UIImageView!
    
    
    var recordDate: String?
    var goalIdx: Int?
    var goaldetail: goalresult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGoal()
        print("늑대2\n\n\n\n", goalIdx as Any)
        gifImageView.animate(withGIFNamed: "늑대배경")
        WolfgifImageView.animate(withGIFNamed: "늑대애니메이션")
        crygifImageView.animate(withGIFNamed: "우는돼지")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { // [6초 후에 동작 실시]
            guard let recordViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecordViewController") as? RecordViewController else {return}
            let goalIdx = self.goalIdx
           recordViewController.goalIdx = goalIdx
            print(recordViewController.goalIdx as Any)
            self.navigationController?.pushViewController(recordViewController, animated: true)
              }
        
        
    }
    
    func getGoal(){
        let userIdx = UserDefaults.standard.integer(forKey: "userIdx")
        if let url = URL(string: "https://www.pigmoney.xyz/goal/getGoal/\(goalIdx!)/\(userIdx)"){
            
            var request = URLRequest.init(url: url)
            
            request.httpMethod = "GET"
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue( UserDefaults.standard.string(forKey: "accessToken") ?? "0", forHTTPHeaderField: "X-ACCESS-TOKEN")
            
            DispatchQueue.global().async {
                do {
                    URLSession.shared.dataTask(with: request){ [self] (data, response, error) in
                        
                        guard let data = data else {
                            print("Error: Did not receive data")
                            return
                        }
                        
                        print("getgoall:" ,String(data: data, encoding: .utf8)!)
                        
                        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                            print("Error: HTTP request failed")
                            return
                        }
                        
                        let decoder = JSONDecoder()
                        if let json = try? decoder.decode(goalresponse.self, from: data) {
                            self.goaldetail =  json.result
                            print(goaldetail as Any)
                            DispatchQueue.main.async { [self] in
                                let data = Data(base64Encoded: self.goaldetail?.image ?? "알수없음", options: .ignoreUnknownCharacters) ?? Data()
                                    let decodeImg = UIImage(data: data)
                                goalImageView.image = decodeImg?.resized(toWidth: 170)
                            }
                            print("goaldetail!!!", goaldetail as Any)
                        }
                        
                    }.resume() //URLSession - end
                    
                }
            }
        }
    }
    
    @IBAction func TapSkipButton(_ sender: UIButton) {
        guard let recordViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecordViewController") as? RecordViewController else {return}
        let goalIdx = self.goalIdx
       recordViewController.goalIdx = goalIdx
        print(recordViewController.goalIdx as Any)
        self.navigationController?.pushViewController(recordViewController, animated: true)
        
    }
    
}
