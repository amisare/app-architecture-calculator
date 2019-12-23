//
//  TEATextFieldComponent.h
//  CalculatorTEA-CK
//
//  Created by 顾海军 on 2019/12/23.
//  Copyright © 2019 顾海军. All rights reserved.
//

#import <ComponentKit/ComponentKit.h>
#import "CalculatorTEA_CK-Swift.h"

@interface TEATextFieldComponent : CKCompositeComponent

+ (TEATextFieldComponent *)newWithText:(NSString *)text
                        onChangeAction:(const CKAction<NSString *>)onChangeAction
                        onDidEndAction:(const CKAction<NSString *>)onDidEndAction
                               context:(id)context;

@end
