//
//  Constans.swift
//  TestApp
//
//  Created by Андрей Ушаков on 02.08.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

class StringValues {
    var selectedValues: [String] = ["", "", "", ""]
    
    var interest: [String]?
}

enum Constans {
    static let menu = ["Пол - ", "Возраст - ", "Вес - ", "Интересы - "]
    static let time = ["1 час", "2 часа", "3 часа"]
    static let price = ["100 рублей", "150 рублей","200 рублей"]
    static let sex = ["Мужской", "Женский", "Не важно"]
    static let age = ["55-60", "60-65", "65-70","75-80", "80-85", "85-90", "90-95", "95-100"]
    static let weight = { () -> [String] in
        var weight = [String]()
        for i in 18...100 {
            weight.append(String(i))
        }
        return weight
    }
    static var interests = ["Почитать книгу", "Посмотреть кино", "Помочь по дому", "Прогулка", "Сходить в магазин", "Другое"]
}
