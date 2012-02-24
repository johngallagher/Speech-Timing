//
//  Created by John on 24/02/2012.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "JGAlertNotificationScheduler.h"
#import "JGAlert.h"
#import "JGTimerDefaults.h"


@interface JGAlertNotificationScheduler ()
-(void)scheduleNotificationForAlert:(JGAlert *)alert_;

@end

@implementation JGAlertNotificationScheduler

+(void)removeAllNotifications {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

+(void)scheduleNotification {
    JGAlertNotificationScheduler *sender = [[[[self class] alloc] init] autorelease];
    [sender scheduleNotificationForAlert:[[JGTimerDefaults sharedInstance] alert]];
}

-(void)scheduleNotificationForAlert:(JGAlert *)alert_ {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (localNotification == nil)
        return;
    
    localNotification.fireDate = [alert_ fireTime];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
 
    localNotification.alertBody = [NSString stringWithFormat:@"Time Up!"];
//    localNotification.alertAction = @""
 
    localNotification.soundName = UILocalNotificationDefaultSoundName;
//    localNotification.applicationIconBadgeNumber = 1;
 
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    [localNotification release];
}
@end