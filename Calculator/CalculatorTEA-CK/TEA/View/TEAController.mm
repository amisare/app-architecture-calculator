//
//  TEAController.m
//  CalculatorTEA-CK
//
//  Created by GuHaijun on 2019/12/19.
//  Copyright © 2019 顾海军. All rights reserved.
//

#import "TEAController.h"
#import <ComponentKit/ComponentKit.h>
#import "TEADriver.h"

@interface TEAController ()<CKComponentHostingViewDelegate, CKComponentProvider>

@property (nonatomic, strong) CKComponentHostingView *hostView;
@property (nonatomic, strong) TEADriver *driver;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation TEAController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.contentView = [UIView new];
    [self.view addSubview:self.contentView];
    self.contentView.translatesAutoresizingMaskIntoConstraints = false;
    [[self.contentView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor] setActive:true];
    [[self.contentView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor] setActive:true];
    [[self.contentView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor] setActive:true];
    [[self.contentView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor] setActive:true];
    
    [self.view layoutIfNeeded];
    
    self.hostView = [[CKComponentHostingView alloc] initWithComponentProvider:[self class] sizeRangeProvider:nil];
    self.hostView.delegate = self;
    [self.hostView updateModel:self.driver mode:CKUpdateModeSynchronous];
    [self.contentView addSubview:self.hostView];
    self.hostView.frame = self.contentView.bounds;
}

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

- (void)componentHostingViewDidInvalidateSize:(CKComponentHostingView *)hostingView {
    
}

@end
