//
//  AutoTaskManger.m
//  WebDriverAgent
//  Created by JoyTim on 2024/9/2
//  Copyright © 2024 Facebook. All rights reserved.
//
    

#import "AutoTaskManger.h"
#import "NetworkRequestManager.h"
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <objc/runtime.h>
#import "LSApplicationWorkspace.h"
#import <XCTest/XCTest.h>
#import "XCUIDevice+FBHelpers.h"

#import <Security/Security.h>

#import <objc/runtime.h>



typedef struct {
    NSString  *img;
    CGFloat w;
    CGFloat h;
} CalculationResult;
NSString *getDeviceUDID(void) {
    Class deviceClass = NSClassFromString(@"UIDevice");
    SEL uniqueIdentifierSelector = NSSelectorFromString(@"uniqueIdentifier");

    if ([deviceClass respondsToSelector:uniqueIdentifierSelector]) {
        id result = [deviceClass performSelector:uniqueIdentifierSelector];
        return result; // 直接返回 UDID
    }
    
    return nil;
}
@import Vision;

@interface AutoTaskManger ()

// 在这里声明私有属性
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, copy) NSString *elementId;
@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, strong) NSMutableArray *taskArray;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat sWight;
@property (nonatomic, assign) CGFloat sHeight;


@end
@implementation AutoTaskManger

static AutoTaskManger *sharedManager = nil;
static dispatch_once_t onceToken1;

+ (instancetype)sharedManager {
    dispatch_once(&onceToken1, ^{
        sharedManager = [[self alloc] init];
      sharedManager.baseUrl = @"http://localhost:8100";
      [sharedManager registerForNotifications];
    });
    return sharedManager;
}

- (instancetype)init {
  self =  [super init];
  self.taskQueue = [[TaskQueueManager alloc]init];
  return  self;
}



-(void)begainTask{
  


  
  [self createSession]; //打开应用
  
  [self getScreenDataWithQuantity:10];
  
  [self location];
  
  return;
  __weak typeof(self) weakSelf = self;
  

  
//  [self.taskQueue addTask:^(void (^ dddd)(void)) {
//    __strong typeof(weakSelf) strongSelf = weakSelf;

    NSLog(@"定时器触发了！===0====");
  
  
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//      [self ddd];
//
//    });

//    [strongSelf timerDidFire:nil];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:2
//                                                        target:self
//                                                      selector:@selector(timerDidFire:)
//                                                      userInfo:nil
//                                                       repeats:YES];
  
//  // 延迟 5 秒后启动定时器
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      self.timer = [NSTimer scheduledTimerWithTimeInterval:10
                                                    target:self
                                                  selector:@selector(timerDidFire:)
                                                  userInfo:nil
                                                   repeats:YES];
  });

//      [[NSRunLoop mainRunLoop] addTimer:strongSelf.timer forMode:NSRunLoopCommonModes];
//
////    [strongSelf ddd];
//
//  } withDelay:3];
//
//  self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0
//                                                    target:self
//                                                  selector:@selector(timerDidFire:)
//                                                  userInfo:nil
//                                                   repeats:YES];
//  
//  [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
  
/*
  [self.taskQueue addTask:^(void (^ ddd)(void)) {
   
    __strong typeof(weakSelf) strongSelf = weakSelf;
    
    
        NSString *url = [NSString stringWithFormat:@"%@/session/%@/touch/perform", strongSelf.baseUrl,strongSelf.sessionId];

    // 构建请求体
 
   
    CGFloat x = [UIScreen mainScreen].bounds.size.width / 2; // x 屏幕中间
    CGFloat y = [UIScreen mainScreen].bounds.size.height - 150.0; // y 减去 100.0
    
    NSLog(@"==========0=====%f,%f",x,y);

     NSDictionary *tapAction = @{
         @"actions": @[
             @{
                 @"action": @"tap",
                 @"options": @{
                     @"x": @(x),
                     @"y": @(y)
                 }
             }
         ]
     };
    
    NSLog(@"==========0=====ddd");
    [[NetworkRequestManager sharedManager]postRequestWithURL:url parameters:tapAction completion:^(NSData *data, NSURLResponse *response, NSError *error) {
      NSLog(@"==========1=====ddd");
        }];
    
    
    
    
    
    
    
    
//    NSData *data  = [strongSelf getScreenDataWithQuantity:100];
//    
//    
//
//    NSString *base64String = [data base64EncodedStringWithOptions:0];
    
//    NSLog(@"=========%@==========",base64String);
//    [[NetworkRequestManager sharedManager] getRequestWithURL:url parameters:@{} completion:^(NSData *data, NSURLResponse *response, NSError *error) {
//            NSDictionary * jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//            NSString *valueDict = jsonObject[@"value"];
//      
//            NSLog(@"=========%@==========",valueDict);
//    } ];
    
//    NSString *url = [NSString stringWithFormat:@"%@/screenshot", strongSelf.baseUrl];
//
//    [[NetworkRequestManager sharedManager] getRequestWithURL:url parameters:@{} completion:^(NSData *data, NSURLResponse *response, NSError *error) {
////      NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
////      NSLog(@"Result: %@", resultString);
//      
//      // 将 NSData 转换为 JSON 对象
//      NSError *error2;
//      NSDictionary * jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error2];
//      NSString *valueDict = jsonObject[@"value"];
//
//      NSLog(@"=========%@==========",valueDict);
    
    

    
  } withDelay:10];
 */
  
}

