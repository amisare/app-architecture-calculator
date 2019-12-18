//
//  MVVMViewModel.swift
//  CalculatorMVVM
//
//  Created by 顾海军 on 2019/12/18.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

class MVVMViewModel: NSObject {
    var observers = [NSObjectProtocol]()
    let model: MVVMBrain
    @objc dynamic var textFieldValue: String
    
    init(model: MVVMBrain) {
        self.model = model
        textFieldValue = model.result.value
        super.init()
        self.setupEvents()
    }
    
    private func setupEvents() {
        self.observers += [NotificationCenter.default.addObserver(forName: CalculatorBrainNotification.calculateComplete, object: nil, queue: nil) { (note) in
            let result = note.userInfo?[CalculatorBrainKey.calculateValue] as? CalculatorResult
            self.textFieldValue = result?.value ?? "0"
            }]
        
        self.observers += [NotificationCenter.default.addObserver(forName: CalculatorBrainNotification.calculateError, object: nil, queue: nil) { (note) in
            self.textFieldValue = note.userInfo?[CalculatorBrainKey.calculateError] as? String ?? "Error"
            }]
    }
    
    func calculate(formula: String, completion: @escaping () -> ()) {
        self.model.calculate(formula: formula) {
            completion()
        }
    }
    
    deinit {
        for observer in self.observers {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
