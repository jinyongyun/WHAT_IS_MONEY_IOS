# 🐽 머니뭐니

![1](https://github.com/jinyongyun/WHAT_IS_MONEY_IOS/assets/102133961/55e6c970-c982-497f-bec8-b80f9c39f44f)| ![2 PNG](https://github.com/jinyongyun/WHAT_IS_MONEY_IOS/assets/102133961/a3242b64-592b-4e98-92ae-ee063fce2698)| ![3 PNG](https://github.com/jinyongyun/WHAT_IS_MONEY_IOS/assets/102133961/521ba961-3b76-4ce5-a2ad-d0b3278be9e5)| ![4](https://github.com/jinyongyun/WHAT_IS_MONEY_IOS/assets/102133961/69466445-b233-411c-a048-44404b3893a8)| 실제구동화면입니다!
----- | ----- | ----- | ----- | -----

## 구성 및 맡은 역할

- PM
- iOS Lead
- (기획자1, 디자이너1, 백엔드4, iOS 2)

## 개요

- 목표 금액을 설정하고, 가계부 형식으로 모은 돈을 기입한다.
- 돈이 모일수록 아기돼지들의 집을 짓는 진행도가 차오르고
- 돈을 소비하면 늑대가 나타나 집을 부순다.
- 목표 달성 증진을 위한 가계부 앱

## 개발배경.

- 목표를 달성하기 위해 가장 필요한 건 직관적인 진행도라고 생각했다. 모두의 꿈인 내집마련에 창안하여 아기돼지 삼형제와 함께 특정 목표를 달성하게 할 수 없을까 고민하다 만들게 되었다.

## 앱스토어

[‎머니뭐니](https://apps.apple.com/kr/app/머니뭐니/id1671266174)

## 구현기능

- 로그인
    - 회원가입 정보를 기반으로 로그인을 진행할 수 있다.
- 목표 목록 작성 및 수정
    - 이루고 싶은 목표 정보를 입력하여 테이블 뷰로 나타낼 수 있다. 해당 테이블 뷰에서 바로 삭제 가능
- 목표 상세 정보
    - 사용자가 입력한 단일 목표에 대한 상세 정보를 보고 수정한다.
- 직관적인 UI 제시
    - 사용자가 업로드한 목표와 관련된 사진을 아기돼지들이 만들고, 이를 진행도로 나타내어 사용자의 목표 달성을 효과적으로 돕는다. 소비 시 늑대가 등장하여 진행도를 깎아먹는다.
- 소비 차트
    - 내가 소비한 품목 대로 차트를 보여준다.
- 사용자 정보 수정
    - 회원가입 시 입력한 사용자 정보를 수정할 수 있다.

## 고민 & 구현 방법

### 첫번째 설정화면에서 하나의 뷰컨트롤러에 여러 셀을 넣으려는 부분

- 해결방법
    
       <img width="300" alt="스크린샷 2024-01-03 오전 1 12 36" src="https://github.com/jinyongyun/WHAT_IS_MONEY_IOS/assets/102133961/d8e24f04-8929-4dfa-a81b-2cfdd69cc385">

    각각을 스토리보드 상에서 서로 다른 테이블 뷰로 구성해보았지만 역시나 예상했던대로 실제 시뮬레이터 구동시 제대로 나타나지 않았다.
    
    두 번째 방법은 전부 코드로 구성하는 것이었다.
    
    각 테이블 뷰를 변수로 구성하고
    
    제약을 거는 함수를 작성한 다음
    
    제일 어려웠던 테이블 뷰가 속한 뷰 컨트롤러의 delegate 와 dataSource에 테이블 뷰에 따라 셀을 리턴해줬다.
    
    화면이 정상적으로 구동되었는데, 문제는 그 다음 발생했다.
    
    화면 전환이 정상적으로 작동하지 않았다.
    
    게다가 다음 화면으로 이동했을 때 뭐가 문제인지 마찬가지로 셀로 구현한 다음 화면이 제대로 나타나지 않았다.
    
    한참을 고민하다 이걸 굳이 셀로 만들어야하나 라는 생각이 들었다. 그냥 뷰로 구현했다.
    
    지금 생각해보면 tableViewController 자체를 상속받고 section을 이용해서 코드로 구현하면 될 것 같다.
    
    그럼 문제인 ***뷰를 클릭하면 화면 전환 시키기***는 어떻게 구현을 했을까
    
    해결책은 뷰를 눌렀을 때 뷰에 gestureRecognizer를 등록해서 이벤트를 알아챌 수 있도록 하는 것!
    
    ```swift
    class WholeSettingViewController: UIViewController {
    
        @IBOutlet weak var ProfileView: UIView!
        
        @IBOutlet weak var AlertSwitch: UISwitch!
        
        @IBOutlet weak var QuestionView: UIView!
        
        @IBOutlet weak var PrivateInfView: UIView!
        
        @IBOutlet weak var LogoutView: UIView!
        
        @IBOutlet weak var WithDrawalView: UIView!
        
        override func viewDidLoad() {
        super.viewDidLoad()
            let gesture1 = UITapGestureRecognizer(target: self, action: #selector(WholeSettingViewController.goProfileEdit(sender:)))
        self.ProfileView.addGestureRecognizer(gesture1)
            let gesture4 = UITapGestureRecognizer(target: self, action: #selector(WholeSettingViewController.goQuestion(sender:)))
            self.QuestionView.addGestureRecognizer(gesture4)
            let gesturealert1 = UITapGestureRecognizer(target: self, action: #selector(WholeSettingViewController.showSIAlert(sender:)))
            self.PrivateInfView.addGestureRecognizer(gesturealert1)
            let gesturealert2 = UITapGestureRecognizer(target: self, action: #selector(WholeSettingViewController.showLogoutAlert(sender:)))
            self.LogoutView.addGestureRecognizer(gesturealert2)
            let gesturealert3 = UITapGestureRecognizer(target: self, action: #selector(WholeSettingViewController.showWDAlert(sender:)))
            self.WithDrawalView.addGestureRecognizer(gesturealert3)
        }
        
        
        @objc func goProfileEdit(sender:UIGestureRecognizer){
               let storyboard  = UIStoryboard(name: "Main", bundle: nil)
               let profileEditViewController = storyboard.instantiateViewController(withIdentifier:"ProfileEditViewController")
               self.navigationController!.pushViewController(profileEditViewController, animated: true)
           }
     
        @objc func goQuestion(sender:UIGestureRecognizer){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let QuestionViewController = storyboard.instantiateViewController(withIdentifier: "QuestionViewController")
            self.navigationController!.pushViewController(QuestionViewController, animated: true)
            
        }
        
        @objc func showSIAlert(sender:UIGestureRecognizer){
            let alert = UIAlertController(title: "개인정보 처리방침", message: "동의서 열람", preferredStyle: .alert)
            alert.addTextField { textField in
                let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 500)
                textField.addConstraint(heightConstraint)
                textField.text = "여기에 개인정보 동의서 열람과 내용이 표시됩니다.\n 상당히 길 것으로 예측되는데 스크롤도 넣어야 할까요 아니면 그정도면 괜찮을까요"
                textField.isUserInteractionEnabled = false
            }
            
            let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
            let close = UIAlertAction(title: "닫기", style: .destructive, handler: nil)
            alert.addAction(confirm)
            alert.addAction(close)
            present(alert, animated: true, completion: nil)
        }
        
        @objc func showLogoutAlert(sender:UIGestureRecognizer){
            let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "로그아웃", style: .default, handler: nil)
            let close = UIAlertAction(title: "안나갈래요", style: .destructive, handler: nil)
            alert.addAction(confirm)
            alert.addAction(close)
            present(alert, animated: true, completion: nil)
        }
        
        @objc func showWDAlert(sender:UIGestureRecognizer){
            let alert = UIAlertController(title: "회원탈퇴", message: "탈퇴하시는 이유가 무엇인가요?", preferredStyle: .alert)
            alert.addTextField { textField in
                let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
                textField.addConstraint(heightConstraint)
            }
            
            let confirm = UIAlertAction(title: "탈퇴", style: .default, handler: nil)
            let close = UIAlertAction(title: "안할래요", style: .destructive, handler: nil)
            alert.addAction(confirm)
            alert.addAction(close)
            present(alert, animated: true, completion: nil)
        }
      }
    ```
    
    위에 코드에서 보면 각각 전환이 필요한 뷰에 제스쳐 인식자를 등록해주고 그에 필요한 selector 메소드를 정의해준 것을 볼 수 있다!!
    

---

### 메뉴 버튼인 케밥 메뉴 아이콘을 어떻게 구현할 것인가 (이미지로 안넣고)

- 해결방법
    
    pod 파일에 ‘Dropdown’ 라이브러리를 추가한 다음
    
    ```swift
    override func viewDidLoad() {
            super.viewDidLoad()
            self.initUI()
            self.setDropdown()
            
        }
    
    let dropdown = DropDown()
    
            // DropDown 아이템 리스트
        var itemList = ["용돈", "적금", "월급", "의복", "식재", "배달음식", "교통비", "고정지출"]
            
            
            func initUI() {
                // DropDown View의 배경
                dropView.backgroundColor = UIColor.init(named: "#F1F1F1")
                dropView.layer.cornerRadius = 8
                
                DropDown.appearance().textColor = UIColor.black // 아이템 텍스트 색상
                DropDown.appearance().selectedTextColor = UIColor.red // 선택된 아이템 텍스트 색상
                DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
                DropDown.appearance().selectionBackgroundColor = UIColor.lightGray // 선택한 아이템 배경 색상
                DropDown.appearance().setupCornerRadius(8)
                dropdown.dismissMode = .automatic // 팝업을 닫을 모드 설정
                    
                tfInput.text = "선택해주세요." // 힌트 텍스트
                    
                ivIcon.tintColor = UIColor.gray
            }
    
            func setDropdown() {
                // dataSource로 ItemList를 연결
               
                    dropdown.dataSource = itemList
                // anchorView를 통해 UI와 연결
                dropdown.anchorView = self.dropView
                
                // View를 갖리지 않고 View아래에 Item 팝업이 붙도록 설정
                dropdown.bottomOffset = CGPoint(x: 0, y: dropView.bounds.height)
                
                // Item 선택 시 처리
                dropdown.selectionAction = { [weak self] (index, item) in
                    //선택한 Item을 TextField에 넣어준다.
                    self!.tfInput.text = item
                    self!.categorytype = item
                    self!.ivIcon.image = UIImage.init(named: "DropDownDown")
                }
                
                // 취소 시 처리
                dropdown.cancelAction = { [weak self] in
                    //빈 화면 터치 시 DropDown이 사라지고 아이콘을 원래대로 변경
                    self!.ivIcon.image = UIImage.init(named: "DropDownDown")
                }
            }
            
            @IBAction func dropdownClicked(_ sender: UIButton) {
                dropdown.show() // 아이템 팝업을 보여준다.
                  // 아이콘 이미지를 변경하여 DropDown이 펼쳐진 것을 표현
                  self.ivIcon.image = UIImage.init(named: "DropDownDown")
            }
    ```
    
    이렇게 해주면 작동한다.
    

---

### tab bar controller에 연결한 뷰 컨트롤러에서 navigation item이 나타나지 않는 문제

- 해결방법
    
    당시 navigation controller는 화면 제일 앞에 위치하고 있었다.
    
    기존 navigation controller와 화면 상의 간격이 너무 벌어져서 그런 문제가 생긴 것 같았다.
    
    view controller를 그 화면 바로 앞에 집어넣어 해결했다.
    

---

### github organization에서 main 브랜치가 아닌 브랜치에서 작업했는데, 정작 내 레포에는 없을 때

- 해결방법
    
    re-fork로 해결해면 된다.
    
    **re-fork 하는 방법**
    
    `git remote add upstream [기존 레포 url]
    // 오리지널 레포를 upstream으로 추가
    
    git remote -v
    // 잘 되었는지 확인
    
    git fetch [신규 브랜치 이름]
    // 새로운 브랜치들을 이런 식으로 가져옴
    
    git checkout staging
    
    git push origin staging
    // 내 레포에도 반영`
    
    다만 이렇게 했더니, 기존 Local 파일의 main이 작동하지 않고
    
    ***line 604: starttag: invalid element name***
    
    이런 요상한 에러가 발생했다
    
    구글링을 통해 xml 파일에 문제가 생긴 건 알겠지만, 정확한 문제 해결 방식을 몰라서
    
    그냥 로컬에서 새로 clone을 받아왔더니 제대로 동작하기 시작했다.
    

---

### X_ACCESS_TOKEN을 로그인 방식으로 채택했을 때, 헤더에 어떻게 토큰을 추가할까

- 해결방법
    
    헤더에 어떻게 추가해야 할지 몰라, 한참을 헤매었는데(도와주세요 구글 교수님)
    
    ```swift
    import Cocoa
    
    let session: URLSession = URLSession.shared
    func session_check(url: URL, accessToken: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) throws {
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        request.addValue("Mozilla/5.0", forHTTPHeaderField: "User-Agent")
            session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    let accessToken: String = "xxxx-yyyy-zzzz"
    let url: URL = URL(string: "http://192.168.0.26:8080/et")!
    do {
        try session_check(url: url, accessToken: accessToken, completionHandler: { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let returnCode = httpResponse.statusCode
                if returnCode == 200 {    print("200 OK")    }
            }
        })
    } catch {
        print(error)
    }
    sleep(1)
    ```
    
    마침내 구글 교수님께서 한 예제를 보여주시며 의문을 해소해주셨다.
    
    헤더에다 addValue로 accessToken을 추가해주면 된다.
    

---

### 이미지 저장을 base64방식으로 이미지 데이터를 string으로 바꿔서 저장 했을 때, 해상도가 낮아지는 문제

- 해결방법
    
    이미지 저장을 base64방식으로 이미지 데이터를 string으로 바꿔서 저장하고 있었다. 그런데 사진을 선택해서(imagepicker) 보여주는 버튼의 크기가 90이기 때문에, 그 사이즈에 맞춰서 넣어준 다음 서버에 보내는 방식이어서, 당연히 90짜리를 큰 UIImageView에서 보여주니까 해상도가 낮아질 수 밖에…라고 생각하며 자연스럽게 기본 이미지 크기 그대로 서버에 저장했더니
    
    데이터 양이 어마무시하게 나와서 앱이 다운됐다.
    
    결국 우려했던 대로 이미지 크기가 문제가 됐고
    
    **multipart/form-data 형태로 이미지를 올리기로 결심했다.**
    
    ```swift
    // MARK: - [URL Session Post 멀티 파트 사진 데이터 업로드]
           func requestPOST() {
               
               // MARK: [사진 파일 파라미터 이름 정의 실시]
               let file = "image"
               
               let userIdx = UserDefaults.standard.integer(forKey: "userIdx")
               let accessToken = UserDefaults.standard.string(forKey: "accessToken")
               
               
               // MARK: [전송할 데이터 파라미터 정의 실시]
               var reqestParam : Dictionary<String, Any> = [String : Any]()
               //reqestParam["userIdx"] = userIdx // 일반 파라미터
               reqestParam["\(file)"] = self.imageData // 사진 파일
               
               // MARK: [URL 지정 실시]
               let urlComponents = URLComponents(string: "https://www.pigmoney.xyz/goal/uploadGoalImage/\(goalIdx!)/\(userIdx)")
               print("\n\n\n여기가 마지막 보루다!!:", urlComponents as Any)
               // [boundary 설정 : 바운더리 라인 구분 필요 위함]
               let boundary = "Boundary-\(UUID().uuidString)" // 고유값 지정
               
               print("")
               print("====================================")
               print("[A_Image >> requestPOST() :: 바운더리 라인 구분 확인 실시]")
               print("boundary :: ", boundary)
               print("====================================")
               print("")
               
               
               // [http 통신 타입 및 헤더 지정 실시]
               var requestURL = URLRequest(url: (urlComponents?.url)!) // url 주소 지정
               requestURL.httpMethod = "POST" // POST 방식
               requestURL.setValue(accessToken!, forHTTPHeaderField: "X-ACCESS-TOKEN")
               requestURL.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type") // 멀티 파트 타입
               print("header!!!",requestURL.allHTTPHeaderFields as Any)
               
               // [서버로 전송할 uploadData 데이터 형식 설정]
               var uploadData = Data()
               let boundaryPrefix = "--\(boundary)\r\n"
               
               
               
               // [멀티 파트 전송 파라미터 삽입 : 딕셔너리 for 문 수행]
               for (key, value) in reqestParam {
                   if "\(key)" == "\(file)" { // MARK: [사진 파일 인 경우]
                       print("")
                       print("====================================")
                       print("[A_Image >> requestPOST() :: 멀티 파트 전송 파라미터 확인 실시]")
                       print("타입 :: ", "사진 파일")
                       print("key :: ", key)
                       print("value :: ", value)
                       print("====================================")
                       print("")
                       
                       uploadData.append(boundaryPrefix.data(using: .utf8)!)
                       uploadData.append("Content-Disposition: form-data; name=\"\(file)\"; filename=\"\(file)\"\r\n".data(using: .utf8)!) // [파라미터 key 지정]
                       uploadData.append("Content-Type: \("image/jpg")\r\n\r\n".data(using: .utf8)!) // [전체 이미지 타입 설정]
                       uploadData.append(value as! Data) // [사진 파일 삽입]
                       uploadData.append("\r\n".data(using: .utf8)!)
                       uploadData.append("--\(boundary)--".data(using: .utf8)!)
                   }
                   else { // MARK: [일반 파라미터인 경우]
                       print("")
                       print("====================================")
                       print("[A_Image >> requestPOST() :: 멀티 파트 전송 파라미터 확인 실시]")
                       print("타입 :: ", "일반 파라미터")
                       print("key :: ", key)
                       print("value :: ", value)
                       print("====================================")
                       print("")
                       
                       uploadData.append(boundaryPrefix.data(using: .utf8)!)
                       uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!) // [파라미터 key 지정]
                       uploadData.append("\(value)\r\n".data(using: .utf8)!) // [value 삽입]
                   }
               }
    
               
               
               // [http 요쳥을 위한 URLSessionDataTask 생성]
               print("")
               print("====================================")
               print("[A_Image >> requestPOST() :: 사진 업로드 요청 실시]")
               print("url :: ", requestURL)
               print("uploadData :: ", uploadData)
               print("====================================")
               print("")
               
               // MARK: [URLSession uploadTask 수행 실시]
               let dataTask = URLSession(configuration: .default)
               dataTask.configuration.timeoutIntervalForRequest = TimeInterval(20)
               dataTask.configuration.timeoutIntervalForResource = TimeInterval(20)
               dataTask.uploadTask(with: requestURL, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
    
                   // [error가 존재하면 종료]
                   guard error == nil else {
                       print("")
                       print("====================================")
                       print("[A_Image >> requestPOST() :: 사진 업로드 요청 실패]")
                       print("fail : ", error?.localizedDescription ?? "")
                       print("====================================")
                       print("")
                       return
                   }
    
                   // [status 코드 체크 실시]
                   let successsRange = 200..<300
                   guard let statusCode = (response as? HTTPURLResponse)?.statusCode, successsRange.contains(statusCode)
                   else {
                       print("")
                       print("====================================")
                       print("[A_Image >> requestPOST() :: 사진 업로드 요청 에러]")
                       print("error : ", (response as? HTTPURLResponse)?.statusCode ?? 0)
                       print("allHeaderFields : ", (response as? HTTPURLResponse)?.allHeaderFields ?? "")
                       print("msg : ", (response as? HTTPURLResponse)?.description ?? "")
                       print("====================================")
                       print("")
                       return
                   }
    
                   // [response 데이터 획득, json 형태로 변환]
                   let resultCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                   let resultLen = data! // 데이터 길이
                   do {
                       guard let jsonConvert = try JSONSerialization.jsonObject(with: data!) as? [String: Any] else {
                           print("")
                           print("====================================")
                           print("[A_Image >> requestPOST() :: 사진 업로드 요청 에러]")
                           print("error : ", "json 형식 데이터 convert 에러")
                           print("====================================")
                           print("")
                           return
                       }
                       guard let JsonResponse = try? JSONSerialization.data(withJSONObject: jsonConvert, options: .prettyPrinted) else {
                           print("")
                           print("====================================")
                           print("[A_Image >> requestPOST() :: 사진 업로드 요청 에러]")
                           print("error : ", "json 형식 데이터 변환 에러")
                           print("====================================")
                           print("")
                           return
                       }
                       guard let resultString = String(data: JsonResponse, encoding: .utf8) else {
                           print("")
                           print("====================================")
                           print("[A_Image >> requestPOST() :: 사진 업로드 요청 에러]")
                           print("error : ", "json 형식 데이터 >> String 변환 에러")
                           print("====================================")
                           print("")
                           return
                       }
                       print("")
                       print("====================================")
                       print("[A_Image >> requestPOST() :: 사진 업로드 요청 성공]")
                       print("allHeaderFields : ", (response as? HTTPURLResponse)?.allHeaderFields ?? "")
                       print("resultCode : ", resultCode)
                       print("resultLen : ", resultLen)
                       print("resultString : ", resultString)
                       print("====================================")
                       print("")
                   } catch {
                       print("")
                       print("====================================")
                       print("[A_Image >> requestPOST() :: 사진 업로드 요청 에러]")
                       print("error : ", "Trying to convert JSON data to string")
                       print("====================================")
                       print("")
                       return
                   }
               }.resume()
           }
    ```
    
    그래도 기존에 있던 postGoal() 함수를 버리기엔 아까워서, 이미지 따로, 나머지 목표 관련 정보 따로 올리기로 했다.
    
    위는 이미지를 서버에 올리기 위해, 이미지 데이터를 서버로 보내는 함수이다.
    
    문제는 URLSession의 복잡한 쿼리였다. URLSession은 함수자체가 비동기로 작성되어있어서
    
    postGoal() 함수에서 이미지를 제외한 목표 정보를 서버에 올리고 goalIdx를 받아오면, 그 goalIdx로 이미지를 올리는 절차였는데
    
    이 postGoal() 안에 있던 URLSession이 비동기라 시간이 너무 많이 걸린다고 여겼는지 goalIdx를 받아오지 않은 채, 바로 이미지를 받아오는 함수 requestPost()로 이동하는 것이었다. (그러니까 이미지를 못받을 수 밖에…)
    
    별의 별 방법을 전부 사용해보았다.
    <img width="1000" alt="image" src="https://github.com/jinyongyun/WHAT_IS_MONEY_IOS/assets/102133961/e4c5d285-82ce-47b5-95e5-098ffbd78557">

    
    이런 식으로 while 문을 이용해 함수 자체를 나가지 못하게 만들어보았고( 이건 request time 이 초과되는 에러가 발생했다)
    <img width="1000" alt="image2" src="https://github.com/jinyongyun/WHAT_IS_MONEY_IOS/assets/102133961/d8838533-13ae-47cd-8fa9-4c2ce7531d2d">

    
    semaphore를 이용해서도 해보았다(이건 뭐가 문제인지 앱 자체가 멈춰버린다)
    
    어쩔 수 없이 DispatchQeue를 이용한 delay를 사용해 앱 속도를 조금 늦추더라도 goalIdx를 받아오기로 했다.
    
    다만 기다리는 시간이 조금 어색할 수 있으니 로딩 페이지를 만들어 뷰 위에 올렸다.


## 앱 소개 영상

https://github.com/jinyongyun/WHAT_IS_MONEY_IOS/assets/102133961/8134805e-3254-4bbe-af89-eb6b1b5d8e9e


## 앱 시연 영상



https://github.com/jinyongyun/WHAT_IS_MONEY_IOS/assets/102133961/92cad87e-76e3-40f8-b08b-d933cc2dd43d



https://github.com/jinyongyun/WHAT_IS_MONEY_IOS/assets/102133961/6093b976-60dd-49c2-aed7-be638b05001e


