//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Jithesh V K on 11/10/2015.
//  Copyright © 2015 Jithesh V K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let currency = CurrencyValue(baseCurrency: "AUD")
        currency.fetchCurrentCurrencyValue()
        //print(currency.calculateRate("EUR"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

