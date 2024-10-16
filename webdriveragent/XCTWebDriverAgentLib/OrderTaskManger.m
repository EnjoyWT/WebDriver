//
//  OrderTaskManger.m
//  WebDriverAgent
//  Created by JoyTim on 2024/10/12
//  Copyright © 2024 Facebook. All rights reserved.
//
    

#import "OrderTaskManger.h"

@interface OrderTaskManger ()
@property (nonatomic, strong) NSMutableArray<NSDictionary<NSString *, id> *> *taskQueue;
@property (nonatomic, assign) BOOL isTaskRunning;
@property (nonatomic, strong) dispatch_queue_t queue;
@end
#import <Foundation/Foundation.h>


@implementation OrderTaskManger

+ (instancetype)sharedManager {
    static OrderTaskManger *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _taskQueue = [NSMutableArray array];
        _isTaskRunning = NO;
        _queue = dispatch_queue_create("com.taskmanager.serialqueue", DISPATCH_QUEUE_SERIAL);
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(taskCompleted)
                                                     name:@"taskCompletedNotification"
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addTask:(void (^)(void))task {
    dispatch_async(self.queue, ^{
        NSUUID *newTaskID = [NSUUID UUID];
        [self.taskQueue addObject:@{@"id": newTaskID, @"task": task}];
        [self executeNextTaskIfNeeded];
    });
}

- (void)executeNextTaskIfNeeded {
    if (self.isTaskRunning || self.taskQueue.count == 0) return;

    self.isTaskRunning = YES;
    NSDictionary *taskTuple = [self.taskQueue firstObject];
    [self.taskQueue removeObjectAtIndex:0];
    
    void (^task)(void) = taskTuple[@"task"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        task();
        [[NSNotificationCenter defaultCenter] postNotificationName:@"taskCompletedNotification" object:nil];
    });
}

- (void)taskCompleted {
    dispatch_async(self.queue, ^{
        self.isTaskRunning = NO;
        [self executeNextTaskIfNeeded];
    });
}

@end
