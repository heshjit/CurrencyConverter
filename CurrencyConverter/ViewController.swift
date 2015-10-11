//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Jithesh V K on 11/10/2015.
//  Copyright © 2015 Jithesh V K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var convertFromTextField: UITextField!
    @IBOutlet weak var convertedValueLabel: UILabel!

    
    let currency = CurrencyValue(baseCurrency: "AUD")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        currency.fetchCurrentCurrencyValue()

        convertFromTextField.addTarget(self, action: "ConvertValue", forControlEvents: .EditingDidEndOnExit)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    func ConvertValue(){
        let input = convertFromTextField.text
        let currencyType = "EUR"
        let convertedValueAsString = currency.calculateRate(currencyType,toConvertValue: Double(input!)!)
        print(convertedValueAsString)
        
        let _currencyFormatter : NSNumberFormatter = NSNumberFormatter()
        _currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        _currencyFormatter.currencyCode = currencyType
        let convertValueWithFormat = _currencyFormatter.stringFromNumber(convertedValueAsString)
        print(convertValueWithFormat)
        convertedValueLabel.text = convertValueWithFormat
    }
}

