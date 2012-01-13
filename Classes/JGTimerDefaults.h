#import <Foundation/Foundation.h>
#import "JGAbstractSingletonObject.h"
extern NSString * const kStartTime    ;
extern NSString * const kFireTime     ;
extern NSString * const kCurrentAlert ;

@interface JGTimerDefaults : JGAbstractSingletonObject {
    NSUserDefaults *userDefaults;
}

-(NSDate *)defaultStartTime;

-(void)setStartTime:(NSDate *)startTime_;

-(NSDate *)defaultFireTime;

-(void)setFireTime:(NSDate *)fireTime_;

-(NSString *)defaultAlertName;

-(void)setCurrentAlertName:(NSString *)currentAlertName_;

-(void)timerDidStop;

-(BOOL)timerIsRunning;


@end