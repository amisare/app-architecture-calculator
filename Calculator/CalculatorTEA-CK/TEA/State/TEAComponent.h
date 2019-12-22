//
//  TEAComponent.h
//  CalculatorTEA-CK
//
//  Created by GuHaijun on 2019/12/22.
//  Copyright © 2019 顾海军. All rights reserved.
//

#import <ComponentKit/ComponentKit.h>
#import "CalculatorTEA_CK-Swift.h"

@interface TEAComponent : CKCompositeComponent

+ (TEAComponent *)newWithModel:(TEAModel *)model context:(id)context;

@end

@interface TEAComponentController : CKComponentController


@end
