//
//  RegisterViewController.swift
//  WHAT_IS_MONEY
//
//  Created by 이예나 on 1/8/23.
//

import UIKit


class RegisterViewController: UIViewController {
    var userModel = UserModel() // instance
    
    @IBOutlet weak var NameInput: UITextField!
    @IBOutlet weak var EmailInput: UITextField!
    @IBOutlet weak var IDInput: UITextField!
    @IBOutlet weak var PWInput: UITextField!
    @IBOutlet weak var ConfirmPWInput: UITextField!
    
    //회원 확인
    func isUser(id: String) -> Bool {
        for user in userModel.users {
            if user.email == id {
                return true
            }
        }
        return false
    }
    
    @objc func didEndOnExit(_ sender: UITextField) {
        if NameInput.isFirstResponder {
            EmailInput.becomeFirstResponder()
        }
        else if EmailInput.isFirstResponder {
            IDInput.becomeFirstResponder()
        }
        else if IDInput.isFirstResponder {
            PWInput.becomeFirstResponder()
        }
        else if PWInput.isFirstResponder {
            ConfirmPWInput.becomeFirstResponder()
        }
        else if NameInput.isFirstResponder {
            EmailInput.becomeFirstResponder()
        }
    }
    // TextField 흔들기 애니메이션
    func shakeTextField(textField: UITextField) -> Void{
        UIView.animate(withDuration: 0.2, animations: {
            textField.frame.origin.x -= 10
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                textField.frame.origin.x += 20
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    textField.frame.origin.x -= 10
                })
            })
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NameInput.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        EmailInput.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        IDInput.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        PWInput.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        ConfirmPWInput.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkIDValidation(_ sender: UIButton) {
        guard let id = IDInput.text, !id.isEmpty else { return }
        if userModel.isValidEmail(id: id) {
            let checkFail : Bool = isUser(id: id)
            if checkFail {
                print("아이디 중복")
                shakeTextField(textField: IDInput)
                let checkFailLabel = UILabel(frame: CGRect(x: 68, y: 510, width: 279, height: 45))
                checkFailLabel.text = "이미 가입된 아이디입니다."
                checkFailLabel.textColor = UIColor.red
                checkFailLabel.tag = 103
                
                self.view.addSubview(checkFailLabel)
            }
        }
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        guard let name = NameInput.text, !name.isEmpty else { return }
        guard let email = EmailInput.text, !email.isEmpty else { return }
        guard let id = IDInput.text, !id.isEmpty else { return }
        guard let pw = PWInput.text, !pw.isEmpty else { return }
        guard let confirmPw = ConfirmPWInput.text, !confirmPw.isEmpty else { return }
        
        if userModel.isValidEmail(id: email){
            if let removable = self.view.viewWithTag(100) {
                removable.removeFromSuperview()
            }
        }
        else {
            shakeTextField(textField: EmailInput)
            let emailLabel = UILabel(frame: CGRect(x: 31, y: 300, width: 312, height: 30))
            emailLabel.text = "이메일 형식을 확인해 주세요"
            emailLabel.textColor = UIColor.red
            emailLabel.tag = 100
            
            self.view.addSubview(emailLabel)
        } //email 형식 오류
        
        if userModel.isValidPassword(pwd: pw) {
            if let removable = self.view.viewWithTag(101) {
                removable.removeFromSuperview()
            }
        }
        else {
            shakeTextField(textField: PWInput)
            let passwordLabel = UILabel(frame: CGRect(x: 31, y: 335, width: 312, height: 30))
            passwordLabel.text = "비밀번호 형식을 확인해 주세요"
            passwordLabel.textColor = UIColor.red
            passwordLabel.tag = 101
            
            self.view.addSubview(passwordLabel)
        }// pw 형식 오류
        
        if pw == confirmPw {
            if let removable = self.view.viewWithTag(102) {
                removable.removeFromSuperview()
            }
        }
        else {
            shakeTextField(textField: ConfirmPWInput)
            let passwordConfirmLabel = UILabel(frame: CGRect(x: 68, y: 470, width: 279, height: 45))
            passwordConfirmLabel.text = "비밀번호가 다릅니다."
            passwordConfirmLabel.textColor = UIColor.red
            passwordConfirmLabel.tag = 102
            
            self.view.addSubview(passwordConfirmLabel)
        }
        
        
        if userModel.isValidEmail(id: email) && userModel.isValidPassword(pwd: pw) && pw == confirmPw {
            print("회원가입 성공")
            if let removable = self.view.viewWithTag(103) {
                removable.removeFromSuperview()
            }
            self.performSegue(withIdentifier: "로그인", sender: self)
        }
    }
    
}