-(void)location{
  
  
  
  NSString *url = [NSString stringWithFormat:@"%@/wda/simulatedLocation", self.baseUrl];

  NSDictionary *dic = @{
      @"longitude": @(-74.0060), // 纽约的经度
      @"latitude": @(40.7128),   // 纽约的纬度
  };
  
  [[NetworkRequestManager sharedManager] postRequestWithURL:url parameters:dic completion:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (error){
        NSLog(@"====%@",error.localizedDescription);
        return;
      }
    NSLog(@"==卧室定位定位");

  }];
}

-(void)ddd{
//  [[NetworkRequestManager sharedManager] getRequestWithURL:@"https:www.baidu.com" parameters:@{} completion:^(NSData *data, NSURLResponse *response, NSError *error) {
//      if (error){
//        NSLog(@"====%@",error.localizedDescription);
//        return;
//      }
//  }];
  
//  NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//     NSURLSession *session = [NSURLSession sharedSession];
//     
//     NSURLSessionDataTask *task = [session dataTaskWithURL:url
//                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//         if (error) {
//             return;
//         }
//         
//         NSError *jsonError = nil;
//         NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
//                                                                      options:0
//                                                                        error:&jsonError];
//         
//            NSLog(@"====%@",error.localizedDescription);
//
//       
//     }];
//     
//     [task resume];
  
  [self clickWithCurrentSize:0.3813 y:0.6895];
}
- (void)timerDidFire:(NSTimer *)timer {
    NSLog(@"定时器触发了！");
   NSString * uuid = [self getUUID];
  
  
//  NSString  * uuid =  [UIDevice.currentDevice.identifierForVendor UUIDString] ?: @"unknown";
  
  NSString *url = @"https://test-inner-gateway.shuhengio.com/monitor/clientInfoService/report";
  
//  NSString *url = @"http://192.168.11.88:8004/monitor/clientInfoService/report";

  CalculationResult  cimgS = [self getScreenDataWithQuantity:10];
  if(cimgS.img == nil){
    return;
  }
  NSString * size = [NSString stringWithFormat:@"%f,%f",cimgS.w, cimgS.h];
  
  NSDictionary *dic = @{
    @"project": @"123",
    @"customer":@"456",
    @"client_id": uuid,
    @"app_id": @"666",
    @"image": cimgS.img,
    @"size":size
  };
  
  [[NetworkRequestManager sharedManager] postRequestWithURL:url parameters:dic completion:^(NSData *data, NSURLResponse *response, NSError *error) {
    
//        NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"Result: %@", resultString);
    
    if (error){
      NSLog(@"====%@",error.localizedDescription);
      return;
    }
    
    NSError *error2;
    NSDictionary   *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error2];

     
    
    NSLog(@"Parsed JSON: %@", jsonDict);

    NSNumber *codeNumber = [jsonDict valueForKey:@"code"];
    int code = [codeNumber intValue];  
    NSArray *command =  [jsonDict valueForKey:@"command"];

    if (code == 200 && command.count > 0 ) {
      
      @try {
        
        NSString *firstJsonString = [command firstObject];
        
        if (firstJsonString != nil && firstJsonString.length > 0) {
          
          NSData *jsonData = [firstJsonString dataUsingEncoding:NSUTF8StringEncoding];
                
                // 将 NSData 反序列化为 JSON 对象
                NSError *error4 = nil;
                NSDictionary *jsonRDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error4];
                // 检查是否成功
                if (error4) {
                    NSLog(@"Error parsing JSON: %@", error.localizedDescription);
                } else {
                  
                  NSString *action = [jsonRDict objectForKey:@"action"];
                  if (action) {
                      NSLog(@"对应action 的值是: %@", action);
                    if([action isEqualToString:@"click"]){
                      NSDictionary *param = [jsonRDict objectForKey:@"param"];

                      NSNumber *x = [param objectForKey:@"x"] ;
                      NSNumber *y = [param objectForKey:@"y"];

                      if (x && y) {
                        [self clickWithCurrentSize:[x doubleValue] y:[y doubleValue]];
                      }
                      
                    }else if ([action isEqualToString:@"swipeScreen"]){
                      NSDictionary *param = [jsonRDict objectForKey:@"param"];

                      NSNumber *startX = [param objectForKey:@"startX"] ;
                      NSNumber *startY = [param objectForKey:@"startY"];

                      NSNumber *endX = [param objectForKey:@"endX"];
                      NSNumber *endY = [param objectForKey:@"endY"];

                      if (startX && startY && endX && endY) {
                        [self swipeScreenCompletion:[startX doubleValue] startY:[startY doubleValue] endX:[endX doubleValue] endY:[endY doubleValue]];
                      }
                      
                    }else if ([action isEqualToString:@"swipeScreen"]){
                      [self gohome];
                    }
                   
                  }
                 
                }

        }
      } @catch (NSException *_) {
        
        return;
      }
    
      }
  

       

  }];
  
}

