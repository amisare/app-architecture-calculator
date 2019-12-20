//
//  TEAState.m
//  CalculatorTEA-CK
//
//  Created by 顾海军 on 2019/12/20.
//  Copyright © 2019 顾海军. All rights reserved.
//

#import "TEAState.h"
#import <ComponentKit/ComponentKit.h>

@interface TEAState()

@property (nonatomic, strong) NSMutableArray *operators;

@end

@implementation TEAState

- (instancetype)init {
    self = [super init];
    [self setupEvents];
    return self;
}

- (void)setupEvents {
//    [[NSNotificationCenter defaultCenter] addObserverForName:<#(nullable NSNotificationName)#> object:<#(nullable id)#> queue:<#(nullable NSOperationQueue *)#> usingBlock:<#^(NSNotification * _Nonnull note)block#>]
}


//- (CKComponentHostingView *)view {
//    if (_view == nil) {
//        _view = [[CKComponentHostingView alloc] initWithComponentProvider:[TEAState class] sizeRangeProvider:nil];
//    }
//    return _view;
//}

+ (CKComponent *)componentForModel:(id<NSObject>)model context:(id<NSObject>)context {
    
    return [CKCenterLayoutComponent
            newWithCenteringOptions:{}
            sizingOptions:CKCenterLayoutComponentSizingOptionDefault
            child: [CKFlexboxComponent
                    newWithView:{}
                    size:{}
                    style:{.spacing = 10}
                    children: {
        {
            [CKLabelComponent
             newWithLabelAttributes:{
                .string = @"Hello!",
                .alignment = NSTextAlignmentCenter}
             viewAttributes:{
                {{@selector(setBackgroundColor:), [UIColor clearColor]}}
            }
             size:{ }]},
        {
            [CKButtonComponent
             newWithAction:nil
             options:{
                .titles = @"Purple",
                .titleColors = UIColor.purpleColor}
             ]
        }
    }
                    ]
            size:{}];
    
}

@end
