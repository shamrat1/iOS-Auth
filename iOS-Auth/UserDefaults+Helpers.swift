//
//  UserDefaults+Helpers.swift
//  iOS-Auth
//
//  Created by Yasin Shamrat on 23/2/20.
//  Copyright © 2020 Yasin Shamrat. All rights reserved.
//

import UIKit
import SwiftyJSON

extension UserDefaults {
    
    func setLoggedIn(tokenText: JSON) {
        set(true, forKey: "isLoggedIn")
        set(tokenText, forKey: "access_token")
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    func logout() {
        set(false, forKey: "isLoggedIn")
        set("", forKey: "access_token")
        synchronize()
    }
    
}