-(void)gohome{
  
  NSError *error;
  BOOL success =  [[XCUIDevice sharedDevice] fb_goToHomescreenWithError:&error];
  
  if (success) {
    NSLog(@"返回screen home状态:%d",success);
  }

}
-(void)clickWithCurrentSize:(CGFloat)x y:(CGFloat)y{
  
  UIScreen *mainScreen = [UIScreen mainScreen];
  
  CGFloat scale = mainScreen.scale;
  
  
  CGFloat width = self.sWight / scale;
  CGFloat height = self.sHeight / scale;
//
  
//  CGFloat width = 1170 / scale;
//  CGFloat height = 2532 / scale;
  // 获取屏幕的缩放因子

  // 计算物理像素尺寸
//  CGFloat widthInPixels = screenSize.width * scale;
//  CGFloat heightInPixels = screenSize.height * scale;
//
//  NSLog(@"Width in points: %f, Height in points: %f", screenSize.width, screenSize.height);
//  NSLog(@"Width in pixels: %f, Height in pixels: %f", widthInPixels, heightInPixels);
  
  
  NSLog(@"=====width===%f====height: %f",width,height);

  [self clickWith:width*x y:height*y];
  
}
-(void)clickWith:(CGFloat)x y:(CGFloat)y{
  
  
  
  if (!self.sessionId || self.sessionId.length <= 2){
    return;
  }
  
  NSLog(@"x===%f===y:%f",x, y);

  NSString *url = [NSString stringWithFormat:@"%@/session/%@/wda/tap", self.baseUrl, self.sessionId];

  NSDictionary *dic = @{
    @"x": @(x),
    @"y":@(y),
  };
  
  
  [[NetworkRequestManager sharedManager] postRequestWithURL:url parameters:dic completion:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error){
      NSLog(@"=点击失败==%@",error.localizedDescription);
    }
  }];
   
}

-(void)swipeScreenCompletion:(CGFloat)_startX startY:(CGFloat)_startY  endX:(CGFloat)_endX endY:(CGFloat)_endY{
  // 获取屏幕的宽度和高度

  // 获取应用的屏幕尺寸
  UIScreen *mainScreen = [UIScreen mainScreen];
  CGFloat scale = mainScreen.scale;

  
  CGFloat width = self.sWight / scale;
  CGFloat height = self.sHeight / scale;
//  CGSize screenSize = mainScreen.bounds.size;
//  CGFloat width = screenSize.width;
//  CGFloat height = screenSize.height;

  CGFloat startX = _startX * width;
  CGFloat startY = _startY * height;
  CGFloat endX = _endX * width;
  CGFloat endY = _endY * height;

  
  NSDictionary *pointerParameters = @{
      @"pointerType": @"touch"
  };

  NSArray *pointerActions = @[
      @{
          @"type": @"pointerMove",
          @"duration": @0,
          @"x": @(startX),
          @"y": @(startY)
      },
      @{
          @"type": @"pointerDown",
          @"button": @0
      },
      @{
          @"type": @"pause",
          @"duration": @200
      },
      @{
          @"type": @"pointerMove",
          @"duration": @1000,
          @"origin": @"pointer",
          @"x": @(endX),
          @"y": @(endY)
      },
      @{
          @"type": @"pointerUp",
          @"button": @0
      }
  ];

    NSDictionary *actions = @{
        @"type": @"pointer",
        @"id": @"finger1",
        @"parameters": pointerParameters,
        @"actions": pointerActions
    };

    NSArray *actionsArray = @[actions];
  


      NSString *url = [NSString stringWithFormat:@"%@/session/%@/actions",self.baseUrl, self.sessionId];

      NSDictionary *dict = @{
        @"actions":actionsArray
      };
      [[NetworkRequestManager sharedManager] postRequestWithURL:url
                                                    parameters:dict
                                                    completion:^(NSData *data, NSURLResponse *response, NSError *error) {
          if (error) {
              NSLog(@"Error: %@", error);
             
          } else {
              // 在适当的时候(可能是在主线程)处理返回的数据
              NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Result: %@", resultString);
              
             
          }
      }];
      
    
  
}

