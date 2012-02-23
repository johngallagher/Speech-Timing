#import "JGTimerDefaults.h"
#import "JGAlert.h"

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
    NSString *_alertName = [userDefaults objectForKey:kCurrentAlert];
    if (_alertName) {
        return _alertName;
    } else {
        return @"Digital Alarm 1";
    }
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

-(void)invalidateAlert {
    [self setFireTime:nil];
    [self setStartTime:nil];
}

@end

