//
//  AddMark.swift
//  TestApp
//
//  Created by Андрей Ушаков on 04.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import Foundation
import GoogleMaps

protocol ConfigureNewMark: class {
    static func addM(userName: String, latitude: Double, longitude: Double,
                     sex: String, age: String, weight: String, interests: [String]) -> GMSMarker
}
class AddM: ConfigureNewMark {
    let marker = GMSMarker()
    static func addM(userName: String, latitude: Double, longitude: Double,
                     sex: String, age: String, weight: String, interests: [String]) -> GMSMarker{
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker = GMSMarker(position: position)
        marker.title = "Имя - \(userName)"
        marker.snippet = """
        Пол - \(sex)
        Возраст - \(age)
        Вес - \(weight)
        Интересы -  \(interests)
        """
        return marker
    }
}