#pragma mark 屏幕截图
-(CalculationResult )getScreenDataWithQuantity:(NSInteger)quantity {
  
  NSError *error;
  
  // 获取截图数据
  NSData *screenshotData = [[XCUIDevice sharedDevice] fb_screenshotWithError:&error];
  
  // 检查是否成功获取截图
  if (screenshotData == nil || error != nil) {
      NSLog(@"截屏失败：%@", error);
    CalculationResult result;
       result.img = nil;
       result.w = 10;
       result.h = 15;
       return result;
  }

  UIImage *screenImage = [UIImage imageWithData:screenshotData];

   UIImage *_originImage = screenImage;

  NSData *_data = UIImageJPEGRepresentation(_originImage, (CGFloat)quantity/100);

  NSString *_encodedImageStr = [_data base64EncodedStringWithOptions:0];
  
  
  CalculationResult result;
     result.img = _encodedImageStr;
     result.w = _originImage.size.width;
     result.h = _originImage.size.height;
  
  if(self.sWight == 0.0 ){
    self.sWight = _originImage.size.width;
  }
  if(self.sHeight == 0.0 ){
    self.sHeight = _originImage.size.height;
  }
  
//  NSLog(@"截屏尺寸===：%f ,%f", _originImage.size.width,_originImage.size.height);

     return result;
//  UIImageWriteToSavedPhotosAlbum(_decodedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
  

}


- (NSString *)getUUID {
    NSString *key = @"com.yourappsh.uniqueIdentifier"; // 定义一个唯一的钥匙串键
    NSString *uuid = [self loadUUIDFromKeychain:key];

    if (!uuid) {
        // 如果钥匙串中没有 UUID，则生成新的 UUID
        uuid = [UIDevice.currentDevice.identifierForVendor UUIDString];
        
        if (!uuid) {
            // 如果生成失败，使用当前时间戳加上 4 位随机数
            uuid = [self generateFallbackUUID];
        }
        
        // 将新的 UUID 存入钥匙串
        [self saveUUIDToKeychain:uuid forKey:key];
    }

    return uuid;
}

- (NSString *)generateFallbackUUID {
    // 获取当前时间戳
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    NSString *timestampString = [NSString stringWithFormat:@"%.0f", timestamp];
    
    // 生成 4 位随机数
    int randomNum = arc4random_uniform(10000); // 生成 0 到 9999 的随机数
    NSString *randomString = [NSString stringWithFormat:@"%04d", randomNum]; // 格式化为 4 位
    
    // 拼接时间戳和随机数
    return [NSString stringWithFormat:@"%@%@", timestampString, randomString];
}

- (void)saveUUIDToKeychain:(NSString *)uuid forKey:(NSString *)key {
    NSData *uuidData = [uuid dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrService: key,
        (__bridge id)kSecValueData: uuidData,
    };

    // 删除旧的钥匙串项
    SecItemDelete((__bridge CFDictionaryRef)query);
    
    // 添加新的钥匙串项
    SecItemAdd((__bridge CFDictionaryRef)query, NULL);
}

- (NSString *)loadUUIDFromKeychain:(NSString *)key {
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrService: key,
        (__bridge id)kSecReturnData: @YES,
        (__bridge id)kSecMatchLimit: (__bridge id)kSecMatchLimitOne,
    };

    CFTypeRef result = NULL;
    SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);

    if (result) {
        NSData *uuidData = (__bridge_transfer NSData *)result;
        return [[NSString alloc] initWithData:uuidData encoding:NSUTF8StringEncoding];
    }

    return nil; // 如果没有找到 UUID，则返回 nil
}



// 将 UIImage 转换为 Base64 字符串的方法
- (NSString *)imageToBase64String:(UIImage *)image {
    // 将 UIImage 转换为 JPEG 数据，压缩质量为 1.0（无损）
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    if (imageData) {
        // 将数据转换为 Base64 字符串
        return [imageData base64EncodedStringWithOptions:0];
    }
    return nil; // 转换失败时返回 nil
}
// 保存完成后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        // 保存失败，输出错误信息
        NSLog(@"Error saving image: %@", error.localizedDescription);
    } else {
        // 保存成功
        NSLog(@"Image saved successfully to photo album.");
    }
}



-(void)xml{
  
  NSString *url = [NSString stringWithFormat:@"%@/source", self.baseUrl];

  [[NetworkRequestManager sharedManager] getRequestWithURL:url parameters:@{} completion:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Result: %@", resultString);
    

  }];
  
}

