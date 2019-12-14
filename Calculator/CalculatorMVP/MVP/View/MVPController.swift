//
//  MVPController.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/3.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

class MVPController: UIViewController {
    
    var presenter: MVPPresenter?
    var model = MVPBrain.init()
    lazy var calculator: MVPView = {
        let view = MVPView.init()
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.presenter = MVPPresenter.init(model: self.model, view: self.calculator)
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
        self.calculator.performAction = { [weak self] (textField) in
            if let self = self {
                MBProgressHUD.showAdded(to: self.view, animated: true)
                self.presenter?.calculate(completion: {
                    MBProgressHUD.hide(for: self.view, animated: true)
                })
            }
        }
    }
}
