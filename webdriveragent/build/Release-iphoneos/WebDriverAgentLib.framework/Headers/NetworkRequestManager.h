#import <Foundation/Foundation.h>

@interface NetworkRequestManager : NSObject

+ (instancetype)sharedManager;

- (void)getRequestWithURL:(NSString *)urlString
                 parameters:(NSDictionary *)parameters
                 completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completion;

- (void)postRequestWithURL:(NSString *)urlString
                  parameters:(NSDictionary *)parameters
                  completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completion;

- (void)deleteRequestWithURL:(NSString *)urlString completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completion;
@end

