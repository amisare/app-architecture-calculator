//
//  CalcFakeServer.h
//  Calculator
//
//  Created by 顾海军 on 2019/12/3.
//  Copyright © 2019 顾海军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalcFakeServer : NSObject

+ (instancetype)shared;
- (void)start;
- (void)stop;

@end
