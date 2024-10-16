//
//  TaskQueueManager.m
//  WebDriverAgent
//  Created by JoyTim on 2024/9/2
//  Copyright © 2024 Facebook. All rights reserved.
//
    


// TaskQueueManager.m
#import "TaskQueueManager.h"

@interface TaskQueueManager ()

@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) dispatch_group_t group;

@end

@implementation TaskQueueManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _queue = dispatch_queue_create("com.example.myQueue", DISPATCH_QUEUE_SERIAL);
        _group = dispatch_group_create();
    }
    return self;
}

- (void)addTask:(void (^)(void (^)(void)))task withDelay:(unsigned int)delay {
    // 将任务添加到队列中
//    dispatch_group_enter(self.group);  // 标记任务开始
  
  if (delay > 0) {
    
    dispatch_async(self.queue, ^{
      sleep(delay);
    });
  }
  dispatch_async(self.queue, ^{
            task(^{
                
            });
    });
}
-(void)sleep:(unsigned int)delay{
  dispatch_async(self.queue, ^{
    sleep(delay);
  });
}

//- (void)addTask:(void (^)(void (^)(void)))task withDelay:(NSTimeInterval)delay {
//    // 将任务添加到队列中
//    dispatch_group_enter(self.group);  // 标记任务开始
//    dispatch_group_async(self.group, self.queue, ^{
//        if (delay > 0) {
//            // 如果需要延迟，使用 dispatch_after 进行延迟
//
//          task(^{
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), self.queue, ^{
//              dispatch_group_leave(self.group);
//            });
//          });
//
//        } else {
//            // 无延迟直接执行任务
//            task(^{
//                dispatch_group_leave(self.group);
//            });
//        }
//    });
//}


@end
