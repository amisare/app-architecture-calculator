//
//  CalcModel.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/3.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

class CalcModel {
	
	static let resultCalculated = Notification.Name("resultCalculated")
	static let resultKey = "resultKey"
	
	private(set) var formula: String = "0"
	
	var result: String = "0" {
		didSet {
			NotificationCenter.default.post(name: CalcModel.resultCalculated, object: self, userInfo: [CalcModel.resultKey: result])
		}
	}
	
	init() {
		self.result = "0";
	}
	
	func calculate(formula: String, completion: @escaping () -> ()) {
		
		self.formula = formula;
		
		CalcRequest.calculate(formula: self.formula) { (result) in
			self.result = result
			completion()
		}
	}
}
