//
//  MapViewPresenter.swift
//  TestApp
//
//  Created by Андрей Ушаков on 04.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import Foundation
import Firebase
import GoogleMaps
import GooglePlaces

protocol addMarkProtocol: class {
    func  addMark(marker: GMSMarker)
    func addNewMark(latitude: Double, longitude: Double, title: String, subtitle: String)
}

final class MapViewPresenter {
    
    weak var delegate: addMarkProtocol?

    func observe() {
        let ref = Database.database().reference(withPath: "users").child(String(UserInfo.userDemo.uid)).child("tasks")

        var _tasks = Array<Task>()
        ref.observe(.value, with: { snapshot in
            for item in snapshot.children {
                let task = Task(snapshot: item as! DataSnapshot)
                self.delegate?.addNewMark(latitude: task.latitude!, longitude: task.longitude!, title: task.age ?? "", subtitle: task.sex ?? "")
                _tasks.append(task)
            }
            MapViewModel.tasks = _tasks
            print( MapViewModel.tasks)

        })
    }
    func addMark(latitude: Double, longitude: Double, title: String, subtitle: String) {
     let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
       let marker = GMSMarker(position: position)
     //  marker.title = "Привет кот"
        delegate?.addMark(marker: marker)
    //  marker.map = mapView
    }
    func addNe() {
    let popup = self.storyboard?.instantiateViewController(withIdentifier: "PopupVC") as! AddOrderViewController
           let vc5 = self.storyboard?.instantiateViewController(withIdentifier: "vc5") as! ViewControllerTime
           marker.position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
           popup.position = marker.position
           vc5.delegate = self
           present(popup, animated: true, completion: nil)
    }
}
