//
//  LoginViewController.swift
//  iOS-Auth
//
//  Created by Yasin Shamrat on 23/2/20.
//  Copyright © 2020 Yasin Shamrat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class LoginViewController: UIViewController {
    
    let loginURL = "http://localhost:8888/iOS-auth/public/api/login"
    
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        UserDefaults.standard.logout()
        print(UserDefaults.standard.bool(forKey: "isLoggedIn"))
        print(UserDefaults.standard.string(forKey: "access_token"))
        
    }
    @IBAction func onClickRegisterView(_ sender: Any) {
        performSegue(withIdentifier: "goToRegisterView", sender: self)
    }
    
    @IBAction func onClickLogin(_ sender: UIButton) {
        
        if emailOutlet.text != "" && passwordOutlet.text != "" {
            SVProgressHUD.show(withStatus: "Loading...")
            //            let headers: HTTPHeaders =
            let params = ["email": emailOutlet!.text!, "password": passwordOutlet!.text!]
            Alamofire.request(loginURL, method: .post, parameters: params as Parameters).responseJSON { response in
                switch response.result {
                case .success:
                    if let value = response.result.value{
                        let data = JSON(value)
                        let token = data["success"]["token"]
                        UserDefaults.standard.setLoggedIn(tokenText: token)
                        self.changeRootView()
                    }
                    self.emailOutlet.text = nil
                    self.passwordOutlet.text = nil
                case let .failure(error):
                    print(error)
                }
                SVProgressHUD.dismiss()
            }
            
        }
    }
    
    func changeRootView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "main")
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
  

}
