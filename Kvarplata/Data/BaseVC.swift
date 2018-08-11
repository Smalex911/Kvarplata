//
//  BaseVC.swift
//  Kvarplata
//
//  Created by Александр Смородов on 11.08.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    static var className: String {
        get {
            return String(describing: self)
        }
    }
    
    private func push(childVC: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(childVC, animated: animated)
    }
    
    func showDetailMeterVC() -> DetailMeterVC? {
        if let vc = UIStoryboard.init(name: DetailMeterVC.className, bundle: Bundle.main).instantiateViewController(withIdentifier: DetailMeterVC.className) as? DetailMeterVC {
            push(childVC: vc)
            return vc
        }
        return nil
    }
}
