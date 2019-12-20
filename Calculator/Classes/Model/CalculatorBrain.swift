//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/3.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

struct CalculatorBrainNotification {
    static let calculateComplete = Notification.Name("CalculateComplete")
    static let calculateError = Notification.Name("CalculateError")
}

struct CalculatorBrainKey {
    static let calculateValue = "CalculateValueKey"
    static let calculateError = "CalculateError"
}

public class CalculatorBrain: NSObject {
	
	private(set) var formula: String = "0"
	
    var result: CalculatorResult {
		didSet {
            NotificationCenter.default.post(name: CalculatorBrainNotification.calculateComplete, object: self, userInfo: [CalculatorBrainKey.calculateValue: result])
		}
	}
	
    override init() {
		self.result = CalculatorResult.init(value: "0");
        super.init()
	}
	
	func calculate(formula: String, completion: @escaping () -> ()) {
		
		self.formula = formula;
		
		CalculatorRequest.calculate(formula: self.formula) { (result) in
            if case let .error(error) = result {
                NotificationCenter.default.post(name: CalculatorBrainNotification.calculateError, object: self, userInfo: [CalculatorBrainKey.calculateError: error.info])
            }
            if case let .success(result) = result {
                self.result = result
            }
			completion()
		}
	}
}
