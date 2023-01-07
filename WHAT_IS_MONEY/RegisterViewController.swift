//
//  RegisterViewController.swift
//  WHAT_IS_MONEY
//
//  Created by 이예나 on 1/8/23.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var NameInput: UITextField!
    @IBOutlet weak var EmailInput: UITextField!
    @IBOutlet weak var IDInput: UITextField!
    @IBOutlet weak var PWInput: UITextField!
    @IBOutlet weak var ConfirmPWInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkIDValidation(_ sender: UIButton) {
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        guard let name = NameInput.text else { return }
        guard let email = EmailInput.text else { return }
        guard let id = IDInput.text else { return }
        guard let pw = PWInput.text else { return }
        guard let confirmPw = ConfirmPWInput.text else { return }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
