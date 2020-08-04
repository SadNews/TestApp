//
//  ViewControllerTime.swift
//  TestApp
//
//  Created by Андрей Ушаков on 03.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import UIKit
import GoogleMaps


final class SelectDurationViewController: UIViewController {
    
    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var titleInfo: UILabel!
    @IBOutlet weak var add: UIButton!
    private var presenter: SelectDurationPresenter!
    var dismissDelegate: DismissDelegate?
    var stringValue: StringValues?
    var position: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SelectDurationPresenter()
        tableVIew.delegate = self
        tableVIew.dataSource = self
        add.isEnabled = false
        add.backgroundColor = .gray
    }
    
    @IBAction func add(_ sender: UIButton) {
        presenter.stringValue = stringValue
        presenter.position = position
        presenter.addSnapshot()
        dismissDelegate?.dismiss()
        dismiss(animated: false, completion: nil)
    }
    
}

extension SelectDurationViewController: UITableViewDelegate {
    
}
extension SelectDurationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constans.time.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectDurationViewCell", for: indexPath) as! SelectDurationTableViewCell
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
        }
    }
}
