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
        let ref = Database.database().reference(withPath: "users").child(String(UserInfo.userDemo.uid))
        DispatchQueue.global().async {
            ref.observe(.childChanged, with: { snapshot in
                for item in snapshot.children {
                    let task = Task(snapshot: item as! DataSnapshot)
                    self.delegate?.addNewMark(marker: AddMarker.addNewMarker(task: task))
                }
            })
            ref.observe(.childAdded, with: { snapshot in
                for item in snapshot.children {
                    let task = Task(snapshot: item as! DataSnapshot)
                    self.delegate?.addNewMark(marker: AddMarker.addNewMarker(task: task))
                }
            })
        }
    }
}
