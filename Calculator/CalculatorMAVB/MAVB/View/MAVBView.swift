//
//  MAVBView.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/3.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MAVBView: CalculatorView {
    
    var performAction: ((_ textField: UITextField) -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.inputTextField.delegate = self
        self.performButton.addTarget(self, action: #selector(performButtonAction), for: UIControl.Event.touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MAVBView: UITextFieldDelegate {
    
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        
        let currentText = textField.text as NSString?
        
        if currentText?.lowercased.contains("error") == true {
            textField.text = ""
            return true
        }
        
        if currentText?.length == 1 && currentText == "0" {
            if range.location == 1 && numbers.contains(string) {
                textField.text = ""
                return true
            }
        }
        
        return true
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.performAction?(self.inputTextField)
        return true
    }
    
    @objc internal func performButtonAction() {
        self.performAction?(self.inputTextField)
    }
}

