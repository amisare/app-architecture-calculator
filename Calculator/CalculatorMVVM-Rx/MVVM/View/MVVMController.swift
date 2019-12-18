//
//  MVVMController.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/3.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MVVMController: UIViewController {
    
    let disposeBag = DisposeBag.init()
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
        
        self.vm.textFieldValue.asObservable().bind(to: self.calculator.inputTextField.rx.text).disposed(by: disposeBag)
        
        self.calculator.perform?
            .skip(1)
            .flatMapLatest({ (value) -> Observable<Int> in
                MBProgressHUD.showAdded(to: self.view, animated: true)
                return self.vm.calculate(formula: value ?? "")
            })
            .subscribe({ (_) in
                MBProgressHUD.hide(for: self.view, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
