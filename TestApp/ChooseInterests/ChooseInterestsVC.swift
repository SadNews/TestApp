//
//  ViewController3.swift
//  TestApp
//
//  Created by Андрей Ушаков on 03.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import UIKit

final class ChooseInterestsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var stringValue: StringValues?
    var interests: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interests.removeAll()
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func done(_ sender: UIButton) {
        stringValue?.interest = interests.sorted()
        dismiss(animated: false, completion: nil)
    }
}

extension ChooseInterestsVC: UITableViewDelegate {
    
}

extension ChooseInterestsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constans.interests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseInterestsCell", for: indexPath) as! ChooseInterestsTableViewCell
        cell.interest.text = Constans.interests[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                interests.insert(Constans.interests[indexPath.row])
                print(interests)
            } else {
                cell.accessoryType = .none
                interests.remove(Constans.interests[indexPath.row])
            }
        }
    }
}
