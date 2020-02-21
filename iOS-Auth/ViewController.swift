//
//  ViewController.swift
//  iOS-Auth
//
//  Created by Yasin Shamrat on 22/2/20.
//  Copyright © 2020 Yasin Shamrat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func onClickLogin(_ sender: UIButton) {
        
        if emailOutlet != nil && passwordOutlet != nil {
            print("\(emailOutlet.text) \(passwordOutlet.text)")
        }
    }
    

}

