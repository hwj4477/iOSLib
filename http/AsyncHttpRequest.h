//
//  AsyncHttpRequest.h
//
//  Created by hwj4477 on 2014. 3. 26..
//

#import <Foundation/Foundation.h>

#define TIMEOUT_INTERVAL 5.0

typedef void (^completeBlock_t)(NSString *result);
typedef void (^errorBlock_t)(NSString *error);

@interface AsyncHttpRequest : NSObject{
    
    NSMutableData *receivedData;
    completeBlock_t completeBlock_;
    errorBlock_t errorBlock_;
}

+ (id)request:(NSString *)requestUrl
   parameters:(NSDictionary*)parameters
       header:(NSDictionary*)header
completeBlock:(completeBlock_t)completeBlock
   errorBlock:(errorBlock_t)errorBlock;

@end
