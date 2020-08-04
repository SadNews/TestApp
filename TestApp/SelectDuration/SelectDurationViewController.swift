//
//  ViewControllerTime.swift
//  TestApp
//
//  Created by Андрей Ушаков on 03.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase

class SelectDurationViewController: UIViewController {
    
    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var titleInfo: UILabel!
    @IBOutlet weak var add: UIButton!
    var delegate2: DismissDelegate?
    var delegate: AddMarkProtocol?
    let marker = GMSMarker()
    var user: UserInfo!
    var ref: DatabaseReference!
    var v1: StringValues?
    
    var position: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "users").child(String(UserInfo.userDemo.uid)).child("tasks")
        tableVIew.delegate = self
        tableVIew.dataSource = self
        add.isEnabled = false
        add.backgroundColor = .gray
        // Do any additional setup after loading the view.
    }
    
    @IBAction func add(_ sender: UIButton) {
        let task = Task(title: String(Int.random(in: 0..<10000)), userID: UserInfo.userDemo.uid, latitude: position!.latitude, longitude: position!.longitude, sex: v1!.selectedValues[0], age: v1!.selectedValues[1], weight: v1!.selectedValues[2], interests: v1?.interest ?? [""])
        let taskRef = self.ref.child(task.title!.lowercased())
        taskRef.setValue(task.convertToDictionary())
        let marker = AddM.addM(userName: task.title ?? "", latitude: task.latitude!, longitude: task.longitude!, sex: task.sex ?? "", age: task.age ?? "", weight: task.weight ?? "")
        self.delegate?.addNewMark(marker: marker)
        dismiss(animated: false) {
            self.delegate2?.dismiss()
        }
    }
    
}

extension SelectDurationViewController: UITableViewDelegate {
    
}
extension SelectDurationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constans.time.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell4", for: indexPath) as! SelectDurationTableViewCell
        cell.time.text = Constans.time[indexPath.row]
        cell.price.text = Constans.price[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            add.isEnabled = true
            add.backgroundColor = .link
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
            
        }    }
    
}
