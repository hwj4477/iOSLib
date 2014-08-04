//
//  LocalNotificationHelper.m
//
//  Created by hwj4477 on 13. 5. 13..
//

#import "LocalNotificationHelper.h"

@implementation LocalNotificationHelper

+ (void)setLocalNotificationWithDate:(NSDate*)date
                             NotifId:(int)notifId
                                Data:(NSDictionary*)data
                                Body:(NSString*)body
                              Action:(NSString*)action
{
    [self cancelLocalNotificationWithType:notifId];

    UILocalNotification *localNotif = [[UILocalNotification alloc]init];
    
    // set time
    localNotif.fireDate = date;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    // setting
    localNotif.alertBody = body;
    localNotif.alertAction = action;
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    
    //Custom Data
    NSMutableDictionary *infoDict = [[[NSMutableDictionary alloc] init] autorelease];
    [infoDict setObject:[NSNumber numberWithInt:notifId] forKey:@"notif_id"];
    
    NSEnumerator *keyEnum = [data keyEnumerator];
    id key;
    
    while ((key = [keyEnum nextObject]))
    {
        id value = [data objectForKey:key];
        
        [infoDict setObject:value forKey:key];
    }
    
    localNotif.userInfo = infoDict;
    
    //Local Notification 등록
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
    [localNotif release];
}

+ (BOOL)cancelLocalNotificationWithType:(int)type
{
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    for(UILocalNotification *notif in notifications)
    {
        if([[notif.userInfo objectForKey:@"notif_id"] intValue] == type)
        {
            [[UIApplication sharedApplication] cancelLocalNotification:notif];
        }
    }
    
    return YES;
}

@end
