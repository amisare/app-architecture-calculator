//
//  CalculatorNetwork.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/4.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

struct NetworkError: Error {
	var info: String
}

struct Request<A> {
	var method: String = "GET"
	var body: Data? = nil
	let url: URL
	
	let parseResult: (Data) -> Response<A>
	
	init(url: URL, postJSON json: Any?, parse: @escaping (Any) -> Response<A>) {
		self.url = url
		self.method = "POST"
		self.body = json.map { try! JSONSerialization.data(withJSONObject: $0, options: []) }
		self.parseResult = { data in
			let json = try? JSONSerialization.jsonObject(with: data, options: [])
			return json.flatMap(parse) ?? .error(NetworkError(info: "Error: Response data parse failed!"))
		}
	}
}

extension Request {
	var request: URLRequest {
		var result = URLRequest(url: url)
		result.httpMethod = method
		if method == "POST" {
			result.httpBody = body
			result.addValue("application/json", forHTTPHeaderField: "Content-Type")
			result.addValue("application/json", forHTTPHeaderField: "Accept")
		}
		return result
	}
}

enum Response<A> {
	case error(NetworkError)
	case success(A)
	
	init(_ value: A?, or: @autoclosure () -> NetworkError) {
		if let x = value { self = .success(x) }
		else { self = .error(or()) }
	}
}

class CalculatorNetwork {

	static func request<A>(_ request: Request<A>, completion: @escaping (Response<A>) -> ()) -> URLSessionTask? {
		
		let task = URLSession.shared.dataTask(with: request.request) { (data, response, error) in
			DispatchQueue.main.async {
				if let _ = error {
					completion(.error(NetworkError.init(info: "Error: Server error!")));
				}
				else if let d = data {
					completion(request.parseResult(d))
				}
			}
		}
		task.resume()
		
		return task;
	}
}
