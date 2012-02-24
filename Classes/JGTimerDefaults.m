#import "JGTimerDefaults.h"
#import "JGAlert.h"

NSString * const kStartTime    = @"startTime";
NSString * const kFireTime     = @"fireTime";
NSString * const kCurrentAlert = @"currentAlertName";

@interface JGTimerDefaults ()
-(void)_resetDates;

-(double)magnitude:(NSTimeInterval)timeSinceFireTime;


@end


@implementation JGTimerDefaults

-(id)initSingleton {
    self = [super initSingleton];
    if (self) {
        userDefaults = [NSUserDefaults standardUserDefaults];
    }

    return self;
}

-(NSDate *)startTime {
    return [userDefaults objectForKey:kStartTime];
}

-(void)setStartTime:(NSDate *)startTime_ {
    [userDefaults setObject:startTime_ forKey:kStartTime];
}

-(NSDate *)fireTime {
    return [userDefaults objectForKey:kFireTime];
}

-(void)setFireTime:(NSDate *)fireTime_ {
    [userDefaults setObject:fireTime_ forKey:kFireTime];
}

-(NSString *)alertName {
    return [userDefaults objectForKey:kCurrentAlert];
}

-(void)setCurrentAlertName:(NSString *)currentAlertName_ {
    [userDefaults setObject:currentAlertName_ forKey:kCurrentAlert];
}

-(void)timerDidStop {
    [self _resetDates];
}

// Timer is running checks default start time and fire time and if they're inconsistent, it resets them both to nil.
-(BOOL)timerIsRunning {
    if ([self startTime] == nil && [self fireTime] == nil) {
        return NO;
    } else {
        if ([self startTime] != nil && [self fireTime] != nil) {
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

-(JGAlert *)alert {
    return [JGAlert alertWithStartTime:[self startTime] fireTime:[self fireTime] name:[self alertName]];
}

-(BOOL)currentTimeNearFireTime {
    NSTimeInterval timeSinceFireTime = [[self fireTime] timeIntervalSinceNow];
    return [self magnitude:timeSinceFireTime] < 0.1;
}

-(void)invalidateAlert {
    [self setFireTime:nil];
    [self setStartTime:nil];
}

-(double)magnitude:(NSTimeInterval)timeSinceFireTime {
    return sqrt(timeSinceFireTime * timeSinceFireTime);
}

@end

