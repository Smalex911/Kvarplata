//
//  DetailMeterVC.swift
//  Kvarplata
//
//  Created by Александр Смородов on 31.07.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import UIKit

class DetailMeterVC: BaseVC {
    
    @IBOutlet weak var buttonLoadLastSave: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var labelWaterKitchenTitle: UILabel!
    @IBOutlet weak var labelWaterKitchenColdOldTitle: UILabel!
    @IBOutlet weak var labelWaterKitchenHotOldTitle: UILabel!
    @IBOutlet weak var labelWaterKitchenColdTitle: UILabel!
    @IBOutlet weak var labelWaterKitchenHotTitle: UILabel!
    @IBOutlet weak var textFieldWaterKitchenCold: UITextField!
    @IBOutlet weak var textFieldWaterKitchenHot: UITextField!
    @IBOutlet weak var stepperWaterKitchenCold: UIStepper!
    @IBOutlet weak var stepperWaterKitchenHot: UIStepper!
    
    @IBOutlet weak var labelWaterBathTitle: UILabel!
    @IBOutlet weak var labelWaterBathColdOldTitle: UILabel!
    @IBOutlet weak var labelWaterBathHotOldTitle: UILabel!
    @IBOutlet weak var labelWaterBathColdTitle: UILabel!
    @IBOutlet weak var labelWaterBathHotTitle: UILabel!
    @IBOutlet weak var textFieldWaterBathCold: UITextField!
    @IBOutlet weak var textFieldWaterBathHot: UITextField!
    @IBOutlet weak var stepperWaterBathCold: UIStepper!
    @IBOutlet weak var stepperWaterBathHot: UIStepper!
    
    @IBOutlet weak var labelLightTitle: UILabel!
    @IBOutlet weak var labelLightT1OldTitle: UILabel!
    @IBOutlet weak var labelLightT2OldTitle: UILabel!
    @IBOutlet weak var labelLightT1Title: UILabel!
    @IBOutlet weak var labelLightT2Title: UILabel!
    @IBOutlet weak var textFieldLightT1: UITextField!
    @IBOutlet weak var textFieldLightT2: UITextField!
    @IBOutlet weak var stepperLightT1: UIStepper!
    @IBOutlet weak var stepperLightT2: UIStepper!
    
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var steppers: [UIStepper]!
    
    @IBOutlet weak var buttonSave: UIButton!
    
    var lastMetersData: MetersData?
    
    override func heightBlurHeaderView() -> CGFloat {
        return 40
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelWaterKitchenColdOldTitle.text = ""
        labelWaterKitchenHotOldTitle.text = ""
        labelWaterBathColdOldTitle.text = ""
        labelWaterBathHotOldTitle.text = ""
        labelLightT1OldTitle.text = ""
        labelLightT2OldTitle.text = ""
    }
    
    override func style() {
        super.style()
        
        title = TextProvider.titleAdd()
        
        buttonSave.backgroundColor = ColorProvider.greenLight
        buttonSave.tintColor = ColorProvider.greenDark
        
        for textField in textFields {
            textField.keyboardType = .decimalPad
        }
        
        for stepper in steppers {
            stepper.stepValue = GlobalSettings.StepValue
        }
    }
    
    override func scrollViewBase() -> UIScrollView? {
        return scrollView
    }
    
    @IBAction func loadLastSaveHandler(_ sender: Any) {
        if let md = MetersDataInteractor.getLast() {
            lastMetersData = md
            
            fillLastValue(isValue: true)
            
            textFieldWaterKitchenCold.text = TextProvider.roundTwoSymbols(md.cold_kitchen)
            stepperWaterKitchenCold.value = md.cold_kitchen ?? 0
            textFieldWaterKitchenHot.text = TextProvider.roundTwoSymbols(md.hot_kitchen)
            stepperWaterKitchenHot.value = md.hot_kitchen ?? 0
            
            textFieldWaterBathCold.text = TextProvider.roundTwoSymbols(md.cold_bath)
            stepperWaterBathCold.value = md.cold_bath ?? 0
            textFieldWaterBathHot.text = TextProvider.roundTwoSymbols(md.hot_bath)
            stepperWaterBathHot.value = md.hot_bath ?? 0
            
            textFieldLightT1.text = TextProvider.roundTwoSymbols(md.light_1)
            stepperLightT1.value = md.light_1 ?? 0
            textFieldLightT2.text = TextProvider.roundTwoSymbols(md.light_2)
            stepperLightT2.value = md.light_2 ?? 0
        }
    }
    
    func fillLastValue(isValue: Bool) {
        if let md = lastMetersData {
            if isValue {
                labelWaterKitchenColdOldTitle.text = TextProvider.roundTwoSymbols(md.cold_kitchen)
                labelWaterKitchenHotOldTitle.text = TextProvider.roundTwoSymbols(md.hot_kitchen)
                labelWaterBathColdOldTitle.text = TextProvider.roundTwoSymbols(md.cold_bath)
                labelWaterBathHotOldTitle.text = TextProvider.roundTwoSymbols(md.hot_bath)
                labelLightT1OldTitle.text = TextProvider.roundTwoSymbols(md.light_1)
                labelLightT2OldTitle.text = TextProvider.roundTwoSymbols(md.light_2)
            } else {
                
            }
        }
    }
    
    @IBAction func stepperValueChangedHandler(_ sender: Any) {
        if let stepper = sender as? UIStepper {
            switch stepper {
            case stepperWaterKitchenCold:
                textFieldWaterKitchenCold.text = TextProvider.roundTwoSymbols(stepper.value)
                break
            case stepperWaterKitchenHot:
                textFieldWaterKitchenHot.text = TextProvider.roundTwoSymbols(stepper.value)
                break
            case stepperWaterBathCold:
                textFieldWaterBathCold.text = TextProvider.roundTwoSymbols(stepper.value)
                break
            case stepperWaterBathHot:
                textFieldWaterBathHot.text = TextProvider.roundTwoSymbols(stepper.value)
                break
            case stepperLightT1:
                textFieldLightT1.text = TextProvider.roundTwoSymbols(stepper.value)
                break
            case stepperLightT2:
                textFieldLightT2.text = TextProvider.roundTwoSymbols(stepper.value)
                break
            default:
                break
            }
        }
    }
    
    @IBAction func saveHandler(_ sender: Any) {
        let md = MetersData()
        md.year = 2018
        md.month = 8
        md.cold_kitchen = Double(textFieldWaterKitchenCold.text ?? "")
        md.hot_kitchen = Double(textFieldWaterKitchenCold.text ?? "")
        md.cold_bath = Double(textFieldWaterBathCold.text ?? "")
        md.hot_bath = Double(textFieldWaterBathHot.text ?? "")
        md.light_1 = Double(textFieldLightT1.text ?? "")
        md.light_2 = Double(textFieldLightT2.text ?? "")
        md.creation_date = Int64(Date().timeIntervalSince1970)
        
        MetersDataInteractor.add(md: md)
        
        self.navigationController?.popViewController(animated: true)
    }
}
