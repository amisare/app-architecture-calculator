//
//  TEAView.swift
//  Calculator
//
//  Created by 顾海军 on 2019/12/19.
//  Copyright © 2019 顾海军. All rights reserved.
//

import SwiftUI

struct TEAView: View {
    @EnvironmentObject private var driver: TEADriver
    @State var showLoading = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    TextField.init("", text: self.$driver.result, onEditingChanged: { (_) in
                        
                    }, onCommit: {
                        
                    }).frame(height:44)
                        .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(TextAlignment.trailing)
                    
                    Button.init("确定") {
                        self.showLoading = true
                        _ = self.driver.calculate
                            .sink(receiveValue: { (value) in
                                self.showLoading = false
                            })
                    }.frame(height:44)
                        .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    Spacer()
                }
                .navigationBarTitle("TEA-SwiftUI", displayMode: NavigationBarItem.TitleDisplayMode.inline)
            }
            if(self.showLoading) {
                ActivityIndicator(show: self.$showLoading)
            }
        }
    }
}

struct TEAView_Previews: PreviewProvider {
    static var previews: some View {
        TEAView()
    }
}
