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
		
		let url = URL.init(string: "http://localhost:8080/calculate")!
		var request = URLRequest.init(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
		request.httpMethod = "POST"
		request.httpBody = try? JSONSerialization.data(withJSONObject:["formula" : self.formula], options: JSONSerialization.WritingOptions.init());
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			
			DispatchQueue.main.async {
				
				if let _ = error {
					self.result = "Error: Calculator server error!"
					return
				}
				
				guard let data = data else {
					self.result = "Error: Calculator server data is nil!"
					return
				}
				
				guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init()) as? [String : String] else {
					self.result = "Error: Calculator server data serialize failed!"
					return
				}
				
				self.result = jsonObject["result"] ?? "Error";
				
				completion()
			}
		}
		task.resume()
	}
}
