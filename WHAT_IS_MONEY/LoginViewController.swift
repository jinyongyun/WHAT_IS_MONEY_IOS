//
//  LoginViewController.swift
//  WHAT_IS_MONEY
//
//  Created by 이예나 on 1/8/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var IDInput: UITextField!
    @IBOutlet weak var PWInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        guard let id = IDInput.text else { return }
        guard let password = PWInput.text else { return }
        //Auth.auth().signIn(withID)
        
    }
    
    @IBAction func googleAuthClicked(_ sender: UIButton) {
    }

    @IBAction func appleAuthClicked(_ sender: UIButton) {
    }
    
}
