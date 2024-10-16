//
//  AutoTaskManger.h
//  WebDriverAgent
//  Created by JoyTim on 2024/9/2
//  Copyright © 2024 Facebook. All rights reserved.
//
    

#import <Foundation/Foundation.h>
#import "TaskQueueManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface AutoTaskManger : NSObject
@property (nonatomic, strong)TaskQueueManager *taskQueue;
+ (instancetype)sharedManager;
-(void)begainTask;

@end

NS_ASSUME_NONNULL_END
