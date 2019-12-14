//
//  CalculatorRequest.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/4.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

class CalculatorRequest: NSObject {
	
	static func calculate(formula: String, completion: @escaping (_ result: Response<CalculatorResult>) -> ()) {
		
		let url = URL.init(string: "http://localhost:8080/calculate")!
		let params = ["formula" : formula];
		
		let request = Request.init(url: url, postJSON: params) { (responseJSON) -> Response<CalculatorResult> in
            if let value = (responseJSON as? [String : String])?["result"] {
                return .success(CalculatorResult.init(value: value))
            }
            else {
                return .error(NetworkError.init(info: "Error: Response data error!"))
            }
		}
		
		_ = CalculatorNetwork.request(request, completion: { (response) in
            return completion(response)
		})
	}
}
