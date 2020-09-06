//
//  AddOrderViewController.swift
//  TestApp
//
//  Created by Андрей Ушаков on 31.07.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import UIKit
import GoogleMaps
import FirebaseDatabase

protocol DismissDelegate {
    func  dismiss()
}

final class AddOrderViewController: UIViewController, DismissDelegate  {
    @IBOutlet weak var whatDoYouWantLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var doneStackView: UIStackView!
    
    var stringValues: StringValues?
    var position: CLLocationCoordinate2D?
    
    @IBAction func btnDone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        stringValues = StringValues()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func dismiss() {
        tableView.isHidden = true
        whatDoYouWantLabel.isHidden = true
        continueButton.isHidden = true
        doneStackView.isHidden = false
    }
    
    @IBAction func addOrder(_ sender: UIButton) {
        let ref = Database.database().reference(withPath: "users").child(String(UserInfo.userDemo.uid)).child("tasks")
        
        let task = Task(title: String(Int.random(in: 0..<10000)), userID: UserInfo.userDemo.uid,
                        latitude: position!.latitude, longitude: position!.longitude,
                        sex: stringValues?.selectedValues[0] ?? "", age: stringValues?.selectedValues[1] ?? "",
                        weight: stringValues?.selectedValues[2] ?? "", interests: stringValues?.interest ?? [""])
        
        let taskRef = ref.child(task.title?.lowercased() ?? "")
        taskRef.setValue(task.convertToDictionary())
        tableView.isHidden = true
        whatDoYouWantLabel.isHidden = true
        continueButton.isHidden = true

    }
}