- (void)saveImageToPhotoLibrary:(UIImage *)image {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                // Create a new asset creation request
                [PHAssetCreationRequest creationRequestForAssetFromImage:image];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (!success) {
                    NSLog(@"Error saving photo: %@", error.localizedDescription);
                } else {
                    NSLog(@"Photo saved successfully.");
                }
            }];
        } else {
            NSLog(@"No permission to access photo library.");
        }
    }];
}
- (UIImage *)imageNamedInCurrentBundle:(NSString *)imageName {
    // 获取当前 bundle
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];

    // 从 bundle 中加载图片
    UIImage *image = [UIImage imageNamed:imageName inBundle:currentBundle compatibleWithTraitCollection:nil];
    
    return image;
}
-(void)sessionWithId:(NSString*)bundleId{
  
  NSDictionary *capabilities = @{
      @"alwaysMatch": @{
          @"platformName": @"iOS",
          @"appium:platformVersion": @"16.7.1",
          @"appium:deviceName": @"joytim",
          @"appium:udid": @"00008101-0001148A0A60001E",
          @"appium:bundleId": bundleId,
//          @"appium:bundleId": @"com.shuheng.mzgw",
          @"appium:automationName": @"xcuitest"
      },
      @"firstMatch": @[@{}]
  };

  NSDictionary *desiredCapabilities = @{
      @"platformName": @"iOS",
      @"appium:platformVersion": @"16.7.1",
      @"appium:deviceName": @"joytim",
      @"appium:udid": @"00008101-0001148A0A60001E",
      @"appium:bundleId": bundleId,
      @"appium:automationName": @"xcuitest"
  };

  NSDictionary *dict = @{
      @"capabilities": capabilities,
      @"desiredCapabilities": desiredCapabilities
  };
  
  [self.taskQueue addTask:^(void (^ completion)(void)) {
    [[NetworkRequestManager sharedManager] postRequestWithURL:@"http://localhost:8100/session"
                                                  parameters:dict
                                                  completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            // 在适当的时候(可能是在主线程)处理返回的数据
            NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Result: %@", resultString);
        }
    }];
    
    completion();
    
  } withDelay:5];
 
  
}
-(void)createSession{
  
  NSString *platformVersion = [[UIDevice currentDevice] systemVersion]; // 获取系统版本
  NSString *deviceName = [[UIDevice currentDevice] name]; // 获取设备名称

  NSDictionary *capabilities = @{
      @"alwaysMatch": @{
          @"platformName": @"iOS",
          @"appium:platformVersion": platformVersion,
          @"appium:deviceName": deviceName,
          @"appium:automationName": @"xcuitest"
      },
      @"firstMatch": @[@{}]
  };

  NSDictionary *desiredCapabilities = @{
      @"platformName": @"iOS",
      @"appium:platformVersion":platformVersion,
      @"appium:deviceName": deviceName,
      @"appium:udid": @"00008101-0001148A0A6111331E",
      @"appium:automationName": @"xcuitest"
  };

  NSDictionary *dict = @{
      @"capabilities": capabilities,
      @"desiredCapabilities": desiredCapabilities
  };
  
  __weak typeof(self) weakSelf = self;

  [self.taskQueue addTask:^(void (^ completion)(void)) {
    [[NetworkRequestManager sharedManager] postRequestWithURL:@"http://localhost:8100/session"
                                                  parameters:dict
                                                  completion:^(NSData *data, NSURLResponse *response, NSError *error) {
      __strong typeof(weakSelf) strongSelf = weakSelf;  // 在 block 内部将 weakSelf 转换为 __strong

      
      if (error) {
            NSLog(@"Error: %@", error);
        } else {
          NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        // 将 NSString 转换为 NSData
        NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];

        // 将 NSData 转换为 JSON 对象
        NSError *error2;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

        if (error2) {
            NSLog(@"Failed to convert string to JSON object: %@", error.localizedDescription);
        } else {
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *jsonDict = (NSDictionary *)jsonObject;
               
              NSString * ids =  [jsonDict valueForKey:@"sessionId"];
              if (ids) {
                if(strongSelf) {
                  strongSelf.sessionId = ids;
                }
              }
                // 处理字典
                NSLog(@"JSON Dictionary: %@", [jsonDict valueForKey:@"sessionId"]);
          
            }
        }
        
        }
    }];
    
    completion();
    
  } withDelay:5];
  
}


