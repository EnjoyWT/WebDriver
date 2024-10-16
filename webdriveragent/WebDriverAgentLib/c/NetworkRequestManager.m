//
//  NetworkRequestManager.m
//  WebDriverAgent
//  Created by JoyTim on 2024/9/2
//  Copyright © 2024 Facebook. All rights reserved.
//
    

#import "NetworkRequestManager.h"

@implementation NetworkRequestManager

+ (instancetype)sharedManager {
    static NetworkRequestManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)getRequestWithURL:(NSString *)urlString
                 parameters:(NSDictionary *)parameters
                 completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completion {
    
    NSMutableString *urlWithParams = [NSMutableString stringWithString:urlString];
    if (parameters.count > 0) {
        [urlWithParams appendString:@"?"];
        for (NSString *key in parameters) {
            [urlWithParams appendFormat:@"%@=%@&", key, parameters[key]];
        }
        [urlWithParams deleteCharactersInRange:NSMakeRange(urlWithParams.length - 1, 1)];
    }
    
    NSURL *url = [NSURL URLWithString:urlWithParams];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (completion) {
            completion(data, response, error);
        }
    }];
    
    [task resume];
}

- (void)postRequestWithURL:(NSString *)urlString
                  parameters:(NSDictionary *)parameters
                  completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    if (error) {
        if (completion) {
            completion(nil, nil, error);
        }
        return;
    }
    
    [request setHTTPBody:jsonData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (completion) {
            completion(data, response, error);
        }
    }];
    
    [task resume];
}


- (void)deleteRequestWithURL:(NSString *)urlString completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completion {
    // 创建一个 NSMutableURLRequest 实例，并设置请求类型为 DELETE
  NSURL *url = [NSURL URLWithString:urlString];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"DELETE"];

    // 创建 NSURLSession 实例
    NSURLSession *session = [NSURLSession sharedSession];

    // 创建数据任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (completion) {
            // 在主线程中调用完成处理程序
            completion(data, response, error);
        }
    }];

    // 启动任务
    [dataTask resume];
}

@end
