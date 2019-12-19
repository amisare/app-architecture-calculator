//
//  TEADriver.swift
//  CalculatorTEA-SwiftUI
//
//  Created by 顾海军 on 2019/12/19.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit
import Combine
import SwiftUI

class TEADriver: ObservableObject {
    
    private var observers = [NSObjectProtocol]()
    private var brain: TEABrain

    @Published var result = "0"
    
    var calculate: AnyPublisher<Int, Never> {
        return Future { promise in
            self.brain.calculate(formula: self.result) {
                promise(.success(0))
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    init(brain: TEABrain) {
        self.brain = brain
        self.setupEvents()
    }
    
    private func setupEvents() {
        self.observers += [NotificationCenter.default.addObserver(forName: CalculatorBrainNotification.calculateComplete, object: nil, queue: nil) { (note) in
            let result = (note.userInfo?[CalculatorBrainKey.calculateValue] as? CalculatorResult)?.value ?? "0"
            self.result = result
            }]
        
        self.observers += [NotificationCenter.default.addObserver(forName: CalculatorBrainNotification.calculateError, object: nil, queue: nil) { (note) in
            let result = note.userInfo?[CalculatorBrainKey.calculateError] as? String ?? "Error"
            self.result = result
            }]
    }
    
    deinit {
        for observer in self.observers {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
