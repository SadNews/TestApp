//
//  Task.swift
//  TestApp
//
//  Created by Андрей Ушаков on 01.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import Foundation
import Firebase

struct Task: Hashable {
    let title: String?
    let userID: String?
    let latitude: Double?
    let longitude: Double?
    let sex: String?
    let age: String?
    let weight: String?
    let interests: [String]?
    let ref: DatabaseReference?
    var completed = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(userID)
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
    init(title: String, userID: String, latitude: Double, longitude: Double,
         sex: String, age: String, weight: String, interests: [String] ) {
        self.title = title
        self.userID = userID
        self.latitude = latitude
        self.longitude = longitude
        self.sex = sex
        self.age = age
        self.weight = weight
        self.ref = nil
        self.interests = interests
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String:AnyObject]
        title = snapshotValue["title"] as? String
        userID = snapshotValue["userID"] as? String
        latitude = snapshotValue["latitude"] as? Double
        longitude = snapshotValue["longitude"] as? Double
        sex = snapshotValue["sex"] as? String
        age = snapshotValue["age"] as? String
        weight = snapshotValue["weight"] as? String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
        interests = snapshotValue["interests"] as? [String]
    }
    
    func convertToDictionary() -> Any {
        return ["title": title!, "userId": userID!, "latitude": latitude!, "longitude": longitude!,
                "sex": sex!, "age": age!, "weight": weight!, "completed": completed, "interests": interests]
       }
}
