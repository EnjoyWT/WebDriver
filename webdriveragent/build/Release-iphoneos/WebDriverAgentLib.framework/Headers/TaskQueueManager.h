//
//  TaskQueueManager.h
//  WebDriverAgent
//  Created by JoyTim on 2024/9/2
//  Copyright © 2024 Facebook. All rights reserved.
//
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskQueueManager : NSObject
- (instancetype)init;
- (void)addTask:(void (^)(void (^)(void)))task withDelay:(unsigned int)delay;
-(void)sleep:(unsigned int)seconds;
@end

NS_ASSUME_NONNULL_END



