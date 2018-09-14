//
//  AbstractRouter.swift
//  Kvarplata
//
//  Created by Александр Смородов on 15.09.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import UIKit

enum NavigationType {
    case push, modal, pushFade, pushInstantly
}

class AbstractRouter {
    
    public func extract<T:UIViewController>(type: T.Type) -> T {
        let name = String(describing: type)
        let sb = UIStoryboard.init(name: name, bundle: nil)
        return sb.instantiateViewController(withIdentifier: name) as! T
    }
    
    func clearNavigationHistory(vc:UIViewController) {
        DispatchQueue.main.async {
            if let vcArr = vc.navigationController?.viewControllers {
                if vcArr.first != vc {
                    vc.navigationController?.viewControllers = [vc]
                }
            }
        }
    }
    
    @discardableResult func showFrom<T:UIViewController>(fromVC:UIViewController, navigationType: NavigationType, vc: T) -> T {
        
        switch navigationType {
        case .push:
            fromVC.navigationController?.pushViewController(vc, animated: true)
            return vc
        case .pushInstantly:
            fromVC.navigationController?.pushViewController(vc, animated: false)
            return vc
        case .pushFade:
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = kCATransitionFade
            transition.subtype = kCATransitionFromTop
            
            fromVC.navigationController?.view.layer.add(transition, forKey: kCATransition)
            fromVC.navigationController?.pushViewController(vc, animated: false)
            return vc
        case .modal:
            let nvc = BaseNVC(rootViewController: vc)
            fromVC.present(nvc, animated: true, completion: { })
            return vc
        }
    }
    
    @discardableResult func showFrom<T:UIViewController>(fromVC:UIViewController, navigationType: NavigationType, type: T.Type) -> T {
        
        let vc = extract(type: type)
        
        return showFrom(fromVC: fromVC, navigationType: navigationType, vc: vc)
    }
    
    
    func showFrom<T:UIViewController>(window:UIWindow, type: T.Type) {
        let vc = extract(type: type)
        let nvc = BaseNVC(rootViewController: vc)
        window.rootViewController = nvc
        window.makeKeyAndVisible()
    }
    
    @discardableResult func showModal<T:UIViewController>(fromVC:UIViewController, type: T.Type) -> T {
        let vc = extract(type: type)
        let nvc = BaseNVC(rootViewController: vc)
        nvc.modalPresentationStyle = .custom
        nvc.modalTransitionStyle = .crossDissolve
        fromVC.present(nvc, animated: false, completion: {
            
            UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                vc.view.alpha = 1
            }, completion: { (_: Bool) in
                vc.view.isUserInteractionEnabled = true
            })
            
        })
        return vc
    }
}