-(void)status{
  
  __weak typeof(self) weakSelf = self;
  NSString *url = [NSString stringWithFormat:@"%@/status",self.baseUrl];
  
  [self.taskQueue addTask:^(void (^ completion)(void)) {
    [[NetworkRequestManager sharedManager] getRequestWithURL:url
                                                  parameters:@{}
                    
                                                  completion:^(NSData *data, NSURLResponse *response, NSError *error) {
      __strong typeof(weakSelf) strongSelf = weakSelf;  // 在 block 内部将 weakSelf 转换为 __strong

        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            // 在适当的时候(可能是在主线程)处理返回的数据
            NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Result33: %@", resultString);
          // 将 NSString 转换为 NSData
          NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];

          // 将 NSData 转换为 JSON 对象
          NSError *error2;
          id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

          if (error2) {
              NSLog(@"Failed to convert string to JSON object: %@", error.localizedDescription);
          } else {
              if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                  NSDictionary *jsonDict = (NSDictionary *)jsonObject;
                 
                NSString * ids =  [jsonDict valueForKey:@"sessionId"];
                if (ids) {
                  if(strongSelf) {
                    strongSelf.sessionId = ids;
                  }
                }
                  // 处理字典
                  NSLog(@"JSON Dictionary: %@", [jsonDict valueForKey:@"sessionId"]);
            
                
            
              }
          }
          
        }
      completion();
    }];
    
  } withDelay:5];

}


-(void)findElementWithXPath:(NSString*)xpath completion:(void (^)(NSString *elementId, NSError *error))completionBlock {

    __weak typeof(self) weakSelf = self;

    [self.taskQueue addTask:^(void (^ taskCompletion)(void)) {
        __strong typeof(weakSelf) strongSelf = weakSelf;  // 在 block 内部将 weakSelf 转换为 __strong
        NSString *url = [NSString stringWithFormat:@"%@/session/%@/element", strongSelf.baseUrl, strongSelf.sessionId];
        
        NSDictionary *dict = @{
            @"using": @"xpath",
            @"value": xpath
//            @"value": @"//XCUIElementTypeButton[@name=\"sidemenu\"]"
        };
        [[NetworkRequestManager sharedManager] postRequestWithURL:url
                                                      parameters:dict
                                                      completion:^(NSData *data, NSURLResponse *response, NSError *error) {
          
            if (error) {
                NSLog(@"Error: %@", error);
                if (completionBlock) {
                    completionBlock(nil, error);  // 发生错误时执行回调并传递错误
                }
            } else {
                // 在适当的时候(可能是在主线程)处理返回的数据
                NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"Result: %@", resultString);
                NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];

                // 将 NSData 转换为 JSON 对象
                NSError *error2;
                id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error2];

                if (error2) {
                    NSLog(@"Failed to convert string to JSON object: %@", error2.localizedDescription);
                    if (completionBlock) {
                        completionBlock(nil, error2);  // JSON 解析失败时执行回调并传递错误
                    }
                } else {
                    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *jsonDict = (NSDictionary *)jsonObject;
                                     
                        NSDictionary *valueDict = jsonDict[@"value"];
                        NSString *elementValue = valueDict[@"ELEMENT"];

                        if (elementValue) {
                            if (strongSelf) {
                                strongSelf.elementId = elementValue;
                            }
                            if (completionBlock) {
                                completionBlock(elementValue, nil);  // 成功时执行回调并传递 elementId
                            }
                        } else {
                            if (completionBlock) {
                                completionBlock(nil, [NSError errorWithDomain:@"CustomDomain" code:100 userInfo:@{NSLocalizedDescriptionKey: @"Element not found"}]);  // 没有找到 elementId 时执行回调并传递错误
                            }
                        }
                        // 处理字典
                        NSLog(@" ELEMENT JSON Dictionary: %@", [jsonDict valueForKey:@"value"]);
                    }
                }
            }
        }];
        
        taskCompletion();
        
    } withDelay:1];
}


-(void)elementAddValueWithId:(NSString *)elementId valueData:(NSString*)value completion:(void (^)(NSError *error))completionBlock {
  
  __weak typeof(self) weakSelf = self;

  [self.taskQueue addTask:^(void (^ taskCompletion)(void)) {
      __strong typeof(weakSelf) strongSelf = weakSelf;  // 在 block 内部将 weakSelf 转换为 __strong
      if (!strongSelf) {
          if (completionBlock) {
              completionBlock([NSError errorWithDomain:@"CustomDomain" code:101 userInfo:@{NSLocalizedDescriptionKey: @"Self is nil"}]);
          }
          return;
      }

      NSString *url = [NSString stringWithFormat:@"%@/session/%@/element/%@/value",strongSelf.baseUrl, strongSelf.sessionId, elementId];

      NSDictionary *dict = @{
        @"text":value
      };
      [[NetworkRequestManager sharedManager] postRequestWithURL:url
                                                    parameters:dict
                                                    completion:^(NSData *data, NSURLResponse *response, NSError *error) {
          if (error) {
              NSLog(@"Error: %@", error);
              if (completionBlock) {
                  completionBlock(error);  // 发生错误时执行回调并传递错误
              }
          } else {
              // 在适当的时候(可能是在主线程)处理返回的数据
              NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Result: %@", resultString);
              
              if (completionBlock) {
                  completionBlock(nil);  // 成功时执行回调，没有错误
              }
          }
      }];
      
      taskCompletion();
      
  } withDelay:1];
}



