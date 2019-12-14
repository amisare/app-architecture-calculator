//
//  CalculatorFakeServer.m
//  Calculator
//
//  Created by 顾海军 on 2019/12/3.
//  Copyright © 2019 顾海军. All rights reserved.
//

#import "CalculatorFakeServer.h"
#import <GCDWebServers/GCDWebServers.h>

@interface CalculatorFakeServer() <GCDWebServerDelegate>

@property (nonatomic, strong) GCDWebServer *server;

@end

@implementation CalculatorFakeServer

static CalculatorFakeServer* _instance = nil;
static dispatch_once_t _onceToken;

+ (instancetype)shared {
	if (!_instance) {
		dispatch_once(&_onceToken, ^{
			_instance = [[CalculatorFakeServer alloc] init];
			[_instance buildServer];
		});
	}
	return _instance;
}

- (void)start {
	NSMutableDictionary* options = [NSMutableDictionary dictionary];
	[options setObject:@8080 forKey:GCDWebServerOption_Port];
	[options setObject:@(true) forKey:GCDWebServerOption_BindToLocalhost];
	[self.server startWithOptions:options error:nil];
}

- (void)stop {
	[self.server stop];
    _onceToken = 0;
    _instance = nil;
}

- (GCDWebServer *)server {
	if (!_server) {
		_server = [[GCDWebServer alloc] init];
		_server.delegate = self;
	}
	return _server;
}

- (void)buildServer {
	[self.server addHandlerForMethod:@"POST"
								path:@"/calculate"
						requestClass:[GCDWebServerDataRequest class]
				   asyncProcessBlock:^(__kindof GCDWebServerRequest * _Nonnull request, GCDWebServerCompletionBlock  _Nonnull completionBlock) {
		
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			
			id jsonObject = ((GCDWebServerDataRequest *)request).jsonObject;
			
			NSString *formula = [NSString stringWithFormat:@"%@", jsonObject[@"formula"]];
			formula = (formula.length == 0) ? @"0" : formula;
			formula = [formula lowercaseString];
			formula = [formula stringByReplacingOccurrencesOfString:@"x" withString:@"*"];
			
			NSString *result = @"";
			@try {
				NSExpression *expression = [NSExpression expressionWithFormat:formula];
				id value = [expression expressionValueWithObject:nil context:nil];
				result = [value stringValue];
				result = (result.length == 0) ? @"0" : result;
			} @catch (NSException *exception) {
				result = @"Error";
			} @finally {
				
			}
			
			NSDictionary *resp = @{
				@"result" : result,
			};
			NSData *respData = [NSJSONSerialization dataWithJSONObject:resp options:0 error:nil];
			GCDWebServerDataResponse* response = [GCDWebServerDataResponse
												  responseWithData:respData
												  contentType:@"application/json"];
			completionBlock(response);
		});
	}];
}

@end
