//
//  MVVMView.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/3.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MVVMView: CalculatorView {
    
    var perform: Observable<String?>?
    private var performReturn: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.inputTextField.delegate = self
        self.setupEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupEvents() {
        perform = Observable.of(
            self.performButton.rx.tap
                .flatMapLatest({ (_) -> Observable<String?> in
                    return Observable.just(self.inputTextField.text)
                }),
            self.performReturn.asObservable())
            .merge()
    }
}

extension MVVMView: UITextFieldDelegate {
    
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
        self.performReturn.accept(textField.text)
        return true
    }
}

