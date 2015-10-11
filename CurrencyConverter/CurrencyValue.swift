//
//  CurrencyValue.swift
//  CurrencyConverter
//
//  Created by Jithesh V K on 11/10/2015.
//  Copyright © 2015 Jithesh V K. All rights reserved.
//
//  Class to get the currency value from Fixer.io
//

import Foundation

class CurrencyValue {
    //MARK: Properties
    var baseCurrency: String
    var currencyRates: [String:Double]
    
    //MARK: Initializer
    init(baseCurrency: String){
        self.baseCurrency = baseCurrency
        self.currencyRates = [String:Double]()
    }
    
    //MARK: member functions
    func fetchCurrentCurrencyValue() {
        let urlAsString = "http://api.fixer.io/latest?base=AUD&symbols=CAD,EUR,GBP,JPY,USD"
        let data = NSData(contentsOfURL: NSURL(string: urlAsString)!)
        var jsonData: NSDictionary
        
        do {
            jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
            //Fetch only the rates from the Dictionary returned
            //eg. {"base":"AUD","date":"2015-10-09","rates":{"CAD":0.94814,"GBP":0.47781,"JPY":88.15,"USD":0.73294,"EUR":0.64508}}
            currencyRates = jsonData["rates"] as! [String:Double]

        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func calculateRate(currencyType:String, toConvertValue:Double) -> Double{
        let finalValue = toConvertValue * (currencyRates[currencyType]!)
        return finalValue
    }
};