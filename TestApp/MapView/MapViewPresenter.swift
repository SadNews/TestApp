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
    let newMark = AddNewMarker()
    weak var delegate: AddMarkProtocol?
    func observe() {
        let ref = Database.database().reference(withPath: "users").child(String(UserInfo.userDemo.uid)).child("tasks")
        DispatchQueue.global().async {
        ref.observe(.value, with: { snapshot in
            for item in snapshot.children {
                let marker =  self.newMark.addNewMarker(item: item)
                self.delegate?.addNewMark(marker: marker)
            }
        })
        }
    }
}
