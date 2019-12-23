//
//  MAVBController.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/3.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MAVBController: UIViewController {
    
    let disposeBag = DisposeBag.init()
    var modelAdapter: MAVBModelAdapter!
    var viewAdapter: MAVBViewAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupEvents()
    }
    
    private func setupEvents() {
        // create view
        let calculator = MAVBView.init()
        calculator.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(calculator)
        calculator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        calculator.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        calculator.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        // create adapter
        self.viewAdapter = MAVBViewAdapter.init(view: calculator)
        self.modelAdapter = MAVBModelAdapter.init(model: MAVBBrain.init())
        
        // bind adapter
        self.modelAdapter.textFieldValue.asObservable().bind(to: self.viewAdapter.showValue).disposed(by: disposeBag)
        self.viewAdapter.perform
            .skip(1)
            .flatMapLatest({ (value) -> Observable<Int> in
                MBProgressHUD.showAdded(to: self.view, animated: true)
                return self.modelAdapter.calculate(formula: value ?? "0" )
            })
            .subscribe({ (_) in
                MBProgressHUD.hide(for: self.view, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
