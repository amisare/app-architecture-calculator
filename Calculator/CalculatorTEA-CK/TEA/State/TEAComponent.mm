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
#import "TEATextFieldComponent.h"

@interface TEAComponent()

@property (nonatomic, strong) TEAModel *model;

@end

@implementation TEAComponent

+ (Class<CKComponentControllerProtocol>)controllerClass {
    return [TEAComponentController class];
}

+ (id)initialState {
    return @(false);
}

+ (TEAComponent *)newWithModel:(TEAModel *)model context:(id)context {
    CKComponentScope scope(self);
    BOOL isLoading = [scope.state() boolValue];
    
    CKCompositeComponent *calcuator =
    [CKCompositeComponent
     newWithComponent: [CKInsetComponent
                       newWithInsets:{ UIEdgeInsetsMake(20, 20, 0, 20) }
                       component: [CKCenterLayoutComponent
                                   newWithCenteringOptions:{}
                                   sizingOptions:CKCenterLayoutComponentSizingOptionDefault
                                   child: [CKFlexboxComponent
                                           newWithView:{}
                                           size: {}
                                           style: {.spacing = 20}
                                           children: {
                                            {
                                                
                                                [TEATextFieldComponent newWithText:model.result
                                                                    onChangeAction:{@selector(onChangeAction:value:)}
                                                                    #pragma clang diagnostic push
                                                                    #pragma clang diagnostic ignored "-Wundeclared-selector"
                                                                    onDidEndAction:{scope, @selector(calculate)}
                                                                    #pragma clang diagnostic pop
                                                                           context:context]
                                            },
                                            {
                                                [CKButtonComponent
                                                 #pragma clang diagnostic push
                                                 #pragma clang diagnostic ignored "-Wundeclared-selector"
                                                 newWithAction:{scope, @selector(calculate:)}
                                                 #pragma clang diagnostic pop
                                                 options:{
                                                    .titles = @"确定",
                                                    .titleColors = [UIColor blackColor] }
                                                 ]
                                            }
                                        }]
                                   size:{}]
                       ]
     ];
    
    CKComponent *loading =
    isLoading ? [TEALoadingComponent new] : nil;
    
    TEAComponent *c =
    [TEAComponent
     newWithComponent:[CKOverlayLayoutComponent
                       newWithComponent:calcuator
                       overlay:loading]
     ];
    
    if (c) {
        c.model = model;
    }
    
    return c;
}

- (void)onChangeAction:(TEATextFieldComponent *)component value:(NSString *)value {
    self.model.textInputValue = value;
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
        return @(loading);
    } mode:CKUpdateModeSynchronous];
}

@end

