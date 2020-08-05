//
//  SelectDurationPresenter.swift
//  TestApp
//
//  Created by Андрей Ушаков on 04.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import Foundation
import GooglePlaces
import Firebase

class SelectDurationPresenter {

    var ref: DatabaseReference!
    var delegate: AddMarkProtocol?
    var stringValue: StringValues?
    var position: CLLocationCoordinate2D?
    var dismissDelegate: DismissDelegate?
    
    func addSnapshot() {
        
        ref = Database.database().reference(withPath: "users").child(String(UserInfo.userDemo.uid)).child("tasks")
        let task = Task(title: String(Int.random(in: 0..<10000)), userID: UserInfo.userDemo.uid,
                        latitude: position!.latitude, longitude: position!.longitude,
                        sex: stringValue!.selectedValues[0], age: stringValue!.selectedValues[1],
                        weight: stringValue!.selectedValues[2], interests: stringValue?.interest ?? [""])
        let taskRef = self.ref.child(task.title!.lowercased())
        taskRef.setValue(task.convertToDictionary())
    }
}
