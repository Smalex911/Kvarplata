//
//  TextProvider.swift
//  Kvarplata
//
//  Created by Александр Смородов on 31.07.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import UIKit

class TextProvider {
    
    static func getMonthTitle(_ month: Int64?) -> String {
        guard let m = month, let month = Int(exactly: m), month > 0 && month < 13 else {
            return ""
        }
        let arrayMonths = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
        return arrayMonths[month-1]
    }
    
    static func getCurrentMonthAndYear() -> (Int, Int) {
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        
        return (month, year)
    }
    
    static func roundTwoSymbols(_ number: Double?) -> String {
        guard let number = number else {
            return ""
        }
        return String(format:"%.\(GlobalSettings.RoundSymbValues)f", number).fromSave()
    }
    
    static func titleMainVC() -> String {
        return "Показания"
    }
    
    static func titleEdit() -> String {
        return "Изменение"
    }
    
    static func save() -> String {
        return "Сохранить"
    }
    
    static func alertSendedTitle() -> String {
        return "Успех"
    }
    static func alertSendedMsg() -> String {
        return "Ваше сообщение было успешно отправлено"
    }
    
    static func defaultMail() -> String {
//        return "dom-drujba.101@yandex.ru"
        return "Alex11Sm@mail.ru"
    }
    
    static func alertNotSendTitle() -> String {
        return "Ошибка отправления"
    }
    static func alertNotSendMsg() -> String {
        return "К сожалению, ваше устройство не поддерживается для отправки email сообщений. Вы можете самостоятельно отправить его, или сохранить результат в приложении"
    }
    static func alertSendErrorMsg() -> String {
        return "К сожалению, возникла ошибка при отправлении сообщения, пожалуйста попробуйте снова"
    }
    
    static func great() -> String {
        return "Хорошо"
    }
    static func ok() -> String {
        return "ОК"
    }
}
