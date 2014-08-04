//
//  UserKeychain.h
//
//  Created by hwj4477 on 2014. 1. 28..
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"

@interface UserKeychain : NSObject{
    KeychainItemWrapper *keyChainWrapper;
}

+ (UserKeychain*)sharedInstance;
+ (void)disposeSharedInstance;

- (void)setUserId:(NSString*)userId;
- (void)setUserPass:(NSString*)UserPass;
- (NSString*)getUserId;
- (NSString*)getUserPass;

- (void)resetData;

@end
