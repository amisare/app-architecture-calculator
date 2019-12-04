//
//  CalcRequest.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/4.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

class CalcRequest: NSObject {
	
	static func calculate(formula: String, completion: @escaping (_ result: String) -> ()) {
		
		let url = URL.init(string: "http://localhost:8080/calculate")!
		let params = ["formula" : formula];
		
		let request = Request.init(url: url, postJSON: params) { (responseJSON) -> Response<String> in
			if let result = (responseJSON as? [String : String])?["result"] {
				return .success(result)
			}
			else {
				return .error(ParseError.init(info: "Error"))
			}
		}
		
		_ = CalcNetworking.request(request, completion: { (response) in
			if case let .error(e) = response {
				completion(e.info);
			}
			if case let .success(result) = response {
				completion(result);
			}
		})
	}
}
