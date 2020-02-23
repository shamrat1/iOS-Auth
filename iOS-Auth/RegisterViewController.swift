//
//  RegisterViewController.swift
//  iOS-Auth
//
//  Created by Yasin Shamrat on 23/2/20.
//  Copyright © 2020 Yasin Shamrat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController {
    let registerURL = "http://localhost:8888/iOS-auth/public/api/register"
    
    @IBOutlet weak var nameOutlet: UITextField!
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var confirmPasswordOutlet: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickSubmit(_ sender: Any) {
        if nameOutlet.text != "" && emailOutlet.text != "" && passwordOutlet.text != "" && confirmPasswordOutlet.text != "" {
            let params = [
                "name": nameOutlet.text,
                "email": emailOutlet.text,
                "password": passwordOutlet.text,
                "c_password": confirmPasswordOutlet.text
            ]
            
            Alamofire.request(registerURL, method: .post, parameters: params as Parameters).responseJSON { response in
                switch response.result{
                case .success:
                    print("success")
                    print(response.result.value)
                case let .failure(error):
                    debugPrint(error)
                }
            }
            
            
        }
    }
    
    

}
