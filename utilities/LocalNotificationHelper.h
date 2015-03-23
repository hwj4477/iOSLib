//
//  LocalNotificationHelper.h
//
//  Created by hwj4477 on 13. 5. 13..
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LocalNotificationHelper : NSObject

+ (void)setLocalNotificationWithDate:(NSDate*)date
                             NotifId:(int)notifId
                                Data:(NSDictionary*)data
                                Body:(NSString*)body
                              Action:(NSString*)action;

+ (BOOL)cancelLocalNotificationWithType:(int)type;

@end
