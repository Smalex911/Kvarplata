//
//  MainCell.swift
//  Kvarplata
//
//  Created by Александр Смородов on 22.07.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var coldKitchenLabel: UILabel!
    @IBOutlet weak var hotKitchenLabel: UILabel!
    @IBOutlet weak var coldBathLabel: UILabel!
    @IBOutlet weak var hotBathLabel: UILabel!
    @IBOutlet weak var light1Label: UILabel!
    @IBOutlet weak var light2Label: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    var metersData: MetersData! {
        didSet{
            monthLabel.text = TextProvider.getMonthTitle(metersData.month)
            coldKitchenLabel.text = TextProvider.roundTwoSymbols(metersData.cold_kitchen)
            hotKitchenLabel.text = TextProvider.roundTwoSymbols(metersData.hot_kitchen)
            coldBathLabel.text = TextProvider.roundTwoSymbols(metersData.cold_bath)
            hotBathLabel.text = TextProvider.roundTwoSymbols(metersData.hot_bath)
            light1Label.text = TextProvider.roundTwoSymbols(metersData.light_1)
            light2Label.text = TextProvider.roundTwoSymbols(metersData.light_2)
        }
    }
}
