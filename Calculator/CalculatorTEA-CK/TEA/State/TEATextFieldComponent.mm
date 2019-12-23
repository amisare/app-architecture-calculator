//
//  TEATextFieldComponent.m
//  CalculatorTEA-CK
//
//  Created by 顾海军 on 2019/12/23.
//  Copyright © 2019 顾海军. All rights reserved.
//

#import "TEATextFieldComponent.h"

@interface TEATextFieldComponent()<UITextFieldDelegate> {
    CKAction<NSString *> _onChangeAction;
    CKAction<NSString *> _onDidEndAction;
    CKAction<> _action;
}

@end

@implementation TEATextFieldComponent

+ (TEATextFieldComponent *)newWithText:(NSString *)text
                        onChangeAction:(const CKAction<NSString *>)onChangeAction
                        onDidEndAction:(const CKAction<NSString *>)onDidEndAction
                               context:(id)context {
    TEATextFieldComponent *c = [TEATextFieldComponent newWithComponent:
            [CKComponent
             newWithView: {
                [UITextField class],
                {
                    {@selector(setText:), text},
                    {@selector(setBorderStyle:), UITextBorderStyleRoundedRect},
                    {@selector(setTextAlignment:), NSTextAlignmentRight},
                    CKComponentActionAttribute({@selector(onChangeAction:)}, UIControlEventEditingChanged),
                    CKComponentActionAttribute({@selector(onDidEndAction:)}, UIControlEventEditingDidEndOnExit),
                    CKComponentDelegateAttribute(@selector(setDelegate:), {
                        @selector(textField:shouldChangeCharactersInRange:replacementString:)
                    }),
                }
            }
             size: {
                .height = 44,
            }]
            ];
    if (c) {
        c->_onChangeAction = onChangeAction;
        c->_onDidEndAction = onDidEndAction;
    }
    return c;
}


- (void)onChangeAction:(TEATextFieldComponent *)textField {
    _onChangeAction.send(self, ((UITextField *)textField.viewContext.view).text);
}

- (void)onDidEndAction:(TEATextFieldComponent *)textField {
    _onDidEndAction.send(self, ((UITextField *)textField.viewContext.view).text);
}


#pragma mark - delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSArray *numbers = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    NSString *currentText = textField.text;
    if ([[currentText lowercaseString] containsString:@"error"] == true) {
        textField.text = @"";
        return true;
    }
    
    if (currentText.length == 1 &&
        [currentText isEqualToString:@"0"]) {
        if (range.location == 1 && [numbers containsObject:string]) {
            textField.text = @"";
            return true;
        }
    }
    
    return true;
}

@end
