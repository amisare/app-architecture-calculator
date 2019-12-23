//
//  TEALoadingView.swift
//  CalculatorTEA-SwiftUI
//
//  Created by 顾海军 on 2019/12/19.
//  Copyright © 2019 顾海军. All rights reserved.
//

import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {

    @Binding var show: Bool

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> MBProgressHUD {
        return MBProgressHUD.init()
    }

    func updateUIView(_ uiView: MBProgressHUD, context: UIViewRepresentableContext<ActivityIndicator>) {
        show ? uiView.show(animated: true) : uiView.hide(animated: true)
    }
}
