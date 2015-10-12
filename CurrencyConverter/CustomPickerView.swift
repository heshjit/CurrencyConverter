//
//  CustomPickerView.swift
//  CurrencyConverter
//
//  Created by Jithesh V K on 11/10/2015.
//  Copyright © 2015 Jithesh V K. All rights reserved.
//

import UIKit

protocol CustomPickerViewDeledate{
    func currencyTypeDidChange()
}

class CustomPickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {

    var currencyArray :[String] = []
    var selectedCurrency = "GBP"
    var pickerView = UIPickerView()
    var topIndicatorImageView = UIImageView()
    var bottomIndicatorImageView = UIImageView()
    
    //MARK: Delegate
    var delegate: CustomPickerViewDeledate? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Creating picker view
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = false
        pickerView.userInteractionEnabled = true
        pickerView.backgroundColor = UIColor(red: 0.263, green: 0.753, blue: 0.48, alpha: 1)
        var rotate: CGAffineTransform = CGAffineTransformMakeRotation(3.14/2)
        rotate = CGAffineTransformScale(rotate, 0.1, 0.8)
        pickerView.center = CGPointMake(160,75)//(centerOfViewX, centerOfViewY)
        pickerView.selectRow(2, inComponent: 0, animated: false)
        pickerView.transform = rotate
        addSubview(pickerView)
        
        //Create indicator images
        topIndicatorImageView.image = UIImage(named: "IndicatorTop")!
        bottomIndicatorImageView.image = UIImage(named: "IndicatorBottom")!
        addSubview(topIndicatorImageView)
        addSubview(bottomIndicatorImageView)
    }

    func assignDelegate(withDelegat delegate: CustomPickerViewDeledate, currencyFetchList currencyList: [String]){
        self.delegate = delegate
        self.currencyArray = currencyList
    }
    
    override func layoutSubviews() {
        pickerView.frame = CGRect(x: 0, y: 5, width: frame.size.width, height: frame.size.height-10)
        topIndicatorImageView.frame = CGRect(x: frame.size.width/2-7, y: 0, width: 20, height: 14)
        bottomIndicatorImageView.frame = CGRect(x: frame.size.width/2-7, y: frame.size.height-14, width: 20, height: 14)
    }
    
    override func intrinsicContentSize() -> CGSize {
        return self.frame.size
    }
    
    //MARK: PickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    //MARK: PickerView Delegate
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.frame.size.height
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        let frameWidth = Int(self.frame.size.width)
        let width = (frameWidth)/2
        return CGFloat(width)
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        label.text = currencyArray[row]
        
        let boldHelviticaFont = UIFont(name: "Helvetica", size: 56)?.fontDescriptor().fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitBold)
        label.font = UIFont(descriptor: boldHelviticaFont!, size: 56)
        
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        label.numberOfLines = 1
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.backgroundColor = UIColor.clearColor()
        label.clipsToBounds = true
        var rotateItem: CGAffineTransform = CGAffineTransformMakeRotation(-3.14/2)
        rotateItem = CGAffineTransformScale(rotateItem, 1, 10)
        label.transform = rotateItem
        
        return label
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = currencyArray[row]
        if delegate != nil{
            delegate?.currencyTypeDidChange()
        }
    }

}
