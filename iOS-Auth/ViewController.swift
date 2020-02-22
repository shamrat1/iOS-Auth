//
//  ViewController.swift
//  iOS-Auth
//
//  Created by Yasin Shamrat on 22/2/20.
//  Copyright © 2020 Yasin Shamrat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    let loginURL = "http://localhost:8888/iOS-auth/public/api/login"
    
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func onClickLogin(_ sender: UIButton) {
        
        if emailOutlet != nil && passwordOutlet != nil {
//            let headers: HTTPHeaders =
            let params = ["email": emailOutlet!.text!, "password": passwordOutlet!.text!]
            Alamofire.request(loginURL, method: .post, parameters: params as Parameters).authenticate(user: emailOutlet!.text!, password: passwordOutlet!.text!).responseJSON { response in
                switch response.result {
                case .success:
                    if let value = response.result.value{
                        let data = JSON(value)
                        let token = data["success"]["token"]
                        print(token)
                    }
                    
                    self.emailOutlet.text = nil
                    self.passwordOutlet.text = nil
                case let .failure(error):
                    print(error)
                }
                }
        }
    }
    

}

