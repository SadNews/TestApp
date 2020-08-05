//
//  AddMark.swift
//  TestApp
//
//  Created by Андрей Ушаков on 04.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

class AddMarker {
    static func addNewMarker(task: Task) -> GMSMarker {
        let position = CLLocationCoordinate2DMake(task.latitude ?? 0, task.longitude ?? 0)
        let marker = GMSMarker(position: position)
        marker.title = "Имя - \(String(describing: task.userID))"
        marker.snippet = """
        Пол - \(String(describing: task.sex))
        Возраст - \(String(describing: task.age))
        Вес - \(String(describing: task.weight))
        Интересы -  \(String(describing: task.interests))
        """
        return marker
    }
}
