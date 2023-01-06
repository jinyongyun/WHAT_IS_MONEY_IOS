//
//  ProfileEditViewController.swift
//  WHAT_IS_MONEY
//
//  Created by jinyong yun on 2023/01/04.
//

import UIKit

class ProfileEditViewController: UIViewController {
    
    @IBOutlet weak var ProfilePicture: UIImageView!
    
    @IBOutlet weak var Name: UILabel!
    
    @IBOutlet weak var ID: UILabel!
    
    @IBOutlet weak var ChangeIDView: UIView!
    
    @IBOutlet weak var ChangeSNView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(ProfileEditViewController.goChangeID(sender:)))
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(ProfileEditViewController.goChangeSN(sender:)))
        self.ChangeIDView.addGestureRecognizer(gesture2)
        self.ChangeSNView.addGestureRecognizer(gesture3)
        
    }
    
    
    
    @objc func goChangeID(sender:UIGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let changeIDViewController = storyboard.instantiateViewController(withIdentifier: "ChangeIDViewController")
        self.navigationController!.pushViewController(changeIDViewController, animated: true)
        
    }
    
    @objc func goChangeSN(sender:UIGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let changeSNViewController = storyboard.instantiateViewController(withIdentifier: "ChangeSNViewController")
        self.navigationController!.pushViewController(changeSNViewController, animated: true)
        
    }
}
