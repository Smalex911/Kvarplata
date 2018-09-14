//
//  BaseVC.swift
//  Kvarplata
//
//  Created by Александр Смородов on 11.08.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import UIKit

class AbstractVC: UIViewController {
    
    static var className: String {
        get {
            return String(describing: self)
        }
    }
    
    private func push(childVC: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(childVC, animated: animated)
    }
    
    func showDetailMeterVC(metersData: MetersData? = nil) -> DetailMeterVC? {
        if let vc = UIStoryboard.init(name: DetailMeterVC.className, bundle: Bundle.main).instantiateViewController(withIdentifier: DetailMeterVC.className) as? DetailMeterVC {
            push(childVC: vc)
            vc.currentMetersData = metersData
            return vc
        }
        return nil
    }
    
    func scrollViewBase() -> UIScrollView? {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    @IBOutlet weak var blurNavBarView: UIView!
    @IBOutlet weak var heightBlurNavBarView: NSLayoutConstraint!
    
    func style() {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.tintColor = ColorProvider.orange
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = blurNavBarView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurNavBarView.insertSubview(blurEffectView, at: 0)
        
        heightBlurNavBarView.constant = HEIGHT_NAV_BAR + heightBlurHeaderView()
    }
    
    private var HEIGHT_NAV_BAR: CGFloat {
        get {
            return 64
        }
    }
    
    func heightBlurHeaderView() -> CGFloat {
        return 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
    }
    
    public func needHideByTap() -> Bool {
        return true
    }
    
    @objc public func hideKeyboard() {
        view.endEditing(true)
    }
    
    var m_ViewTap : UITapGestureRecognizer!
    
    var scrollViewInsets:UIEdgeInsets?
    @objc func keyboardDidShow(notification : Notification) {
        if let scrollView = self.scrollViewBase() {
            if needHideByTap() && m_ViewTap == nil {
                m_ViewTap = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(m_ViewTap)
            }
            
            if scrollViewInsets == nil {
                scrollViewInsets = scrollView.contentInset
            }
            
            let info : Dictionary = notification.userInfo!
            let kbSize : CGRect = (info[UIKeyboardFrameEndUserInfoKey] as? CGRect)!
            let _tmpView = UIView()
            
            _tmpView.frame = scrollView.frame
            
            _tmpView.isHidden = true
            scrollView.superview?.addSubview(_tmpView)
            let _scrollViewPoint = CGPoint.init(x: 0, y: _tmpView.frame.minY)
            let _convertedPoint = _tmpView.convert(_scrollViewPoint, to: nil)
            let _offset = UIScreen.main.bounds.height - _convertedPoint.y - _tmpView.frame.height - 10
            _tmpView.removeFromSuperview()
            let insets = scrollViewInsets ?? UIEdgeInsets.zero
            let contentInsets = UIEdgeInsetsMake(insets.top, insets.left, insets.bottom + kbSize.height - _offset, insets.right)
            
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, kbSize.height - _offset, 0)
        } else {
            if needHideByTap() && m_ViewTap == nil {
                m_ViewTap = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(m_ViewTap)
            }
        }
    }
    
    @objc func keyboardDidHide(notification : Notification) {
        if needHideByTap() {
            if m_ViewTap != nil {
                view.removeGestureRecognizer(m_ViewTap)
            }
            m_ViewTap = nil
        }
        
        if let scrollView = scrollViewBase() {
            UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { [unowned self, unowned scrollView] in
                scrollView.contentInset = self.scrollViewInsets ?? UIEdgeInsets.zero
                scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
            })
        }
    }
}

class BaseVC: AbstractVC {
    
}