-(void)clickElementWithId:(NSString *)elementId Completion:(void (^)(NSError *error))completionBlock {

    __weak typeof(self) weakSelf = self;

    [self.taskQueue addTask:^(void (^ taskCompletion)(void)) {
        __strong typeof(weakSelf) strongSelf = weakSelf;  // 在 block 内部将 weakSelf 转换为 __strong
        if (!strongSelf) {
            if (completionBlock) {
                completionBlock([NSError errorWithDomain:@"CustomDomain" code:101 userInfo:@{NSLocalizedDescriptionKey: @"Self is nil"}]);
            }
            return;
        }

        NSString *url = [NSString stringWithFormat:@"%@/session/%@/element/%@/click",strongSelf.baseUrl, strongSelf.sessionId, elementId];

        NSDictionary *dict = @{};
        [[NetworkRequestManager sharedManager] postRequestWithURL:url
                                                      parameters:dict
                                                      completion:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
                if (completionBlock) {
                    completionBlock(error);  // 发生错误时执行回调并传递错误
                }
            } else {
                // 在适当的时候(可能是在主线程)处理返回的数据
                NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"Result: %@", resultString);
                
                if (completionBlock) {
                    completionBlock(nil);  // 成功时执行回调，没有错误
                }
            }
        }];
        
        taskCompletion();
        
    } withDelay:2];
}

-(void)clickElementWithPath:(NSString*)xpath completion:(void (^)(NSError *error))completionBlock {
  
  __weak typeof(self) weakSelf = self;

  [self findElementWithXPath:xpath completion:^(NSString *elementId, NSError *error) {
    __strong typeof(weakSelf) strongSelf = weakSelf;

    if (strongSelf != nil && elementId != nil) {
      
      [strongSelf clickElementWithId:elementId Completion:completionBlock];
    }else{
      completionBlock(error);
    }
  }];
 
}

-(void)elementWithPath:(NSString*)xpath  addValue:(NSString*)text completion:(void (^)(NSError *error))completionBlock {

  __weak typeof(self) weakSelf = self;

  [self findElementWithXPath:xpath completion:^(NSString *elementId, NSError *error) {
    __strong typeof(weakSelf) strongSelf = weakSelf;

    if (strongSelf != nil && elementId != nil) {
      
      [strongSelf elementAddValueWithId:elementId valueData:text completion:completionBlock];
    }else{
      completionBlock(error);
    }
  }];
  
}

-(void)swipeScreenCompletion:(void (^)(NSError *error))completionBlock {
  // 获取屏幕的宽度和高度

  // 获取应用的屏幕尺寸
  UIScreen *mainScreen = [UIScreen mainScreen];
  CGSize screenSize = mainScreen.bounds.size;
  CGFloat width = screenSize.width;
  CGFloat height = screenSize.height;

  // 计算 startX、startY 和 endY
  CGFloat startX = width / 2.0;
  CGFloat startY = height * 0.8;
  CGFloat endY = height * 0.2;
  
  
  NSLog(@"====%f,%f",width,height);
  NSDictionary *pointerParameters = @{
      @"pointerType": @"touch"
  };

  NSArray *pointerActions = @[
      @{
          @"type": @"pointerMove",
          @"duration": @0,
          @"x": @(startX),
          @"y": @(endY)
      },
      @{
          @"type": @"pointerDown",
          @"button": @0
      },
      @{
          @"type": @"pause",
          @"duration": @200
      },
      @{
          @"type": @"pointerMove",
          @"duration": @1000,
          @"origin": @"pointer",
          @"x": @(startX),
          @"y": @(startY)
      },
      @{
          @"type": @"pointerUp",
          @"button": @0
      }
  ];

  NSDictionary *actions = @{
      @"type": @"pointer",
      @"id": @"finger1",
      @"parameters": pointerParameters,
      @"actions": pointerActions
  };

  NSArray *actionsArray = @[actions];
  
  
  
  __weak typeof(self) weakSelf = self;

  [self.taskQueue addTask:^(void (^ taskCompletion)(void)) {
      __strong typeof(weakSelf) strongSelf = weakSelf;  // 在 block 内部将 weakSelf 转换为 __strong
      if (!strongSelf) {
          if (completionBlock) {
              completionBlock([NSError errorWithDomain:@"CustomDomain" code:101 userInfo:@{NSLocalizedDescriptionKey: @"Self is nil"}]);
          }
          return;
      }

      NSString *url = [NSString stringWithFormat:@"%@/session/%@/actions",strongSelf.baseUrl, strongSelf.sessionId];

      NSDictionary *dict = @{
        @"actions":actionsArray
      };
      [[NetworkRequestManager sharedManager] postRequestWithURL:url
                                                    parameters:dict
                                                    completion:^(NSData *data, NSURLResponse *response, NSError *error) {
          if (error) {
              NSLog(@"Error: %@", error);
              if (completionBlock) {
                  completionBlock(error);  // 发生错误时执行回调并传递错误
              }
          } else {
              // 在适当的时候(可能是在主线程)处理返回的数据
              NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Result: %@", resultString);
              
              if (completionBlock) {
                  completionBlock(nil);  // 成功时执行回调，没有错误
              }
          }
      }];
      
      taskCompletion();
      
  } withDelay:2];
  
  
}




