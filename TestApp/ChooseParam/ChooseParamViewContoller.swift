//
//  ViewController.swift
//  TestApp
//
//  Created by Андрей Ушаков on 01.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import UIKit

final class ChooseParamViewContoller: UIViewController {
    
    @IBOutlet weak var paramName: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    private var presenter: ChooseParamPresenter!
    var currentSelection: Int?
    var stringValue: StringValues?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ChooseParamPresenter()
        presenter.whichPickerShouldBeShown(currentSelection: currentSelection ?? 100)
        picker.delegate = self
        picker.dataSource = self
        paramName.text = Constans.menu[currentSelection ?? 0]
        value.text = presenter.pickerElements[0]
    }
    
    @IBAction func exit(_ sender: UIButton) {
        stringValue!.selectedValues[currentSelection ?? 0] = value.text ?? ""
        dismiss(animated: false, completion: nil)
        
    }
}
extension ChooseParamViewContoller: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        paramName.text = Constans.menu[currentSelection ?? 0]
        value.text =  presenter.pickerElements[row]
    }
}
extension ChooseParamViewContoller: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter.pickerElements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presenter.pickerElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: presenter.pickerElements[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
