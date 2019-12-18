//
//  MVVMController.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/3.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

class MVVMController: UIViewController {
    
    var vm: MVVMViewModel!
    var obs = [NSKeyValueObservation]()
    
    lazy var calculator: MVVMView = {
        let view = MVVMView.init()
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupSubviews()
        self.setupEvents()
    }
    
    private func setupSubviews() {
        self.view.addSubview(self.calculator)
        self.calculator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.calculator.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.calculator.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
    
    private func setupEvents() {
        
        self.vm = MVVMViewModel.init(model: MVVMBrain.init())
        self.obs += [self.vm.observe(\.textFieldValue, options: [.initial, .new]) { [weak self] (_, change) in
            self?.calculator.inputTextField.text = change.newValue
        }]
        
        self.calculator.performAction = { [weak self] (textField) in
            if let self = self {
                let formula = self.calculator.inputTextField.text ?? "0";
                MBProgressHUD.showAdded(to: self.view, animated: true)
                self.vm.calculate(formula: formula) {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
        }
    }
    
}
