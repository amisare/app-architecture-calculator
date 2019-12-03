//
//  ViewController.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/3.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

enum PatternType: String {
	case unknown
	case MVC = "MVC"
}

class ViewController: UIViewController {
	
	lazy var stackView: UIStackView = {
		var stackView = UIStackView.init()
		stackView.axis = NSLayoutConstraint.Axis.vertical
		stackView.alignment = UIStackView.Alignment.fill
		stackView.translatesAutoresizingMaskIntoConstraints = false;
		return stackView
	}()
	
	lazy var buttons: [UIButton] = {
		var button : (_ title: String) -> UIButton = { [weak self] (title) in
			var button = UIButton.init(type: UIButton.ButtonType.system)
			button.setTitle(title, for: UIControl.State.normal)
			button.addTarget(self, action:#selector(self?.buttonClick(_:)), for: UIControl.Event.touchUpInside)
			button.heightAnchor.constraint(equalToConstant: 44).isActive = true
			return button
		}
		return [
			button(PatternType.MVC.rawValue)
		]
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.title = "Patterns"
		
		self.view.addSubview(self.stackView)
		self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
		self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
		self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
		
		buttons.forEach { (button) in
			self.stackView.addArrangedSubview(button)
		}
	}
	
	@objc func buttonClick(_ sender: UIButton) {
		let pattern = PatternType.init(rawValue: sender.title(for: UIControl.State.normal) ?? "")
		
		switch pattern {
		case .MVC:
			let vc = MVCController.init()
			self.navigationController?.pushViewController(vc, animated: true)
			break
			
		default: break
			
		}
		
	}
}

