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

    let userURL = "http://localhost:8888/iOS-auth/public/api/user"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DispatchQueue.main.async {
            self.getUser()
        }
        
    }
    @IBAction func onClickLogout(_ sender: Any) {
        UserDefaults.standard.logout()
    }
    
    func getUser(){
        let token = UserDefaults.standard.string(forKey: "access_token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)"
        ]
        Alamofire.request(userURL, method: .get, headers: headers).responseJSON { response in
            switch response.result{
            case .success:
                let data = JSON(response.result.value as Any)
                self.nameLabel.text = "Name: \(String(describing: data["name"]))"
                self.emailLabel.text = "Email: \(String(describing: data["email"]))"
                self.createdAtLabel.text = String(describing: data["created_at"])
                print(self.nameLabel.text as Any)
            case let .failure(error):
                print(error)
            }
        }
    }
    

}

