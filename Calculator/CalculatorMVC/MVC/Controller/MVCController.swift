//
//  MVCController.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/3.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

class MVCController: UIViewController {
    
    var model = MVCBrain.init()
    var observers = [NSObjectProtocol]()
    
    lazy var calculator: MVCView = {
        let view = MVCView.init()
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.observers += [NotificationCenter.default.addObserver(forName: CalculatorBrainNotification.calculateComplete, object: nil, queue: nil) { [calculator] (note) in
            let result = note.userInfo?[CalculatorBrainKey.calculateValue] as? CalculatorResult
            calculator.inputTextField.text = result?.value
            }]
        
        self.observers += [NotificationCenter.default.addObserver(forName: CalculatorBrainNotification.calculateError, object: nil, queue: nil) { [calculator] (note) in
            calculator.inputTextField.text = note.userInfo?[CalculatorBrainKey.calculateError] as? String
            }]
        
        self.calculator.performAction = { [weak self] (textField) in
            if let self = self {
                let formula = self.calculator.inputTextField.text ?? "0";
                MBProgressHUD.showAdded(to: self.view, animated: true)
                self.model.calculate(formula: formula) {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
        }
    }
    
    private func setupStates() {
        self.calculator.inputTextField.text = model.result.value;
    }
    
    deinit {
        for observer in self.observers {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
