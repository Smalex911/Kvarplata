//
//  TextProvider.swift
//  Kvarplata
//
//  Created by Александр Смородов on 31.07.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

class TextProvider {
    
    static func getMonthTitle(_ month: Int64?) -> String {
        guard let m = month, let month = Int(exactly: m), month > 0 && month < 13 else {
            return ""
        }
        let arrayMonths = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
        return arrayMonths[month-1]
    }
    
    static func roundTwoSymbols(_ number: Double?) -> String {
        guard let number = number else {
            return ""
        }
        return String(format:"%.2f", number)
    }
    
    static func titleMainVC() -> String {
        return "Показания"
    }
    
    static func titleEdit() -> String {
        return "Изменение"
    }
    
    static func titleAdd() -> String {
        return "Добавление"
    }
}
