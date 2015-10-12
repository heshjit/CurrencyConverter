//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Jithesh V K on 11/10/2015.
//  Copyright © 2015 Jithesh V K. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CustomPickerViewDeledate {

    //MARK: Properties

    @IBOutlet weak var currencyInputTextField: UITextField!
    @IBOutlet weak var currencyOutputLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: CustomPickerView!
    
    let currency = CurrencyValue(baseCurrency: "AUD")
    var toConvertCurrencyType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currencyPicker.delegate = self
        toConvertCurrencyType = currencyPicker.selectedCurrency
        print("currency type \(toConvertCurrencyType)")

        currency.fetchCurrentCurrencyValue()

        currencyInputTextField.addTarget(self, action: "ConvertValue", forControlEvents: .EditingDidEndOnExit)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: CustomPickerViewDeledate delegate functions
    func currencyTypeDidChange() {
        toConvertCurrencyType = currencyPicker.selectedCurrency
        print("FRom delegate \(toConvertCurrencyType)")
        ConvertValue()
    }
    
    //MARK: Actions
    func ConvertValue(){
        //let input = currencyInputTextField.text
        
        if (currencyInputTextField.text!.isEmpty){
            print("Empty Text box")
        }
        else {
            let convertedValueAsString = currency.calculateRate(toConvertCurrencyType,toConvertValue: Double(currencyInputTextField.text!)!)
            print(convertedValueAsString)
            
            let _currencyFormatter : NSNumberFormatter = NSNumberFormatter()
            _currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            _currencyFormatter.currencyCode = toConvertCurrencyType
            let convertValueWithFormat = _currencyFormatter.stringFromNumber(convertedValueAsString)
            print(convertValueWithFormat)
            currencyOutputLabel.text = convertValueWithFormat
        }
    }
}

