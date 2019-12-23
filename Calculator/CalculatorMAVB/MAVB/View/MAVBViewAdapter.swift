//
//  MAVBViewAdapter.swift
//  CalculatorMAVB
//
//  Created by 顾海军 on 2019/12/23.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MAVBViewAdapter {
    
    let disposeBag = DisposeBag.init()
    
    private var view: MAVBView
    private var performReturn: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    var showValue: BehaviorRelay<String?> = BehaviorRelay(value: "0")
    var perform: BehaviorRelay<String?> = BehaviorRelay(value: "0")
    
    init(view: MAVBView) {
        self.view = view
        self.setupEvents()
    }
    
    private func setupEvents() {
        self.view.performAction = { [weak self] (textField) in
            if let self = self {
                self.perform.accept(textField.text)
            }
        }
        self.showValue.subscribe(onNext: { (value) in
            self.view.inputTextField.text = value
        }).disposed(by: disposeBag)
    }
    
}
