//
//  TEAModel.swift
//  CalculatorTEA-CK
//
//  Created by GuHaijun on 2019/12/20.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

@objc public class TEAModel: NSObject {
    
    @objc private var observers = [NSObjectProtocol]()
    @objc private var brain = TEABrain.init()

    @objc public var textInputValue = "0"
    @objc public var result = "0" {
        didSet {
            self.textInputValue = self.result
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "calculateCompleteResult"), object: nil)
        }
    }
    
    @objc public func calculate(formula: String, completion: @escaping () -> ()) {
        self.brain.calculate(formula: formula) {
            completion()
        }
    }
    
    @objc public override init() {
        super.init()
        self.setupEvents()
    }

    private func setupEvents() {
        self.observers += [NotificationCenter.default.addObserver(forName: CalculatorBrainNotification.calculateComplete, object: nil, queue: nil) { (note) in
            let result = (note.userInfo?[CalculatorBrainKey.calculateValue] as? CalculatorResult)?.value ?? "0"
            self.result = result
            }]

        self.observers += [NotificationCenter.default.addObserver(forName: CalculatorBrainNotification.calculateError, object: nil, queue: nil) { (note) in
            let result = note.userInfo?[CalculatorBrainKey.calculateError] as? String ?? "Error"
            self.result = result
            }]
    }

    @objc deinit {
        for observer in self.observers {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
