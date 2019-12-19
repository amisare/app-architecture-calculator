
//
//  MVCViewState.swift
//  MVC-VS
//
//  Created by 顾海军 on 2019/12/19.
//  Copyright © 2019 顾海军. All rights reserved.
//

import UIKit

class MVCViewState: NSObject {
    var textFieldValue: String = ""
    
    init(textFieldValue: String) {
        self.textFieldValue = textFieldValue
    }
}
