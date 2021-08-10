//
//  PaymentViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/4.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import FormTextField

class PaymentViewController: UIViewController {

    @IBOutlet weak var yearlyConView: UIView!
    @IBOutlet weak var lblYearlyTitle: UILabel!
    @IBOutlet weak var lblYearlySub: UILabel!
    
    @IBOutlet weak var monthConView: UIView!
    @IBOutlet weak var lblMonthTitle: UILabel!
    @IBOutlet weak var lblMonthSub: UILabel!
    
    @IBOutlet weak var descConView: UIView!
    
    @IBOutlet weak var paymentConView: UIView!
    @IBOutlet weak var cardConView: UIView!
    @IBOutlet weak var nameConView: UIView!
    
    @IBOutlet weak var exConView: UIView!
    @IBOutlet weak var cvvConView: UIView!
    
    @IBOutlet weak var txtCard: FormTextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtExp: FormTextField!
    @IBOutlet weak var txtCvv: FormTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    func configureView() {
        yearlyConView.layer.borderColor = UIColor.lightGray.cgColor
        yearlyConView.backgroundColor = UIColor.white
        lblYearlyTitle.textColor = UIColor.black
        lblYearlySub.textColor = UIColor.black
        
        monthConView.layer.borderColor = UIColor.lightGray.cgColor
        monthConView.backgroundColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
        lblMonthTitle.textColor = UIColor(red: 0/255, green: 159/255, blue: 238/255, alpha: 1)
        lblMonthSub.textColor = UIColor(red: 0/255, green: 159/255, blue: 238/255, alpha: 1)
        
        descConView.layer.borderColor = UIColor.lightGray.cgColor
        
        paymentConView.layer.borderColor = UIColor.lightGray.cgColor
        cardConView.layer.borderColor = UIColor.lightGray.cgColor
        nameConView.layer.borderColor = UIColor.lightGray.cgColor
        
        exConView.layer.borderColor = UIColor.lightGray.cgColor
        cvvConView.layer.borderColor = UIColor.lightGray.cgColor
        
        txtCard.inputType = .integer
        txtCard.formatter = CardNumberFormatter()
        var validation = Validation()
        validation.maximumLength = "1234 5678 1234 5678".count
        validation.minimumLength = "1234 5678 1234 5678".count
        let characterSet = NSMutableCharacterSet.decimalDigit()
        characterSet.addCharacters(in: " ")
        validation.characterSet = characterSet as CharacterSet
        let inputValidator = InputValidator(validation: validation)
        txtCard.inputValidator = inputValidator
        
        txtExp.inputType = .integer
        txtExp.formatter = CardExpirationDateFormatter()
        var validationEx = Validation()
        validationEx.minimumLength = 1
        let inputValidatorEx = CardExpirationDateInputValidator(validation: validationEx)
        txtExp.inputValidator = inputValidatorEx
        
        txtCvv.inputType = .integer
        var validationCvv = Validation()
        validationCvv.maximumLength = "CVC".count
        validationCvv.minimumLength = "CVC".count
        validationCvv.characterSet = NSCharacterSet.decimalDigits
        let inputValidatorCvv = InputValidator(validation: validationCvv)
        txtCvv.inputValidator = inputValidatorCvv
    }
    
    @IBAction func onYear(_ sender: Any) {
        yearlyConView.backgroundColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
        lblYearlyTitle.textColor = UIColor(red: 0/255, green: 159/255, blue: 238/255, alpha: 1)
        lblYearlySub.textColor = UIColor(red: 0/255, green: 159/255, blue: 238/255, alpha: 1)
        
        monthConView.backgroundColor = UIColor.white
        lblMonthTitle.textColor = UIColor.black
        lblMonthSub.textColor = UIColor.black
    }
    
    @IBAction func onMonth(_ sender: Any) {
        yearlyConView.backgroundColor = UIColor.white
        lblYearlyTitle.textColor = UIColor.black
        lblYearlySub.textColor = UIColor.black
        
        monthConView.backgroundColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
        lblMonthTitle.textColor = UIColor(red: 0/255, green: 159/255, blue: 238/255, alpha: 1)
        lblMonthSub.textColor = UIColor(red: 0/255, green: 159/255, blue: 238/255, alpha: 1)
    }
    
    @IBAction func onClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
