//
//  TEAController.m
//  CalculatorTEA-CK
//
//  Created by GuHaijun on 2019/12/19.
//  Copyright © 2019 顾海军. All rights reserved.
//

#import "TEAController.h"
#import <ComponentKit/ComponentKit.h>
#import "TEABrain.h"

@interface TEAController ()<CKComponentHostingViewDelegate, CKComponentProvider>

@property (nonatomic, strong) CKComponentHostingView *hostView;
@property (nonatomic, strong) TEABrain *brain;
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
    
//    self.hostView = [[CKComponentHostingView alloc] initWithComponentProvider:[TEAState class] sizeRangeProvider:nil];
//    [self.hostView updateModel:self.brain mode:CKUpdateModeSynchronous];
//    [self.contentView addSubview:self.hostView];
//    self.hostView.frame = self.contentView.bounds;
}

- (void)componentHostingViewDidInvalidateSize:(CKComponentHostingView *)hostingView {
    
}

@end
