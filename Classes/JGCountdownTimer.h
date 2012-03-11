#import <Foundation/Foundation.h>
#import "JGCountdownTimerDelegate.h"

@interface JGCountdownTimer : NSObject {
    NSTimer *_countdownTimer;
    id <NSObject, JGCountdownTimerDelegate> _delegate;
    NSDate *_timerEndDate;
}

@property(nonatomic, retain) NSDate *timerEndDate;

+(JGCountdownTimer *)timerStartingAt:(NSDate *)startTime_ withFireTime:(NSDate *)fireTime_ delegate:(id <JGCountdownTimerDelegate>)delegate_;

+(JGCountdownTimer *)timerStartingNowWithTimeInterval:(NSTimeInterval)i delegate:(id)o;

-(JGCountdownTimer *)initStartingAt:(NSDate *)startTime_ withFireTime:(NSDate *)fireTime_ delegate:(id <JGCountdownTimerDelegate>)delegate_;

-(void)startTimer;

-(void)stopTimer;


@end
