//
//  TEAController.m
//  CalculatorTEA-CK
//
//  Created by GuHaijun on 2019/12/19.
//  Copyright © 2019 顾海军. All rights reserved.
//

#import "TEAController.h"
#import <ComponentKit/ComponentKit.h>
#import "CalculatorTEA_CK-Swift.h"
#import "TEAComponent.h"

@interface TEAController ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) TEAModel *model;
@property (nonatomic, strong) CKComponentHostingView *hostingView;

@end

@implementation TEAController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    self.contentView = [UIView new];
    [self.view addSubview:self.contentView];
    self.contentView.translatesAutoresizingMaskIntoConstraints = false;
    [[self.contentView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor] setActive:true];
    [[self.contentView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor] setActive:true];
    [[self.contentView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor] setActive:true];
    [[self.contentView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor] setActive:true];
    
    [self.view layoutIfNeeded];
    
    self.hostingView = [[CKComponentHostingView alloc] initWithComponentProvider:[self class] sizeRangeProvider:nil];
    [self.contentView addSubview:self.hostingView];
    self.hostingView.frame = self.contentView.bounds;
    
    __weak TEAModel *weakModel = self.model;
    [self.hostingView updateModel:weakModel mode:CKUpdateModeSynchronous];
    
    __weak TEAController *weakVc = self;
    [self.hostingView updateContext:weakVc mode:CKUpdateModeSynchronous];
}

+ (CKComponent *)componentForModel:(TEAModel *)model context:(id<NSObject>)context {
    return [TEAComponent newWithModel:model context:context];
}

- (TEAModel *)model {
    if (_model == nil) {
        _model = [TEAModel new];
    }
    return _model;
}

@end
