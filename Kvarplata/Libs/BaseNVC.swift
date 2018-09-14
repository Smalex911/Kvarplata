//
//  BaseNVC.swift
//  Kvarplata
//
//  Created by Александр Смородов on 15.09.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import UIKit


class BaseNVC: AbstractNVC {
    
}

class AbstractNVC: UINavigationController {
    fileprivate var duringPushAnimation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        interactivePopGestureRecognizer?.delegate = self
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        duringPushAnimation = true
        
        super.pushViewController(viewController, animated: animated)
    }
}

extension AbstractNVC: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let nvc = navigationController as? AbstractNVC else { return }
        
        nvc.duringPushAnimation = false
    }
    
}

extension AbstractNVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true
        }
        return viewControllers.count > 1 && duringPushAnimation == false
    }
}
