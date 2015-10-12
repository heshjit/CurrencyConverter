//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Jithesh V K on 11/10/2015.
//  Copyright © 2015 Jithesh V K. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CustomPickerViewDeledate, UITextFieldDelegate {

    //MARK: Properties

    @IBOutlet weak var currencyInputTextField: UITextField!
    @IBOutlet weak var currencyOutputLabel: UILabel!
    @IBOutlet weak var currencyPicker: CustomPickerView!
    
    let currencyArray:[String] = ["CAD", "EUR", "GBP", "JPY", "USD"]
    
    let currency = CurrencyValue(baseCurrency: "AUD")
    var toConvertCurrencyType = ""
    var currentString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyInputTextField.delegate = self
        
        //Initializing the Custom Picker View with delegate and currecy array
        currencyPicker.assignDelegate(withDelegat: self, currencyFetchList: currencyArray)
        
        //Initially toring picker selected currency type locally
        toConvertCurrencyType = currencyPicker.selectedCurrency
        
        //Fetching rates for all the currency in array wrt base type "AUD"
        currency.fetchCurrentCurrencyValue(forFetchList: currencyArray)

        //To fetch and display rates once the user finishes entering value in the text box
        currencyInputTextField.addTarget(self, action: "convertValue", forControlEvents: .EditingDidEndOnExit)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: CustomPickerViewDeledate delegate functions
    func currencyTypeDidChange() {
        
        //User moved the picker and selected new currency type.
        toConvertCurrencyType = currencyPicker.selectedCurrency
        
        //Recalculate the converted value for selected type
        convertValue()
    }
    
    //MARK: Actions
    func convertValue(){
        
        if (currencyInputTextField.text!.isEmpty){
            print("Empty Text box")
        }
        else {
            let convertedValueAsDecimal = currency.calculateRate(forType: toConvertCurrencyType, fromValue: Double(currentString)!)

            //To Format the calculated value as per the currency type
            currencyOutputLabel.text = formatCurrency(convertedValueAsDecimal, toType: toConvertCurrencyType)
        }
        
    }
    
    func formatCurrency(inputDecimal:NSNumber, toType:String)->String{
        let _currencyFormatter : NSNumberFormatter = NSNumberFormatter()
        _currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        _currencyFormatter.currencyCode = toType
        let convertValueWithFormat = _currencyFormatter.stringFromNumber(inputDecimal)
        return convertValueWithFormat!
    }
    
    //MARK: TextField Delegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool { // return NO to not change text

        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            currentString += string
            textField.text = formatCurrency(Double(currentString)!, toType: "AUD")
        
        case ".":
            if(!(currentString.rangeOfString(".") != nil)){
                currentString += string
            }
            textField.text = formatCurrency(Double(currentString)!, toType: "AUD")
            
        default:
            var _ = "" //dummy
        }
        return false
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        convertValue()
        textField.resignFirstResponder()
        return true
    }
}