-(void)deleteCurrentSession{
  __weak typeof(self) weakSelf = self;
  
  if (self.sessionId == nil){
    return;
  }

  [self.taskQueue addTask:^(void (^ taskCompletion)(void)) {
    
    __strong typeof(weakSelf) strongSelf = weakSelf;  // 在 block 内部将 weakSelf 转换为 __strong


    NSString *url = [NSString stringWithFormat:@"%@/session/%@",strongSelf.baseUrl, strongSelf.sessionId];

    [[NetworkRequestManager sharedManager] deleteRequestWithURL:url completion:^(NSData *data, NSURLResponse *response, NSError *error) {
      taskCompletion();
    }];

  } withDelay:1];
  
}

-(void)unlockScreen{
 //
  
  NSString *url = [NSString stringWithFormat:@"%@/wda/unlock", self.baseUrl];

  [[NetworkRequestManager sharedManager] postRequestWithURL:url parameters:@{} completion:^(NSData *data, NSURLResponse *response, NSError *error) {
    
    if (error) {
           NSLog(@"解锁屏幕失败：%@", error.localizedDescription);
           return;
    }
    NSLog(@"打开密码解锁界面");

  }];
}

-(void)doActions:(NSDictionary *)params{
  
  NSString *url = [NSString stringWithFormat:@"%@/session/%@/actions",self.baseUrl, self.sessionId];

  
  [[NetworkRequestManager sharedManager] postRequestWithURL:url parameters:params completion:^(NSData *data, NSURLResponse *response, NSError *error) {
    
    if (error) {
           NSLog(@"oActions 失败：%@", error.localizedDescription);
           return;
    }
    NSLog(@"doActions 成功");

  }];
}
#pragma mark  远程通知
- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:@"SH-Task-Noitce-Name"
                                               object:nil];
}

- (void)handleNotification:(NSNotification *)notification {
    // 获取 JSON 数据
    NSDictionary *jsonRDict = notification.userInfo;

    // 处理 JSON 数据
    if (jsonRDict) {
      NSLog(@"Received JSON Data: %@", jsonRDict);
        // 进行你的 JSON 处理逻辑
      NSString *action = [jsonRDict objectForKey:@"action"];
      if (action) {
          NSLog(@"对应action 的值是: %@", action);
        if([action isEqualToString:@"click"]){
          NSDictionary *param = [jsonRDict objectForKey:@"param"];

          NSNumber *x = [param objectForKey:@"x"] ;
          NSNumber *y = [param objectForKey:@"y"];

          if (x && y) {
            [self clickWithCurrentSize:[x doubleValue] y:[y doubleValue]];
          }
          
        }else if ([action isEqualToString:@"swipeScreen"]){
          NSDictionary *param = [jsonRDict objectForKey:@"param"];

          NSNumber *startX = [param objectForKey:@"startX"] ;
          NSNumber *startY = [param objectForKey:@"startY"];

          NSNumber *endX = [param objectForKey:@"endX"];
          NSNumber *endY = [param objectForKey:@"endY"];

          if (startX && startY && endX && endY) {
            [self swipeScreenCompletion:[startX doubleValue] startY:[startY doubleValue] endX:[endX doubleValue] endY:[endY doubleValue]];
          }
          
        }else if ([action isEqualToString:@"gohome"]){
          [self gohome];
        }else if ([action isEqualToString:@"unlock"]){
          [self unlockScreen];
        }else if ([action isEqualToString:@"actions"]){
          NSDictionary *param = [jsonRDict objectForKey:@"param"];

          [self doActions:param];
          
//          [self swipeScreenCompletion:^(NSError *error) {
//            
//          } ];
        }
       
      }
    } else {
        NSLog(@"No JSON data received.");
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
