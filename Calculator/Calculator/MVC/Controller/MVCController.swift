//
//  MVCController.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/3.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

class MVCController: UIViewController {
	
	var model = MVCModel.init()
	var observer : NSObjectProtocol?
	
	lazy var calculator: MVCView = {
		let view = MVCView.init()
		view.translatesAutoresizingMaskIntoConstraints = false;
		return view
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "MVC"
		self.view.backgroundColor = UIColor.white
		self.setupSubviews()
		self.setupEvents()
		self.setupStates()
    }
	
	private func setupSubviews() {
		self.view.addSubview(self.calculator)
		self.calculator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
		self.calculator.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
		self.calculator.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
	}
	
	private func setupEvents() {
		self.observer = NotificationCenter.default.addObserver(forName: MVCModel.resultCalculated, object: nil, queue: nil) { [calculator] (note) in
			calculator.inputTextField.text = note.userInfo?[MVCModel.resultKey] as? String
		}
		
		self.calculator.performAction = { [weak self] (textField) in
			self?.performAction()
		}
	}
	
	private func setupStates() {
		self.calculator.inputTextField.text = model.result;
	}
	
	private func performAction() {
		let formula = self.calculator.inputTextField.text ?? "0";
		MBProgressHUD.showAdded(to: self.view, animated: true)
		model.calculate(formula: formula) {
			MBProgressHUD.hide(for: self.view, animated: true)
		}
	}
	
	deinit {
		if let observer = self.observer {
			NotificationCenter.default.removeObserver(observer)
		}
	}
}
