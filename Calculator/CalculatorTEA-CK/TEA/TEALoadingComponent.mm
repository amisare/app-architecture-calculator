//
//  TEALoadingComponent.m
//  CalculatorTEA-CK
//
//  Created by GuHaijun on 2019/12/23.
//  Copyright © 2019 顾海军. All rights reserved.
//

#import "TEALoadingComponent.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation TEALoadingComponent

+ (instancetype)new {
    return [super newWithComponent:
            [CKComponent
             newWithView:{
                [MBProgressHUD class],
                {
                }
            }
             size: {
                .height = 44,
            }]
            ];
}

@end
