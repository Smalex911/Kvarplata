//
//  Router.swift
//  Kvarplata
//
//  Created by Александр Смородов on 15.09.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import UIKit

class Router: AbstractRouter {
    
    static let shared = Router()
    
    func start(app:UIApplicationDelegate) {
        AbstractRouter().showFrom(window: app.window!!, type: MainVC.self)
    }
    
    func detailMeters(_ fromVC:UIViewController, metersData: MetersData? = nil) {
        let vc = AbstractRouter().showFrom(fromVC: fromVC, navigationType: .push, type: DetailMeterVC.self)
        vc.state = .edit
        vc.currentMetersData = metersData
    }
}
