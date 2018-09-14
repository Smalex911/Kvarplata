//
//  DetailMeterVC.swift
//  Kvarplata
//
//  Created by Александр Смородов on 31.07.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import UIKit
import MessageUI

class DetailMeterVC: BaseVC {
    
    @IBOutlet weak var buttonLoadLastSave: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelMonth: UILabel!
    @IBOutlet weak var stepperMonth: UIStepper!
    
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
    
    @IBOutlet weak var buttonSend: UIButton!
    
    var lastMetersData: MetersData?
    
    override func heightBlurHeaderView() -> CGFloat {
        return 40
    }
    
    var (currentMonth, currentYear) = TextProvider.getCurrentMonthAndYear()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelYear.text = "\(currentYear)"
        labelMonth.text = TextProvider.getMonthTitle(Int64(currentMonth))
        stepperMonth.value = Double(currentMonth)
        
        labelWaterKitchenColdOldTitle.text = ""
        labelWaterKitchenHotOldTitle.text = ""
        labelWaterBathColdOldTitle.text = ""
        labelWaterBathHotOldTitle.text = ""
        labelLightT1OldTitle.text = ""
        labelLightT2OldTitle.text = ""
    }
    
    override func style() {
        super.style()
        
        let barButtonItem = UIBarButtonItem(title: TextProvider.save(), style: .done, target: self, action: #selector(saveHandler))
        navigationItem.setRightBarButton(barButtonItem, animated: false)
        
        buttonSend.backgroundColor = ColorProvider.greenLight
        buttonSend.tintColor = ColorProvider.greenDark
        
        for textField in textFields {
            textField.keyboardType = .decimalPad
            textField.delegate = self
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
    
    @IBAction func stepperMonthHandler(_ stepper: UIStepper) {
        if stepper.value < 1 {
            stepper.value = 12
            currentYear -= 1
            labelYear.text = "\(currentYear)"
        } else if stepper.value > 12 {
            stepper.value = 1
            currentYear += 1
            labelYear.text = "\(currentYear)"
        }
        labelMonth.text = TextProvider.getMonthTitle(Int64(stepper.value))
    }
    
    @IBAction func stepperValueChangedHandler(_ stepper: UIStepper) {
        if let textField = textFields.first(where: {$0.tag == stepper.tag}) {
            textField.text = TextProvider.roundTwoSymbols(stepper.value)
            textField.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func sendHandler(_ sender: Any) {
        sendEmail()
    }
    
    @objc func saveHandler() {
        let md = MetersData()
        md.year = Int64(currentYear)
        md.month = Int64(currentMonth)
        md.cold_kitchen = textFieldWaterKitchenCold.value()
        md.hot_kitchen = textFieldWaterKitchenHot.value()
        md.cold_bath = textFieldWaterBathCold.value()
        md.hot_bath = textFieldWaterBathHot.value()
        md.light_1 = textFieldLightT1.value()
        md.light_2 = textFieldLightT2.value()
        md.creation_date = Int64(Date().timeIntervalSince1970)
        
        MetersDataInteractor.add(md: md)
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailMeterVC: MFMailComposeViewControllerDelegate {
    
    func sendEmail() {
        let t1ToSave = textFieldLightT1.value()
        let t2ToSave = textFieldLightT1.value()
        let kcToSave = textFieldWaterKitchenCold.value()
        let bcToSave = textFieldWaterBathCold.value()
        let khToSave = textFieldWaterKitchenHot.value()
        let bhToSave = textFieldWaterBathHot.value()
        
        let compiledTextMessage = { () -> String in
            var message = "\(GlobalSettings.fioSender), кв.\(GlobalSettings.flatNumber)"
            message += "<br>"
            if let t1 = self.textFieldLightT1.text, t1 != "", t1ToSave != nil {
                message += "<br>T1: \(t1)"
            }
            if let t2 = self.textFieldLightT2.text, t2 != "", t2ToSave != nil {
                message += "<br>T2: \(t2)"
            }
            if !self.textFieldLightT1.isNullOrEmpty() || !self.textFieldLightT2.isNullOrEmpty() {
                message += "<br>"
            }
            if let kc = self.textFieldWaterKitchenCold.text, kc != "", kcToSave != nil {
                message += "<br>ХВС кухня: \(kc)"
            }
            if let bc = self.textFieldWaterBathCold.text, bc != "", bcToSave != nil {
                message += "<br>ХВС ванная: \(bc)"
            }
            if let kh = self.textFieldWaterKitchenHot.text, kh != "", khToSave != nil {
                message += "<br>ГВС кухня: \(kh)"
            }
            if let bh = self.textFieldWaterBathHot.text, bh != "", bhToSave != nil {
                message += "<br>ГВС ванная: \(bh)"
            }
            return message
        }
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([GlobalSettings.mailRecipient])
            mail.setSubject(GlobalSettings.topic)
            mail.setMessageBody(compiledTextMessage(), isHTML: true)
            
            present(mail, animated: true)
        } else {
            let alert = UIAlertController(title: TextProvider.alertNotSendTitle(), message: TextProvider.alertNotSendMsg(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: TextProvider.great(), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        
        if result == .sent {
            let alert = UIAlertController(title: TextProvider.alertSendedTitle(), message: TextProvider.alertSendedMsg(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: TextProvider.ok(), style: .default) { [weak self] (alert) in
                self?.saveHandler()
                self?.navigationController?.popViewController(animated: true)
            })
            self.present(alert, animated: true, completion: nil)
        } else if result == .failed {
            let alert = UIAlertController(title: TextProvider.alertNotSendTitle(), message: TextProvider.alertSendErrorMsg(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: TextProvider.great(), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension DetailMeterVC: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.value() != nil {
            textField.backgroundColor = UIColor.white
        } else {
            textField.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        }
        
        if let stepper = steppers.first(where: {$0.tag == textField.tag}) {
            stepper.value = textField.value() ?? lastMetersData?.meters[textField.tag] ?? 0
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
