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
    
    let currencyArray:[String] = ["CAD", "EUR", "GBP", "JPY", "USD"]
    
    let currency = CurrencyValue(baseCurrency: "AUD")
    var toConvertCurrencyType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initializing the Custom Picker View with delegate and currecy array
        currencyPicker.assignDelegate(withDelegat: self, currencyFetchList: currencyArray)
        
        //Initially toring picker selected currency type locally
        toConvertCurrencyType = currencyPicker.selectedCurrency
        
        //Fetching rates for all the currency in array wrt base type "AUD"
        currency.fetchCurrentCurrencyValue(forFetchList: currencyArray)

        //To fetch and display rates once the user finishes entering value in the text box
        currencyInputTextField.addTarget(self, action: "ConvertValue", forControlEvents: .EditingDidEndOnExit)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: CustomPickerViewDeledate delegate functions
    func currencyTypeDidChange() {
        
        //User moved the picker and selected new currency type.
        toConvertCurrencyType = currencyPicker.selectedCurrency
        
        //Recalculate the converted value for selected type
        ConvertValue()
    }
    
    //MARK: Actions
    func ConvertValue(){
        
        if (currencyInputTextField.text!.isEmpty){
            print("Empty Text box")
        }
        else {
            let convertedValueAsString = currency.calculateRate(forType: toConvertCurrencyType, fromValue: Double(currencyInputTextField.text!)!)
            
            //To Format the calculated value as per the currency type
            let _currencyFormatter : NSNumberFormatter = NSNumberFormatter()
            _currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            _currencyFormatter.currencyCode = toConvertCurrencyType
            let convertValueWithFormat = _currencyFormatter.stringFromNumber(convertedValueAsString)
            currencyOutputLabel.text = convertValueWithFormat
        }
    }
}

