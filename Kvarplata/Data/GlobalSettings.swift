//
//  GlobalSettings.swift
//  Kvarplata
//
//  Created by Александр Смородов on 11.08.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import UIKit

class GlobalSettings {
    static var StepValue: Double = 0.01
    static var RoundSymbValues: Int = 2
    static var SortInMain: SortInMainType = .monthsDesc
    
    static var mailRecipient: String = TextProvider.defaultMail()
    static var topic: String = "Показания счетчиков"
    static var fioSender: String = "Смородов Андрей Анатольевич"
    static var flatNumber: Int = 110
}
