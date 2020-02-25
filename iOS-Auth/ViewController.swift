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
import SVProgressHUD

class ViewController: UIViewController {

    let userURL = "http://localhost:8888/iOS-auth/public/api/user"
    var activityIndicator = UIActivityIndicatorView(style: .gray)
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.getUser()
            print("Background Thread")
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
            Alamofire.request(self.userURL, method: .get, headers: headers).responseJSON { response in
                    switch response.result{
                    case .success:
                        DispatchQueue.main.async { // Main UI Thread
                            let data = JSON(response.result.value as Any)
                            print("Main UI: \(data)")
                            self.nameLabel.text = "Name: \(String(describing: data["name"]))"
                            self.emailLabel.text = "Email: \(String(describing: data["email"]))"
                            self.createdAtLabel.text = String(describing: data["created_at"])
                            print(self.nameLabel.text as Any)
                        }
                    case let .failure(error):
                        print(error)
                    }
                }

    }
    
    func startIndicator()
    {
        //creating view to background while displaying indicator
        let container: UIView = UIView()
        container.frame = self.view.frame
        container.center = self.view.center
        container.backgroundColor = .black
        
        //creating view to display lable and indicator
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 110, height: 80)
        loadingView.center = self.view.center
        loadingView.backgroundColor =  .black
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        //Preparing activity indicator to load
        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator.frame = CGRect(x: 40, y: 12, width: 40, height: 60)
        self.activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        loadingView.addSubview(activityIndicator)
        
        //creating label to display message
        let label = UILabel(frame: CGRect(x: 5, y: 55, width: 120, height: 20))
        label.text = "Loading..."
        label.textColor = UIColor.white
        label.bounds = CGRect(x: 0,y: 0,width: loadingView.frame.size.width / 2,height: loadingView.frame.size.height / 2)
        label.font = UIFont.systemFont(ofSize: 12)
        loadingView.addSubview(label)
        container.addSubview(loadingView)
        self.view.addSubview(container)
        
        self.activityIndicator.startAnimating()
    }
    func stopIndicator()
    {
        UIApplication.shared.endIgnoringInteractionEvents()
        self.activityIndicator.stopAnimating()
        ((self.activityIndicator.superview as UIView!).superview as UIView!).removeFromSuperview()
    }

}

