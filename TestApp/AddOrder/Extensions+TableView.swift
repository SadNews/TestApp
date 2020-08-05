//
//  Extensions+TableView.swift
//  TestApp
//
//  Created by Андрей Ушаков on 04.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import UIKit

extension AddOrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constans.menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddOrderTableViewCell", for: indexPath) as! AddOrderTableViewCell
        cell.label.text = Constans.menu[indexPath.row]
        if indexPath.row == 3 {
            cell.value.text = String(stringValues?.interest?.count ?? 0)
            
        }else {
            cell.value.text = stringValues?.selectedValues[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            let chooseInterests = self.storyboard?.instantiateViewController(withIdentifier: "ChooseInterestsVC") as! ChooseInterestsVC
            chooseInterests.modalPresentationStyle = .currentContext
            chooseInterests.stringValue = stringValues
            present(chooseInterests, animated: false, completion: nil)
        } else {
            let chooseParamVC = self.storyboard?.instantiateViewController(withIdentifier: "chooseParamViewContoller") as! ChooseParamViewContoller
            chooseParamVC.modalPresentationStyle = .currentContext
            chooseParamVC.currentSelection = indexPath.row
            chooseParamVC.stringValue = stringValues
            present(chooseParamVC, animated: false, completion: nil)
        }
    }
}

extension AddOrderViewController: UITableViewDelegate {
}
