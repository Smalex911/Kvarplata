//
//  DetailMeterVC.swift
//  Kvarplata
//
//  Created by Александр Смородов on 31.07.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import UIKit

class DetailMeterVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
    }
    
    func style() {
        title = TextProvider.titleAdd()
    }
}
