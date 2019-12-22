//
//  TEAComponent.m
//  CalculatorTEA-CK
//
//  Created by GuHaijun on 2019/12/22.
//  Copyright © 2019 顾海军. All rights reserved.
//

#import "TEAComponent.h"
#import <ComponentKit/CKComponentScope.h>
#import <ComponentKit/CKAction.h>
#import <ComponentKit/CKComponentSubclass.h>
#import "TEALoadingComponent.h"

@interface TEAComponentState : NSObject

@property (nonatomic, assign) BOOL isLoading;

@end

@implementation TEAComponentState

@end


@interface TEAComponent()

@property (nonatomic, strong) TEAModel *model;

@end

@implementation TEAComponent

+ (Class<CKComponentControllerProtocol>)controllerClass {
    return [TEAComponentController class];
}

+ (id)initialState {
    TEAComponentState *state = [TEAComponentState new];
    state.isLoading = false;
    return state;
}

+ (TEAComponent *)newWithModel:(TEAModel *)model context:(id)context {
    CKComponentScope scope(self);
    TEAComponentState *state = scope.state();
//    BOOL isLoading = state.isLoading;
    
    BOOL isLoading = true;
    
    CKCompositeComponent *show = [CKCompositeComponent newWithComponent:
            [CKInsetComponent
             newWithInsets:{ UIEdgeInsetsMake(20, 20, 0, 20) }
             component: [CKCenterLayoutComponent
                         newWithCenteringOptions:{}
                         sizingOptions:CKCenterLayoutComponentSizingOptionDefault
                         child: [CKFlexboxComponent
                                 newWithView:{}
                                 size: {}
                                 style: {.spacing = 20}
                                 children:
                                 {
        {
            [CKComponent
             newWithView:{
                [UITextField class],
                {
                    {@selector(setText:), model.result},
                    {@selector(setBorderStyle:), UITextBorderStyleRoundedRect},
                    {@selector(setTextAlignment:), NSTextAlignmentRight},
                    CKComponentActionAttribute(CKAction<>::actionFromBlock(^(CKComponent *component) {
                        UITextField *textField = (UITextField *)component.viewContext.view;
                        model.textInputValue = textField.text;
                    }), UIControlEventEditingChanged),
                    CKComponentActionAttribute({scope, @selector(calculate)}, UIControlEventEditingDidEndOnExit),
                }
            }
             size: {
                .height = 44,
            }]
        },
        {
            [CKButtonComponent
             newWithAction:{scope, @selector(calculate)}
             options:{
                .titles = @"确定",
                .titleColors = [UIColor blackColor] }
             ]
        }
    }
                                 ]
                         size:{}]
             ]
            ];
    
    CKComponent *overlay = isLoading ? [TEALoadingComponent new] : nil;
    
    TEAComponent *c = [TEAComponent newWithComponent:[CKOverlayLayoutComponent newWithComponent:show overlay:overlay]];
    
    if (c) {
        c.model = model;
    }
    
    return c;
}

@end


@interface TEAComponentController()
@property (nonatomic, strong) TEAModel *model;
@end

@implementation TEAComponentController

- (instancetype)initWithComponent:(TEAComponent *)component {
    self = [super initWithComponent:component];
    self.model = component.model;
    return self;
}

- (void)calculate {
    [self componentLoading:true];
    __weak TEAComponentController *weakC = self;
    [self.model calculateWithFormula:self.model.textInputValue completion:^{
        [weakC componentLoading:false];
    }];
}

- (void)componentLoading:(BOOL)loading {
    [self.component updateState:^id(id currentState) {
        TEAComponentState *state = [TEAComponentState new];
        state.isLoading = loading;
        return state;
    } mode:CKUpdateModeSynchronous];
}


@end

