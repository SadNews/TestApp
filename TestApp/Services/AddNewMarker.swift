//
//  qq.swift
//  TestApp
//
//  Created by Андрей Ушаков on 04.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import Foundation
import Firebase
import GoogleMaps

class AddNewMarker {
    var newMarker: GMSMarker?
    
    func addNewMarker(item: NSEnumerator.Element) -> GMSMarker {
        let task = Task(snapshot: item as! DataSnapshot)
        if MapViewModel.tasksHashValue.insert(task.hashValue).inserted {
            let marker = AddM.addM(userName: task.title ?? "", latitude: task.latitude!, longitude: task.longitude!, sex: task.sex ?? "", age: task.age ?? "", weight: task.weight ?? "", interests: task.interests ?? [""])
            self.newMarker = marker
        }
        return newMarker ?? GMSMarker.init()
    }
}
