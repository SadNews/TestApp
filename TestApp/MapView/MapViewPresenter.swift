//
//  MapViewPresenter.swift
//  TestApp
//
//  Created by Андрей Ушаков on 04.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import Foundation
import Firebase

final class MapViewPresenter {
    
    weak var delegate: AddMarkProtocol?
    func observe() {
        let ref = Database.database().reference(withPath: "users").child(String(UserInfo.userDemo.uid)).child("tasks")
        var _tasks = Array<Task>()
        ref.observe(.value, with: { snapshot in
            for item in snapshot.children {
                let task = Task(snapshot: item as! DataSnapshot)
                if MapViewModel.tasksHashValue.insert(task.hashValue).inserted {
                    let marker = AddM.addM(userName: task.title ?? "", latitude: task.latitude!, longitude: task.longitude!, sex: task.sex ?? "", age: task.age ?? "", weight: task.weight ?? "", interests: task.interests ?? [""])
                    self.delegate?.addNewMark(marker: marker)
                    
                }
                _tasks.append(task)
            }
            MapViewModel.tasks = _tasks
        })
    }
}
