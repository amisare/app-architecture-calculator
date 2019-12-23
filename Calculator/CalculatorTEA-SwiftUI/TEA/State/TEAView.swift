//
//  TEAView.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/19.
//  Copyright © 2019 顾海军. All rights reserved.
//

import SwiftUI

struct TEAView: View {
    @EnvironmentObject private var model: TEAModel
    @State var isLoading = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    TextField.init("", text: self.$model.result, onEditingChanged: { (_) in
                        
                    }, onCommit: self.calculate())
                        .frame(height:44)
                        .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(TextAlignment.trailing)
                    
                    Button.init("确定", action: self.calculate())
                        .frame(height:44)
                        .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    Spacer()
                }
                .navigationBarTitle("TEA-SwiftUI", displayMode: NavigationBarItem.TitleDisplayMode.inline)
            }
            if(self.isLoading) {
                ActivityIndicator(show: self.$isLoading)
            }
        }
    }
    
    private func calculate() -> (() -> Void) {
        return {
            self.isLoading = true
            _ = self.model.calculate
                .sink(receiveValue: { (value) in
                    self.isLoading = false
                })
        }
    }
}

struct TEAView_Previews: PreviewProvider {
    static var previews: some View {
        TEAView()
    }
}
