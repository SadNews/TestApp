//
//  AddOrderViewController.swift
//  TestApp
//
//  Created by Андрей Ушаков on 31.07.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase

class AddOrderViewController: UIViewController, DismissDelegate  {
    func dismiss() {
        tableView.isHidden = true
        tslabel.isHidden = true
        btnl.isHidden = true
        doneStackView.isHidden = false
    }
    @IBOutlet weak var tslabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnl: UIButton!
    @IBOutlet weak var doneStackView: UIStackView!
    
    let marker = GMSMarker()
    var user: UserInfo!
    var ref: DatabaseReference!
    var v1: Constans?
    var position: CLLocationCoordinate2D?
    
    @IBAction func btnDone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        v1 = Constans()
        ref = Database.database().reference(withPath: "users").child(String(UserInfo.userDemo.uid)).child("tasks")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func add(_ sender: UIButton) {
        let vc5 = self.storyboard?.instantiateViewController(withIdentifier: "vc5") as! ViewControllerTime
        vc5.modalPresentationStyle = .fullScreen
        vc5.v1 = v1
        vc5.position = position
        vc5.delegate2 = self
        print(v1?.value[0])
        present (vc5, animated: false, completion: nil)
        

        //
        //        let task = Task(title: String(Int.random(in: 0..<10000)), userID: user.uid, latitude: position!.latitude, longitude: position!.longitude, sex: v1!.value[0], age: v1!.value[1], weight: v1!.value[2])
        //        let taskRef = self.ref.child(task.title!.lowercased())
        //        taskRef.setValue(task.convertToDictionary())
        //        delegate?.addMark(latitude: position!.latitude, longitude: position!.longitude)
        //        dismiss(animated: true, completion: nil)
    }
}
extension AddOrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.label.text = menu.menu[indexPath.row]
        cell.value.text = v1?.value2[menu.menu[indexPath.row]]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 3 {
            let thirdVC = self.storyboard?.instantiateViewController(withIdentifier: "thirdVC") as! ViewController3
            thirdVC.modalPresentationStyle = .currentContext
            present(thirdVC, animated: false, completion: nil)
        } else {
            let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
            let currentCell = tableView.cellForRow(at: indexPath!)! as! TableViewCell
            let secondVc = self.storyboard?.instantiateViewController(withIdentifier: "secondVC") as! ViewController
            secondVc.modalPresentationStyle = .currentContext
            secondVc.currentSelection = indexPath?.row
            secondVc.v1 = v1
            present(secondVc, animated: false, completion: nil)
        }
    }
}

extension AddOrderViewController: UITableViewDelegate {
}

extension AddOrderViewController {
    
}
