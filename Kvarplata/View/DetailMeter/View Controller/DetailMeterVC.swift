//
//  DetailMeterVC.swift
//  Kvarplata
//
//  Created by Александр Смородов on 31.07.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import UIKit

class DetailMeterVC: BaseVC {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonSave: UIButton!
    
    override func heightBlurHeaderView() -> CGFloat {
        return 40
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func style() {
        super.style()
        
        title = TextProvider.titleAdd()
        
        buttonSave.backgroundColor = ColorProvider.greenLight
        buttonSave.tintColor = ColorProvider.greenDark
    }
    
    override func scrollViewBase() -> UIScrollView? {
        return scrollView
    }
    
    @IBAction func saveHandler(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
