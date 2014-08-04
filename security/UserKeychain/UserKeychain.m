//
//  UserKeychain.m
//
//  Created by hwj4477 2014. 1. 28..
//

#import "UserKeychain.h"

#define KEYCHAIN_ID         @"user_keychain"

static UserKeychain *instance = nil;

@implementation UserKeychain

+ (UserKeychain*)sharedInstance
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance = [[UserKeychain alloc] init];
        }
        
        return instance;
    }
    
    return nil;
}

+ (void)disposeSharedInstance
{
    @synchronized(self)
    {
        if(instance != nil)
        {
            [instance release];
            instance = nil;
        }
    }
}

- (id)init
{
	self = [super init];
	if( self != nil)
	{
        keyChainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:KEYCHAIN_ID accessGroup:nil];
	}
	return self;
}

- (void)setUserId:(NSString*)userId
{
    [keyChainWrapper setObject:userId forKey:kSecAttrAccount];
}

- (void)setUserPass:(NSString*)UserPass
{
    [keyChainWrapper setObject:UserPass forKey:kSecValueData];
}

- (NSString*)getUserId
{
    return [keyChainWrapper objectForKey:kSecAttrAccount];;
}

- (NSString*)getUserPass
{
    return [keyChainWrapper objectForKey:kSecValueData];
}

- (void)resetData
{
    [keyChainWrapper setObject:@"" forKey:kSecAttrAccount];
    [keyChainWrapper setObject:@"" forKey:kSecValueData];
}

- (void)dealloc
{
    [super dealloc];
    
    [keyChainWrapper release];
}

@end
