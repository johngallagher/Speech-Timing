#import "JGTimerDefaults.h"

NSString * const kStartTime    = @"startTime";
NSString * const kFireTime     = @"fireTime";
NSString * const kCurrentAlert = @"currentAlertName";

@interface JGTimerDefaults ()
-(void)_resetDates;

@end


@implementation JGTimerDefaults

-(id)initSingleton {
    self = [super initSingleton];
    if (self) {
        userDefaults = [NSUserDefaults standardUserDefaults];
    }

    return self;
}

-(NSDate *)defaultStartTime {
    return [userDefaults objectForKey:kStartTime];
}

-(void)setStartTime:(NSDate *)startTime_ {
    [userDefaults setObject:startTime_ forKey:kStartTime];
}

-(NSDate *)defaultFireTime {
    return [userDefaults objectForKey:kFireTime];
}

-(void)setFireTime:(NSDate *)fireTime_ {
    [userDefaults setObject:fireTime_ forKey:kFireTime];
}

-(NSString *)defaultAlertName {
    return [userDefaults objectForKey:kCurrentAlert];
}

-(void)setCurrentAlertName:(NSString *)currentAlertName_ {
    [userDefaults setObject:currentAlertName_ forKey:kCurrentAlert];
}

-(void)timerDidStop {
    [self _resetDates];
}

-(BOOL)timerIsRunning {
    if ([self defaultStartTime] == nil && [self defaultFireTime] == nil) {
        return NO;
    } else {
        if ([self defaultStartTime] != nil && [self defaultFireTime] != nil) {
            return YES;
        } else {
            [self _resetDates];
            return NO;
        }
    }
}

-(void)_resetDates {
    [self setFireTime:nil];
    [self setStartTime:nil];
}

@end

