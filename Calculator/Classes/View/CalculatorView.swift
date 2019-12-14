//
//  CalculatorView.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/3.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

class CalculatorView: UIView {
	
	private lazy var stackView: UIStackView = {
		var stackView = UIStackView.init()
		stackView.axis = NSLayoutConstraint.Axis.vertical
		stackView.alignment = UIStackView.Alignment.fill
		stackView.distribution = UIStackView.Distribution.fill
		stackView.translatesAutoresizingMaskIntoConstraints = false;
		return stackView
	}()
	
	lazy var inputTextField: UITextField = {
		var textField = UITextField.init()
		textField.borderStyle = UITextField.BorderStyle.roundedRect
		textField.keyboardType = UIKeyboardType.numbersAndPunctuation
		textField.textAlignment = NSTextAlignment.right
		return textField
	}()
	
	lazy var performButton: UIButton = {
		var button = UIButton.init(type: UIButton.ButtonType.system)
		button.setTitle("确定", for: UIControl.State.normal)
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupSubviews() {
		self.addSubview(self.stackView)
		self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
		self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
		self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
		self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		
		self.stackView.addArrangedSubview(self.inputTextField)
		self.inputTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		self.stackView.addArrangedSubview(self.performButton)
		self.performButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
	}
}
