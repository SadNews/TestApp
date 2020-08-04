//
//  ChooseParamPresenter.swift
//  TestApp
//
//  Created by Андрей Ушаков on 04.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import Foundation

class ChooseParamPresenter {
    var pickerElements = [""]
    
    func whichPickerShouldBeShown(currentSelection: Int) {
        switch currentSelection {
        case 0:
            pickerElements = Constans.sex
        case 1:
            pickerElements = Constans.weight()
        case 2:
            pickerElements = Constans.age
        default:
            pickerElements = [""]
        }
    }
}
