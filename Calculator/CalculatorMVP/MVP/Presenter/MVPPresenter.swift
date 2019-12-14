//
//  MVPPresenter.swift
//  CalculatorMVP
//
//  Created by GuHaijun on 2019/12/14.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

protocol MVPViewProtocol: class {
    var textFieldValue: String? { get set }
}

class MVPPresenter: NSObject {
    
    var model = MVPBrain.init()
    weak var view: MVPViewProtocol?
    var observers = [NSObjectProtocol]()
    
    init(model: MVPBrain, view: MVPViewProtocol) {
        super.init()
        self.model = model
        self.view = view
        self.setupEvents()
        self.setupStates()
    }
    
    private func setupEvents() {
        self.observers += [NotificationCenter.default.addObserver(forName: CalculatorBrainNotification.calculateComplete, object: nil, queue: nil) { [view] (note) in
            let result = note.userInfo?[CalculatorBrainKey.calculateValue] as? CalculatorResult
            view?.textFieldValue = result?.value
            }]
        
        self.observers += [NotificationCenter.default.addObserver(forName: CalculatorBrainNotification.calculateError, object: nil, queue: nil) { [view] (note) in
            view?.textFieldValue = note.userInfo?[CalculatorBrainKey.calculateError] as? String
            }]
    }
    
    private func setupStates() {
        view?.textFieldValue = model.result.value;
    }
    
    
    func calculate(completion: @escaping () -> ()) {
        let formula = view?.textFieldValue ?? "0"
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
