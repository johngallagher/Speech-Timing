#import <Foundation/Foundation.h>
#import "JGAbstractSingletonObject.h"

@class JGAlert;
extern NSString * const kStartTime    ;
extern NSString * const kFireTime     ;
extern NSString * const kCurrentAlert ;

@interface JGTimerDefaults : JGAbstractSingletonObject {
    NSUserDefaults *userDefaults;
}

-(NSDate *)startTime;

-(void)setStartTime:(NSDate *)startTime_;

-(NSDate *)fireTime;

-(void)setFireTime:(NSDate *)fireTime_;

-(NSString *)alertName;

-(void)setCurrentAlertName:(NSString *)currentAlertName_;

-(void)timerDidStop;

-(BOOL)timerIsRunning;

-(JGAlert *)alert;

-(BOOL)currentTimeNearFireTime;

-(void)invalidateAlert;


@end