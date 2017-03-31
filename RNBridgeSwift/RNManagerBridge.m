//
//  RNManagerBridge.m
//  RNBridgeSwift
//
//  Created by 王垒 on 2017/3/30.
//  Copyright © 2017年 王垒. All rights reserved.
//

#import "RNManagerBridge.h"

@implementation RNManagerBridge

RCT_EXPORT_MODULE(swift);

RCT_EXPORT_METHOD(transportMessage:(id)message){

    NSLog(@"transportMessage:\n %@",message);
    
    if ([message isKindOfClass:[NSDictionary class]]) {
        NSString *method = [message objectForKey:@"method"];
        
        BOOL isNext = method ? ([method isEqualToString:@"push"] || [method isEqualToString:@"present"]) : NO ;
        
        if (isNext) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificatioinNext" object:message userInfo:nil];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificatioinBack" object:message userInfo:nil];
        }
        
    }
}

//RN传参数调用原生OC,并且返回数据给RN  通过CallBack
RCT_EXPORT_METHOD(RNInvokeOCCallBack:(NSDictionary *)dictionary callback:(RCTResponseSenderBlock)callback){
    NSLog(@"接收到RN传过来的数据为:%@",dictionary);
    NSArray *events = @[
                        @{
                            @"name" : @"王垒",
                            @"value": @"QQ"
                            },
                        @{
                            @"name" : @"King",
                            @"value": @"738225977"
                            }
                        ];
    
    callback(@[[NSNull null], events]);
}


@end
