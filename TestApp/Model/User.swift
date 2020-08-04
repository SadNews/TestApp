//
//  User.swift
//  TestApp
//
//  Created by Андрей Ушаков on 01.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import Foundation
import Firebase

struct UserInfo {
    let uid: String
    let email: String
    
    init(userID: String, email: String) {
        self.uid = userID
        self.email = email
    }
    //Демо юзер
    static let userDemo = UserInfo.init(userID: "Kack", email: "kack@ya.ru")

}
