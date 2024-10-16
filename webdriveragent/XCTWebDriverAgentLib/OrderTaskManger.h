//
//  OrderTaskManger.h
//  WebDriverAgent
//  Created by JoyTim on 2024/10/12
//  Copyright © 2024 Facebook. All rights reserved.
//
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderTaskManger : NSObject
+ (instancetype)sharedManager;
- (void)addTask:(void (^)(void))task;
@end

NS_ASSUME_NONNULL_END
