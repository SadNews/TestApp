//
//  SelectDurationPresenter.swift
//  TestApp
//
//  Created by Андрей Ушаков on 04.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces
import Firebase

class SelectDurationPresenter {
    let newMark = AddNewMarker()

    let marker = GMSMarker()
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
        addMark(task: task)
    }
    
    func addMark(task: Task) {
        let marker = AddM.addM(userName: task.title ?? "", latitude: task.latitude!, longitude: task.longitude!, sex: task.sex ?? "", age: task.age ?? "", weight: task.weight ?? "", interests: task.interests ?? [""])
        self.delegate?.addNewMark(marker: marker)
    }
}
