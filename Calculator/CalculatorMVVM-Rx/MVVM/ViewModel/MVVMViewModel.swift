//
//  MVVMViewModel.swift
//  CalculatorMVVM
//
//  Created by 顾海军 on 2019/12/18.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MVVMViewModel: NSObject {
    
    let disposeBag = DisposeBag.init()
    
    let model: MVVMBrain
    var textFieldValue: BehaviorRelay<String> = BehaviorRelay(value: "0")
    
    init(model: MVVMBrain) {
        self.model = model
        super.init()
        self.setupEvents()
    }
    
    private func setupEvents() {
        
        Observable.of(
            NotificationCenter.default.rx.notification(CalculatorBrainNotification.calculateComplete)
                .flatMapLatest({ (note) -> Observable<String> in
                    let result = note.userInfo?[CalculatorBrainKey.calculateValue] as? CalculatorResult
                    return Observable.just(result?.value ?? "0")
                }),
            NotificationCenter.default.rx.notification(CalculatorBrainNotification.calculateError)
                .flatMapLatest({ (note) -> Observable<String> in
                    let result = note.userInfo?[CalculatorBrainKey.calculateError] as? String ?? "Error"
                    return Observable.just(result)
                }))
            .merge().bind(to: textFieldValue).disposed(by: disposeBag)
    }
    
    func calculate(formula: String) -> Observable<Int> {
        return Observable<Int>.create { [formula] (observer: AnyObserver<Int>) -> Disposable in
            self.model.calculate(formula: formula) {
                observer.on(.next(0))
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }
}
